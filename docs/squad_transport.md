# squad_transport.script

Manages transport squad cargo assignments.

## Inputs
- `create(task)`
- `drop_cargo(squad)`

## Outputs
- Table representing a transport squad with `members` carrying cargo.

## Example State
```lua
squad = {resource="scrap", cargo=3, members={{carrying="scrap"},{carrying="scrap"}}}
```

## Expected Behavior
`create` spawns a squad table where each member holds one unit of cargo. `drop_cargo` empties the squad when defeated.

## Hooks
Used by `hq_coordinator.script` and combat logic when a transport squad is killed.
