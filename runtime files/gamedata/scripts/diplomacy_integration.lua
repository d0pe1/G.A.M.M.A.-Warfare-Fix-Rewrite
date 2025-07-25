--[[
    diplomacy_integration.lua
    -------------------------
    Provides simple tribute trade deals allowing factions to exchange
    spare resources. UI hooks may present proposals to the player.
    Last edit: 2025-07-25
]]

local diplomacy = {}

--- Offer a trade from one faction to another.
function diplomacy.offer_trade(from, to, resource, amount)
    return {from=from, to=to, resource=resource, amount=amount}
end

return diplomacy
