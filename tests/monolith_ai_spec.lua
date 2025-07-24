_G.printf = function() end
local node = dofile('gamma_walo/gamedata/scripts/node_system.script')
local pool = dofile('gamma_walo/gamedata/scripts/resource_pool.script')
local mono = dofile('gamma_walo/gamedata/scripts/monolith_ai.script')

describe('monolith_ai', function()
    before_each(function()
        node.nodes = {}
        pool.levels = {}
    end)

    it('selects raid target based on resources', function()
        node.register_node('n1'); node.capture_node('n1','duty'); node.specialize_node('n1','hq')
        node.register_node('r1'); node.capture_node('r1','duty'); node.establish_node('r1', node.STATE.resource); node.specialize_node('r1','scrap')
        node.register_node('r2'); node.capture_node('r2','freedom'); node.establish_node('r2', node.STATE.resource); node.specialize_node('r2','scrap')
        node.register_node('a1', node.STATE.artifact); node.capture_node('a1','duty')
        pool.update_from_nodes(node)
        local target = mono.select_target(node,pool)
        assert.is_truthy(target)
    end)
end)
