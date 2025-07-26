local f = assert(io.open('gamma_walo/gamedata/scripts/game_relations.script', 'r'))
local data = f:read('*all')
f:close()

describe('WALO-4 blacklist optimisations', function()
  it('does not use pair locals when checking blacklist pairs', function()
    assert.is_nil(string.find(data, 'local%s+pair%s*=%s*blacklist_pair'))
  end)

  it('indexes blacklist pairs directly', function()
    assert.is_not_nil(string.find(data, 'blacklist_pair%[i%]%[1%]'))
    assert.is_not_nil(string.find(data, 'blacklist_pair%[i%]%[2%]'))
  end)
end)
