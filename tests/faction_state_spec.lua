require('tests.spec_helper')
local node = require('node_system')
local state = require('faction_state')

describe('faction_state', function()
    before_each(function()
        node.nodes = {}
        state.hqs = {}
        state.collapsed = {}
    end)

    it('collapses faction when last hq removed', function()
        node.register_node('h1')
        node.capture_node('h1', 'duty')
        node.establish_node('h1', node.STATE.base)
        node.specialize_node('h1', 'hq')
        assert.is_false(state.is_collapsed('duty'))
        node.abandon_node('h1')
        assert.is_true(state.is_collapsed('duty'))
    end)
end)
