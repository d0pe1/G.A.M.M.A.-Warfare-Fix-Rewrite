-- Meta overlord tests
local overlord = dofile("gamma_walo/gamedata/scripts/meta_overlord.script")

describe('meta_overlord', function()
    before_each(function()
        overlord.events = {}
    end)

    it('schedules and retrieves events', function()
        overlord.schedule_event('raid', 'agroprom', 100)
        overlord.schedule_event('surge', 'cordon', 200)
        local e1 = overlord.next_event()
        assert.equals('raid', e1.type)
        local e2 = overlord.next_event()
        assert.equals('surge', e2.type)
        assert.is_nil(overlord.next_event())
    end)
end)
