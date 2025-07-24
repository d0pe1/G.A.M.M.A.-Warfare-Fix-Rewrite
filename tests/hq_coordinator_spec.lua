_G.printf = function() end
package.path = 'gamma_walo/gamedata/scripts/?.script;' .. package.path
local base = require('base_node_logic')
local res  = require('resource_system')
local node = require('node_system')
local hq   = require('hq_coordinator')

describe('hq_coordinator', function()
    before_each(function()
        base.bases = {}
        res.nodes = {}
        res.factions = {}
        hq.tasks = {}
        hq.bases_by_faction = {}
    end)

    it('queues transport tasks for shortages', function()
        base.register_base('b1','duty','militia')
        res.capture_node('n1','duty','scrap',3)
        hq.register_base('duty','b1')
        hq.evaluate('duty')
        assert.equals(1, #hq.tasks)
        assert.equals('n1', hq.tasks[1].from)
    end)

    it('upgrades bases when requirements met', function()
        node.nodes = {}
        node.register_node('b1')
        node.capture_node('b1','duty')
        node.establish_node('b1', node.STATE.base)
        node.specialize_node('b1', 'militia')
        base.register_base('b1','duty','militia')
        base.add_resource('b1','scrap',5)
        base.add_resource('b1','electronics',5)
        hq.register_base('duty','b1')
        hq.evaluate('duty')
        assert.equals(2, node.nodes['b1'].level)
    end)
end)
