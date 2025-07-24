-- Resource system unit tests
local resource = dofile("gamma_walo/gamedata/scripts/resource_system.script")

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
end)
