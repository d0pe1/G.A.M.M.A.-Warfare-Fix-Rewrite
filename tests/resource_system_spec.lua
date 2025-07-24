require('tests.spec_helper')
local resource = require('resource_system')

describe('resource_system', function()
    before_each(function()
        -- reset state
        resource.factions = {}
        resource.nodes = {}
    end)

    it('initializes faction pools', function()
        local pool = resource.init_faction('duty')
        assert.is.same({scrap=0, herbs=0, electronics=0, artifacts=0}, pool)
    end)

    it('captures nodes and grants resources', function()
        resource.capture_node('node1', 'duty', 'scrap', 5)
        assert.equals(5, resource.get_resource('duty', 'scrap'))
        assert.is.truthy(resource.nodes['node1'])
    end)

    it('consumes resources if available', function()
        resource.add_resource('duty', 'herbs', 3)
        assert.is_true(resource.consume_resource('duty', 'herbs', 2))
        assert.equals(1, resource.get_resource('duty', 'herbs'))
        assert.is_false(resource.consume_resource('duty', 'herbs', 5))
    end)

    it('applies upgrade levels to nodes', function()
        resource.capture_node('node2', 'duty', 'scrap', 0, 1)
        resource.apply_node_upgrade('node2', 2)
        assert.equals(2, resource.nodes['node2'].output)
        assert.equals(20, resource.nodes['node2'].capacity)
    end)

    it('depletes nodes when remaining reaches zero', function()
        local node_sys = require('node_system')
        node_sys.register_node('node3')
        node_sys.capture_node('node3', 'duty')
        node_sys.establish_node('node3', node_sys.STATE.resource)
        node_sys.specialize_node('node3', 'scrap')
        resource.nodes['node3'].remaining = 1
        resource.tick_daily()
        resource.withdraw_from_node('node3', 1)
        assert.is_true(resource.nodes['node3'].depleted)
        assert.equals(node_sys.STATE.territory, node_sys.get_node_type('node3'))
    end)
end)
