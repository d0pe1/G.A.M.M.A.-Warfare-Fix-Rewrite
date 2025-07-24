package.path = 'gamma_walo/gamedata/scripts/?.script;' .. package.path

local node   = require('node_system')
local pool   = require('resource_system')
local base   = require('base_node_logic')
local hq     = require('hq_coordinator')
local spawn  = require('squad_spawn_system')
local daily  = require('daily_sim_engine')
local diplomacy = require('diplomacy_core')

_G.printf = function() end

describe('daily_sim_engine', function()
    before_each(function()
        node.nodes = {}
        pool.factions = {}
        pool.nodes = {}
        base.bases = {}
        hq.tasks = {}
        hq.bases_by_faction = {}
        spawn.cooldown = {}
        diplomacy.offers = {}
    end)

    it('ticks production and schedules transports', function()
        node.register_node('n1')
        node.capture_node('n1', 'duty')
        node.establish_node('n1', node.STATE.resource)
        node.specialize_node('n1', 'scrap')
        base.register_base('b1','duty','militia')
        pool.factions['duty'] = {armor=1, weapons=2, scrap=0, herbs=0, electronics=0, artifacts=0}
        daily.run_day()
        assert.equals(1, pool.nodes['n1'].stock)
        assert.equals(1, #hq.tasks)
    end)
end)
