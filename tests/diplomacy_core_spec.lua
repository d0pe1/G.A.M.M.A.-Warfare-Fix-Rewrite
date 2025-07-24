_G.printf = function() end
local pool = dofile('gamma_walo/gamedata/scripts/resource_pool.script')
local dip = dofile('gamma_walo/gamedata/scripts/diplomacy_core.script')

describe('diplomacy_core', function()
    before_each(function()
        pool.levels = {duty={scrap=0,herbs=0,electronics=0,artifacts=0}}
        dip.offers = {}; dip.history = {}
    end)

    it('generates trade offers when lacking resources', function()
        dip.evaluate('duty', pool)
        assert.is.truthy(dip.offers.duty)
        dip.accept_offer('duty')
        assert.equals(1, #dip.history)
    end)
end)
