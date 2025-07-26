local file = assert(io.open('gamma_walo/gamedata/scripts/dialogs.script'))
local content = file:read('*all')
file:close()

-- load script in global environment
package.path = package.path .. ';gamma_walo/gamedata/scripts/?.script'
dofile('gamma_walo/gamedata/scripts/dialogs.script')


describe('dialogs.warfare_disabled', function()
    it('returns false when warfare active', function()
        _G.WARFARE = true
        assert.is_false(warfare_disabled(nil, nil))
    end)

    it('returns true when warfare inactive', function()
        _G.WARFARE = nil
        assert.is_true(warfare_disabled(nil, nil))
    end)
end)

describe('important_docs table', function()
    it('contains main quest document entries', function()
        assert.is_truthy(content:find('main_story_1_quest_case'))
        assert.is_truthy(content:find('main_story_7_mon_con_documents'))
    end)
end)
