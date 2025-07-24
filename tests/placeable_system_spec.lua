-- Placeable system tests
local resource = dofile("gamma_walo/gamedata/scripts/resource_system.script")
local placeable = dofile("gamma_walo/gamedata/scripts/placeable_system.script")

describe('placeable_system', function()
    before_each(function()
        resource.factions = {}
        placeable.built = {}
    end)

    it('fails to build without resources', function()
        assert.is_false(placeable.build('freedom', 'armoury', resource))
    end)

    it('builds structure and consumes resources', function()
        resource.add_resource('freedom', 'scrap', 10)
        resource.add_resource('freedom', 'electronics', 5)
        assert.is_true(placeable.build('freedom', 'armoury', resource))
        assert.equals(5, resource.get_resource('freedom', 'scrap'))
        assert.equals(3, resource.get_resource('freedom', 'electronics'))
        assert.equals(1, placeable.built.freedom.armoury)
    end)
end)
