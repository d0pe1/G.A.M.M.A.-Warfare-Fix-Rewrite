describe('WALO-8 ui_options tweaks', function()
  local f = assert(io.open('gamma_walo/gamedata/scripts/ui_options.script', 'r'))
  local data = f:read('*all')
  f:close()

  it('caps FOV max at 140', function()
    assert.is_not_nil(string.find(data, 'id= "fov".-max= 140'))
  end)

  it('includes thirst and sleep options', function()
    assert.is_not_nil(data:find('id= "thirst"'))
    assert.is_not_nil(data:find('id= "sleep"'))
  end)
end)
