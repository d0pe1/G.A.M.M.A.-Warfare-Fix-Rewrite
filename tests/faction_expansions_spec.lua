package.path = package.path .. ';gamma_walo/gamedata/scripts/?.script'

-- provide minimal clsid table required by the script
_G.clsid = setmetatable({}, { __index = function() return 0 end })

-- load script into environment
_dofile = dofile
_dofile('gamma_walo/gamedata/scripts/faction_expansions.script')

describe('faction_expansions spawn chance formulas', function()
    before_each(function()
        _G.warfare = { resource_count = 10 }
    end)

    it('advanced chance scales with resources', function()
        assert.is_same(0, get_advanced_chance(0))
        assert.is_true(math.abs(get_advanced_chance(10) - 150) < 0.001)
    end)

    it('veteran chance scales quadratically', function()
        assert.is_same(0, get_veteran_chance(0))
        assert.is_true(math.abs(get_veteran_chance(10) - 100) < 0.001)
    end)
end)
