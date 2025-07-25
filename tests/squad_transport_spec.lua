package.path = 'gamma_walo/gamedata/scripts/?.script;' .. package.path
local transport = require('squad_transport')

describe('squad_transport', function()
    it('creates squad with cargo per member', function()
        local sq = transport.create{from='n1', to='b1', resource='scrap', amount=2}
        assert.equals(2, #sq.members)
        assert.equals('scrap', sq.members[1].carrying)
    end)

    it('drops cargo on defeat', function()
        local sq = transport.create{from='n1', to='b1', resource='scrap', amount=2}
        local drop = transport.drop_cargo(sq)
        assert.equals(2, drop)
        assert.equals(0, sq.cargo)
    end)

    it('reroutes to alternate base on danger', function()
        transport.hq = {bases_by_faction = {duty={'b1','b2'}}}
        local sq = transport.create{from='n1', to='b1', faction='duty', resource='scrap', amount=2}
        transport.mark_danger(sq)
        assert.equals('b2', sq.to)
    end)
end)
