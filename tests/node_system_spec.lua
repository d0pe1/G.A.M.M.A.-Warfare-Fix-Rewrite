require('tests.spec_helper')
local node = require('node_system')
local pool = require('resource_pool')
local res  = require('resource_system')

describe('node_system', function()
    before_each(function()
        node.nodes = {}
        pool.levels = {}
        res.nodes = {}
        res.factions = {}
    end)

    it('captures and specializes nodes', function()
        node.register_node('n1')
        node.capture_node('n1', 'duty')
        node.establish_node('n1', node.STATE.resource)
        node.specialize_node('n1', 'scrap')
        node.tick_production(pool, res)
        assert.equals(1, pool.get_resource('duty', 'scrap'))
        assert.equals(1, res.nodes['n1'].stock)
    end)

    it('upgrades resource nodes and updates output', function()
        node.register_node('n2')
        node.capture_node('n2', 'duty')
        node.establish_node('n2', node.STATE.resource)
        node.specialize_node('n2', 'scrap')
        node.upgrade_node('n2')
        assert.equals(2, res.nodes['n2'].output)
        node.tick_production(pool, res)
        assert.equals(2, res.nodes['n2'].stock)
    end)
end)
