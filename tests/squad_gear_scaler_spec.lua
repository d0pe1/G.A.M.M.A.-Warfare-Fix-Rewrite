_G.printf = function() end
local pool = dofile('gamma_walo/gamedata/scripts/resource_pool.script')
local scaler = dofile('gamma_walo/gamedata/scripts/squad_gear_scaler.script')

describe('squad_gear_scaler', function()
    before_each(function() pool.levels = {duty={scrap=0,herbs=0,electronics=0,artifacts=0}} end)

    it('scales squad tier by scrap amount', function()
        local squad = {id='s1'}
        scaler.apply_loadout(squad, 'duty', pool)
        assert.equals(1, squad.tier)
        pool.levels.duty.scrap = 4
        scaler.apply_loadout(squad, 'duty', pool)
        assert.equals(2, squad.tier)
    end)
end)
