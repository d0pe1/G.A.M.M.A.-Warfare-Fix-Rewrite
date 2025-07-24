_G.printf = function() end
package.path = 'gamma_walo/gamedata/scripts/?.script;' .. package.path
local pool = require('resource_system')
local base = require('base_node_logic')
local spawn = require('squad_spawn_system')

describe('squad_spawn_system', function()
    before_each(function()
        pool.factions = {}
        base.bases = {}
        spawn.cooldown = {}
    end)

    it('prevents spawn without base resources', function()
        pool.init_faction('duty')
        base.register_base('b1','duty','militia')
        pool.add_resource('duty','armor',1)
        pool.add_resource('duty','weapons',2)
        local sq = spawn.spawn_squad('duty','patrol',pool,'b1')
        assert.is_nil(sq)
        base.add_resource('b1','scrap',1)
        base.add_resource('b1','herbs',1)
        sq = spawn.spawn_squad('duty','patrol',pool,'b1')
        assert.is_table(sq)
    end)
end)
