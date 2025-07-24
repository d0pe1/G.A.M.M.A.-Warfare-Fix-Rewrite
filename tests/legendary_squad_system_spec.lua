-- Legendary squad system tests
local legendary = dofile("gamma_walo/gamedata/scripts/legendary_squad_system.script")

describe('legendary_squad_system', function()
    before_each(function()
        legendary.squads = {}
    end)

    it('promotes squad when enough experience is gained', function()
        legendary.add_experience('squad1', 50)
        assert.equals('rookie', legendary.get_rank('squad1'))
        legendary.add_experience('squad1', 60)
        assert.equals('seasoned', legendary.get_rank('squad1'))
    end)
end)
