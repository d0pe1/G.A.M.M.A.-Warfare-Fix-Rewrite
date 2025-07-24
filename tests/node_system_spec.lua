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
end)
