package.path = 'gamma_walo/gamedata/scripts/?.script;' .. package.path
local recovery = require('squad_loot_recovery')
local resource = require('resource_system')

describe('squad_loot_recovery', function()
    before_each(function()
        recovery.dropped = {}
        resource.factions = {}
    end)

    it('records cargo on member death', function()
        local npc = {carrying='scrap', position={x=0,y=0,z=0}}
        recovery.on_npc_death(npc, nil)
        assert.equals(1, #recovery.dropped)
        assert.equals('scrap', recovery.dropped[1].resource)
    end)

    it('patrol collects nearby loot', function()
        resource.init_faction('duty')
        local npc = {carrying='electronics', position={x=0,y=0,z=0}}
        recovery.on_npc_death(npc, nil)

        local squad = {faction='duty', position={x=1,y=0,z=1}}
        recovery.collect_nearby_loot(squad)

        assert.equals(1, resource.get_resource('duty', 'electronics'))
        assert.equals(0, #recovery.dropped)
    end)
end)
