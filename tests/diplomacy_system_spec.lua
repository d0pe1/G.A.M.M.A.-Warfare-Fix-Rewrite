-- Diplomacy system tests
local diplomacy = dofile("gamma_walo/gamedata/scripts/diplomacy_system.script")

describe('diplomacy_system', function()
    before_each(function()
        diplomacy.relations = {}
        diplomacy.requests = {}
    end)

    it('sets and gets relations symmetrically', function()
        diplomacy.set_relation('duty', 'freedom', diplomacy.STATUS.enemy)
        assert.equals(diplomacy.STATUS.enemy, diplomacy.get_relation('duty', 'freedom'))
        assert.equals(diplomacy.STATUS.enemy, diplomacy.get_relation('freedom', 'duty'))
    end)

    it('queues and pops requests', function()
        diplomacy.add_request('duty', {from = 'freedom', text = 'assist'})
        local list = diplomacy.pop_requests('duty')
        assert.equals(1, #list)
        assert.is_true(#diplomacy.pop_requests('duty') == 0)
    end)
end)
