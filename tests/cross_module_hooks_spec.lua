require('tests.spec_helper')
local phil = require('faction_philosophy')
local node = require('node_system')
local pool = require('resource_system')
local ai   = require('faction_ai_logic')
local spawn = require('squad_spawn_system')

describe('cross module hooks', function()
    before_each(function()
        node.nodes = {}
        pool.factions = {}
        pool.nodes = {}
        require('resource_pool').levels = {}
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

    it('resource nodes tick production', function()
        node.register_node('n2')
        node.capture_node('n2', 'duty')
        node.establish_node('n2', node.STATE.resource)
        node.specialize_node('n2', 'scrap')
        node.tick_production(require('resource_pool'), pool)
        assert.equals(1, pool.nodes['n2'].stock)
    end)
end)
