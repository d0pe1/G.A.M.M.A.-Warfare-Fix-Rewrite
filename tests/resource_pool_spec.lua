_G.printf = function() end
local node = dofile('gamma_walo/gamedata/scripts/node_system.script')
local pool = dofile('gamma_walo/gamedata/scripts/resource_pool.script')

describe('resource_pool', function()
    before_each(function()
        node.nodes = {}
        pool.levels = {}
    end)

    it('recalculates levels from nodes', function()
        node.register_node('n1')
        node.capture_node('n1', 'duty')
        node.establish_node('n1', node.STATE.resource)
        node.specialize_node('n1', 'scrap')
        pool.update_from_nodes(node)
        assert.equals(1, pool.get_resource('duty','scrap'))
    end)
end)
