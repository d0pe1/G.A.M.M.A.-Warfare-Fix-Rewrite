package.path = package.path .. ';gamma_walo/gamedata/scripts/?.script'

-- simply read the file text to verify loop hardening
local file = assert(io.open('gamma_walo/gamedata/scripts/sim_offline_combat.script'))
local content = file:read('*all')
file:close()

describe('sim_offline_combat hardening', function()
    it('uses pairs loops for smart_terrain scanning', function()
        assert.is_nil(content:match('ipairs%(%s*tbl_smart'))
    end)

    it('does not wait for SIMBOARD initialization', function()
        assert.is_nil(content:match('SIMBOARD and SIMBOARD%.smarts'))
    end)
end)
