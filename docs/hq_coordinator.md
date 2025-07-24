# hq_coordinator.script

Oversees logistics for each faction.

## Inputs
- `register_base(faction, base_id)`
- `evaluate(faction)`

## Outputs
- `tasks` list of scheduled transport orders.

## Example State
```lua
tasks = {
  {from="agroprom_scrap", to="bar", resource="scrap", amount=1}
}
```

## Expected Behavior
`evaluate` scans registered bases and queues transport tasks for any resource shortage.

## Hooks
Used by `squad_transport.script` to create transport squads.
