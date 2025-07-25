# 📑 Changelog

All notable changes to this project will be documented in this file.

## [Unreleased]
### Added
- `CHANGELOG.md` to track repository progress.
- Verbose debug logging via `verbose_logs` setting.
- Modular logistics system:
  - `base_node_logic.script` for base stockpiles
  - `hq_coordinator.script` to queue transports
  - `squad_transport.script` implementing cargo squads
  - Extended `resource_system.script` with production and node lookup
- `diplomacy_integration.lua` for trade offers
- Resource node upgrade levels configurable via `resource_upgrades.ltx`
- Added `upgrade_selected_node` stub in `ui_pda_warfare_tab.script`

### Improved
- `sim_offline_combat.script` hardening:
  - Added nil check when retrieving smart terrain data.
  - Replaced `pairs` with `ipairs` for sequential tables.
  - Recalculated `lid_1` per squad to avoid cross-level mismatches.
- Verbose logger now loaded relative to `warfare.script` for proper runtime path.
- Added package path initialization in `warfare.script` to load custom modules.

### Gameplay Expansion
- Introduced `resource_system.script` providing faction resource pools and node capture logic.
- Added `placeable_system.script` allowing factions to construct infrastructure using resources.
- Implemented `diplomacy_system.script` with symmetric relations and request queues.
- Created `legendary_squad_system.script` to track squad experience and rank progression.
- Added `meta_overlord.script` for scheduling antagonist events.
- New `ui_pda_diplomacy.script` generates diplomacy status lists for the PDA.
- Implemented node designation framework under `node_system.script` with hooks.
- Added `resource_pool.script` now tracking per-faction resource levels instead of consumable totals.
- Created `faction_ai_logic.script` automating NPC node specialisation.
- Updated `faction_ai_logic.script` to use faction bias tables and lowest-resource logic.
- Added `squad_gear_scaler.script` for loadout scaling based on resources.
- Gear scaling thresholds now use resource node counts rather than currency.
- Added `pda_context_menu.script` exposing Establish/Specialize/Upgrade actions.
- Implemented `monolith_ai.script` to raid dominant factions.
- Implemented `diplomacy_core.script` generating trade offers from shortages.
- Trade offers now trigger when a faction completely lacks a resource type.

### Testing
- Expanded coverage with additional stub specs; 32 assertions pass with 9 pending modules.
- Added Busted unit tests covering new systems under `tests/`.

### Integration
- Added cross-module accessors and new squad_spawn_system.
- AI, diplomacy and PDA menu now consult faction_philosophy.

### Docs
- Documented new systems in `docs/` directory.
- Added automated diff report under `docs/runtime_vs_gamma_walo.md`.
- Generated API index `docs/api_map.md`.
- Updated README and agent workflow guidelines.
- Integrated resource nodes with base and spawn logic; added daily production tick.

- Added daily_sim_engine with daily cycle logic and new tests.
- Added faction_state system tracking HQs and collapse.
\n- Added HQ logistics upgrade prioritization logic and base upgrade tests.
- Fixed Windows path escapes in `game_relations.script` preventing Lua load error.
- Added `generate_diff_summary.py` tool producing `diff_summary.json` for Pass 1 static validation.
- Generated `docs/function_compat_report.md` for Pass 2 signature and callsite audit.
- Pass 3 root cause fixes removing unnecessary nil guards.
