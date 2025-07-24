# base_node_logic.script

Maintains resource stockpiles for each base node.

## Inputs
- `register_base(id, owner, type)`
- `add_resource(id, rtype, amount)`
- `consume(id)`

## Outputs
- Updates `bases` table with stockpile levels.

## Example State
```lua
bases = {
  bar = {owner="duty", type="militia", stockpile={scrap=2, herbs=1}}
}
```

## Expected Behavior
Daily calls to `consume` deduct resources based on base type. If resources are insufficient the function returns `false`.

## Hooks
Called by `hq_coordinator.script` when scheduling transports and by `squad_spawn_system.script` when spawning squads.
