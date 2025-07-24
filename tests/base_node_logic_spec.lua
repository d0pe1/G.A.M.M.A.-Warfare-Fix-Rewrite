package.path = 'gamma_walo/gamedata/scripts/?.script;' .. package.path
local base = require('base_node_logic')

describe('base_node_logic', function()
    before_each(function() base.bases = {} end)

    it('adds and consumes resources', function()
        base.register_base('b1','duty','militia')
        base.add_resource('b1','scrap',2)
        base.add_resource('b1','herbs',2)
        assert.is_true(base.consume('b1'))
        assert.equals(1, base.bases['b1'].stockpile.scrap)
    end)
end)
