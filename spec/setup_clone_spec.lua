describe('SETUP-3 baseline copy', function()
  it('copies dialogs.script to gamma_walo unchanged', function()
    local function read(path)
      local f = assert(io.open(path, 'r'))
      local data = f:read('*all')
      f:close()
      return data
    end
    local base = read('runtime files/gamedata/scripts/dialogs.script')
    local clone = read('gamma_walo/gamedata/scripts/dialogs.script')
    assert.are.equal(base, clone)
  end)
end)
