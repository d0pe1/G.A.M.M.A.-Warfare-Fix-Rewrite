_G.printf = function() end
local node = dofile('gamma_walo/gamedata/scripts/node_system.script')
local pool = dofile('gamma_walo/gamedata/scripts/resource_pool.script')

describe('node_system', function()
    before_each(function()
        node.nodes = {}
        pool.levels = {}
    end)

    it('captures and specializes nodes', function()
        node.register_node('n1')
        node.capture_node('n1', 'duty')
        node.establish_node('n1', node.STATE.resource)
        node.specialize_node('n1', 'scrap')
        node.tick_production(pool)
        assert.equals(1, pool.get_resource('duty', 'scrap'))
    end)
end)
