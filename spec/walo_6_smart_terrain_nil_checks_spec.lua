describe('WALO-6 smart_terrain nil checks', function()
  local f = assert(io.open('gamma_walo/gamedata/scripts/smart_terrain_warfare.script', 'r'))
  local data = f:read('*all')
  f:close()

  it('checks for targets nil guard', function()
    assert.is_not_nil(data:find('if targets and #targets > 0'))
  end)

  it('returns nil for monster faction', function()
    assert.is_not_nil(data:find('if %(faction == "monster"%) then%s*return'))
  end)
end)
