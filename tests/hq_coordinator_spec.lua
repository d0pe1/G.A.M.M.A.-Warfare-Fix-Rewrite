_G.printf = function() end
package.path = 'gamma_walo/gamedata/scripts/?.script;' .. package.path
local base = require('base_node_logic')
local res  = require('resource_system')
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
end)
