# 📡 System Interactions & Integration Blueprint

## 🎯 Purpose

Define how Warfare's subsystems (nodes, factions, squads, AI, diplomacy, UI) connect and interact to support emergent gameplay, modularity, and long-term extensibility.

...

## 🧩 Suggested Build Order

1. `node_system.lua`
2. `resource_pool.lua`
3. `faction_ai_logic.lua`
4. `squad_gear_scaler.lua`
5. `pda_context_menu.lua`
6. `monolith_ai.lua`
7. `diplomacy_core.lua`

`resource_pool.lua` keeps per-faction resource **levels** calculated from
specialized nodes. `node_system.tick_production` calls `resource_pool.update_from_nodes`
so that gear scaling and diplomacy can read the latest values.

## 🔌 Standard Event Hooks

Mods can listen to the following hooks to extend functionality:

```lua
on_node_captured(node_id, faction_id)
on_node_specialized(node_id, specialization)
on_tick_resource_production()
on_tick_squad_training()
on_ai_decide_designation(node_id)
on_faction_raid_trigger(faction_id, target_node)
```

Each hook is fired by the corresponding module at key decision points allowing
other scripts to inject custom logic or effects.


## 🔗 Cross Module Accessors

The following helper functions allow systems to query shared state:

| Module | Function | Description |
|-------|----------|-------------|
| faction_philosophy | `get_faction_priorities(id)` | Ordered list of desired resources |
| faction_philosophy | `get_faction_aggression(id)` | Aggression factor 0-1 |
| resource_system | `get_faction_resource(faction_id, res_type)` | Current resource level |
| resource_system | `modify_faction_resource(faction_id, delta_table)` | Apply resource deltas |
| node_system | `get_node_type(node_id)` | Returns node state |
| node_system | `get_node_specialization(node_id)` | Returns specialization |
| diplomacy_core | `can_trade(faction_a, faction_b, res)` | Checks diplomacy threshold |
| diplomacy_core | `propose_trade(faction_a, faction_b)` | Records a trade offer |
| squad_spawn_system | `can_spawn_squad(faction_id)` | Tests resource requirements |
| squad_spawn_system | `spawn_squad(faction_id, squad_type)` | Spawns a squad table |

These APIs keep modules loosely coupled while sharing essential data.
