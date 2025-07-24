# diplomacy_integration.lua

Enables basic trade deals between factions for spare resources.

## Inputs
- `offer_trade(from, to, resource, amount)`

## Outputs
- Table describing the proposed deal.

## Example State
```lua
{from="duty", to="freedom", resource="scrap", amount=2}
```

## Expected Behavior
The returned table can be displayed in UI and later executed by other systems.

## Hooks
Planned integration with PDA diplomacy dialogs.
