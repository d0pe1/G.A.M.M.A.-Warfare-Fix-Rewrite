_G.printf = function() end
local phil = dofile('gamma_walo/gamedata/scripts/faction_philosophy.script')
local node = dofile('gamma_walo/gamedata/scripts/node_system.script')
local pool = dofile('gamma_walo/gamedata/scripts/resource_system.script')
local ai   = dofile('gamma_walo/gamedata/scripts/faction_ai_logic.script')
local spawn = dofile('gamma_walo/gamedata/scripts/squad_spawn_system.script')

describe('cross module hooks', function()
    before_each(function()
        node.nodes = {}
        pool.levels = {}
    end)

    it('ai designates captured nodes using philosophy', function()
        node.register_node('n1')
        node.capture_node('n1', 'duty')
        ai.handle_capture('n1', node, pool)
        assert.equals('resource', node.get_node_type('n1'))
        assert.equals(phil.get_faction_priorities('duty')[1], node.get_node_specialization('n1'))
    end)

    it('spawn system consumes resources', function()
        pool.add_resource('duty', 'armor', 1)
        pool.add_resource('duty', 'weapons', 2)
        assert.is_true(spawn.can_spawn_squad('duty', pool))
        local sq = spawn.spawn_squad('duty', 'infantry', pool)
        assert.is.table(sq)
        assert.equals(0, pool.get_resource('duty','armor'))
    end)
end)
