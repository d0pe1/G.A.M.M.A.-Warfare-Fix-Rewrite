local f = assert(io.open('gamma_walo/gamedata/scripts/sim_offline_combat.script', 'r'))
local data = f:read('*all')
f:close()

describe('WALO-5 sim_offline_combat optimisations', function()
  it('uses cached level id loop', function()
    assert.is_not_nil(string.find(data, 'lid_1%s*=%s*lid_1%s*or'))
  end)

  it('removes squad cap debug logic', function()
    assert.is_nil(string.find(data, 'limit_by_level'))
    assert.is_nil(string.find(data, 'count_by_level'))
  end)
end)
