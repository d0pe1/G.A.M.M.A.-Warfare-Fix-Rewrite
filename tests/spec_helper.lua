local root = debug.getinfo(1, 'S').source:match('@(.*)tests/spec_helper.lua$') or './'
package.path = table.concat({
    root .. 'tests/?.lua',
    root .. 'gamma_walo/gamedata/scripts/?.script',
    root .. 'gamma_walo/gamedata/scripts/?.lua',
    package.path
}, ';')

-- Provide stub printf used by scripts when running under Busted
_G.printf = _G.printf or function() end
