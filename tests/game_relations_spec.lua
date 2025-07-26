package.path = package.path .. ';gamma_walo/gamedata/scripts/?.script'

-- provide minimal engine stubs used during script loading
_G.printf = function() end
_G.system_ini = function()
    return { section_exist = function() return true end }
end
_G.ini_file = function()
    return {
        section_exist = function() return true end,
        line_exist = function() return false end,
        line_count = function(_, section)
            if section == 'unaffected_pairs' then return 1 end
            return 0
        end,
        r_float = function() return 0 end,
        r_s32 = function() return 0 end,
        r_float_ex = function() return 0 end,
        r_s32_ex = function() return 0 end,
        r_string_ex = function() return '' end,
        r_line = function(_, section, index)
            if section == 'unaffected_pairs' then
                return true, 'pair', 'duty,freedom'
            end
            return true, '', ''
        end
    }
end

-- basic utility used by game_relations during init
_G.str_explode = function(str, sep)
    local t = {}
    sep = sep or ','
    for part in string.gmatch(str .. sep, '(.-)' .. sep) do
        if part ~= '' then t[#t+1] = part end
    end
    return t
end

dofile('gamma_walo/gamedata/scripts/game_relations.script')

describe('game_relations blacklist checks', function()
    it('detects unaffected pair', function()
        assert.is_true(is_faction_pair_unaffected('duty','freedom'))
    end)

    it('relation allowed blocks blacklisted pair', function()
        assert.is_false(is_relation_allowed('duty','freedom'))
    end)
end)
