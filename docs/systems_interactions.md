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
