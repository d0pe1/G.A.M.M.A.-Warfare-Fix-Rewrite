local root = debug.getinfo(1, 'S').source:match('@(.*)tests/spec_helper.lua$') or './'
package.path = table.concat({
    root .. 'tests/?.lua',
    root .. 'gamma_walo/gamedata/scripts/?.script',
    root .. 'gamma_walo/gamedata/scripts/?.lua',
    package.path
}, ';')

-- Provide stub printf used by scripts when running under Busted
_G.printf = _G.printf or function() end
-- Generic stubs for engine functions used in unit tests
_G.ui_options = _G.ui_options or { get = function() return nil end }
_G.ini_file = _G.ini_file or function(path)
    return {
        section_exist = function() return false end,
        line_exist = function() return false end,
        r_float = function() return 0 end,
        r_s32 = function() return 0 end,
        r_string_ex = function() return '' end,
        r_line_ex = function() return nil,nil,'' end,
        section_for_each = function() end
    }
end
_G.system_ini = _G.system_ini or function() return {section_exist=function() return false end} end
_G.RegisterScriptCallback = _G.RegisterScriptCallback or function() end
_G.actor_menu = _G.actor_menu or { set_msg=function() end }
_G.game_statistics = _G.game_statistics or { has_actor_achievement=function() return false end }
_G.dialogs = _G.dialogs or { actor_true_monolith=function() return false end }
_G.level = _G.level or { name=function() return '' end }
_G.game = _G.game or { translate_string=function(s) return s end }
_G.class = _G.class or function(name) return function(base) local t=base or {}; t.__index=t; _G[name]=t; return t end end
_G.CUIScriptWnd = _G.CUIScriptWnd or {}
_G.alife = _G.alife or function() return {actor=function() return {position={x=0,y=0,z=0}} end} end
_G.alife_object = _G.alife_object or function() return {community=function() return '' end} end
_G.game_graph = _G.game_graph or function() return {vertex=function() return {level_id=function() return 0 end} end} end
_G.smart_terrain_warfare = _G.smart_terrain_warfare or {}
_G.SIMBOARD = _G.SIMBOARD or {}
