_G.printf = function() end
local node = dofile('gamma_walo/gamedata/scripts/node_system.script')
local menu = dofile('gamma_walo/gamedata/scripts/pda_context_menu.script')

local function contains(t,val)
    for _,v in ipairs(t) do
        if v==val then return true end
    end
    return false
end

describe('pda_context_menu', function()
    before_each(function() node.nodes = {} end)

    it('shows establish option for territory', function()
        node.register_node('n1')
        node.capture_node('n1','player')
        local opts = menu.get_options('n1','player',node)
        assert.is_true(contains(opts,'Designate Node Type'))
    end)
end)
