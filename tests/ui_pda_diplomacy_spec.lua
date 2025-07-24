-- UI diplomacy tab tests
local diplomacy = dofile("gamma_walo/gamedata/scripts/diplomacy_system.script")
local ui = dofile("gamma_walo/gamedata/scripts/ui_pda_diplomacy.script")

describe('ui_pda_diplomacy', function()
    before_each(function()
        diplomacy.relations = {}
    end)

    it('generates status list from relations', function()
        diplomacy.set_relation('duty', 'freedom', diplomacy.STATUS.enemy)
        local list = ui.generate_status_list(diplomacy)
        assert.is_true(#list > 0)
        assert.is.truthy(string.find(list[1], 'duty'))
    end)
end)
