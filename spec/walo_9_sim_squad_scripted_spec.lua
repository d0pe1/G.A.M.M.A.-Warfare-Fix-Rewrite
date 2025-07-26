describe('WALO-9 scripted squad target fix', function()
  local f = assert(io.open('gamma_walo/gamedata/scripts/sim_squad_scripted.script', 'r'))
  local data = f:read('*all')
  f:close()

  it('uses obj clsid validation', function()
    assert.is_not_nil(string.find(data, 'obj:clsid%(%).*online_offline_group_s'))
  end)

end)
