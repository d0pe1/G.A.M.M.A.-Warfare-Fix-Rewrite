_G.printf = function() end
local node = dofile('gamma_walo/gamedata/scripts/node_system.script')
local pool = dofile('gamma_walo/gamedata/scripts/resource_pool.script')
local ai = dofile('gamma_walo/gamedata/scripts/faction_ai_logic.script')

describe('faction_ai_logic', function()
    before_each(function()
        node.nodes = {}
        pool.levels = {duty={scrap=0,herbs=0,electronics=0,artifacts=0}}
    end)

    it('designates captured nodes', function()
        node.register_node('n1')
        node.capture_node('n1','duty')
        ai.handle_capture('n1', node, pool)
        local n = node.get_node('n1')
        assert.equals(node.STATE.resource, n.state)
        assert.is_truthy(n.specialization)
    end)
end)
