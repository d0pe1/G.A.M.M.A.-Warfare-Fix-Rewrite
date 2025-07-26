local path = 'gamma_walo/gamedata/scripts/faction_expansions.script'
local f = assert(io.open(path, 'r'))
local data = f:read('*all')
f:close()

describe('WALO-3 spawn chance formulas', function()
  it('uses simplified advanced chance formula', function()
    assert.is_true(data:find('return%+?%s*150%s*%*%s*%(') ~= nil)
    assert.is_true(data:find('math%.pow%(%(resource%s*/%s*warfare%.resource_count%)%s*,%s*0%.8%)') ~= nil)
  end)

  it('uses simplified veteran chance formula', function()
    assert.is_true(data:find('return%+?%s*100%s*%*%s*%(') ~= nil)
    assert.is_true(data:find('math%.pow%(%(resource%s*/%s*warfare%.resource_count%)%s*,%s*2%)') ~= nil)
  end)

  it('does not contain old quadratic formula uncommented', function()
    assert.is_nil(data:match('\n%s*return%s+%-1'))
    assert.is_nil(data:match('\n%s*return%s+%-100'))
  end)
end)
