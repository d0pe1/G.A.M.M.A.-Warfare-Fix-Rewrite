# 📜 G.A.M.M.A. Warfare Fix – Modmap

This document maps each Lua script to its core role in the AI warfare system.

| Script File | Role Summary |

|-------------|--------------|
| `warfare.script` | Main warfare orchestrator: manages state, triggers, and debug keybinds. |
| `warfare_factions.script` | Handles per-faction AI update cycles. |
| `warfare_options.script` | Applies runtime warfare settings and overrides functions. |
| `warfare_monkeypatches.script` | Injects functions into vanilla scripts (e.g., tasks, dialogs, xr_effects). |
| `smart_terrain_warfare.script` | Controls AI logic related to smart terrain ownership and battles. |
| `sim_squad_warfare.script` | Updates squad logic, position tracking, and global sync. |
| `sim_offline_combat.script` | Simulates battles between squads when the player is not present. |
| `sim_squad_scripted.script` | Handles scripted squad behavior (used in controlled missions or overrides). |
| `tasks_assault.script` | Evaluates zones and squads for planned attacks. |
| `tasks_smart_control.script` | Controls task queueing and smart terrain assignment logic. |
| `faction_expansions.script` | Calculates faction expansion logic and spawn chances. |
| `game_fast_travel.script` | Overrides fast travel behavior with zone safety checks. |
| `game_relations.script` | Handles faction relationships, reactions, and diplomacy logic. |
| `dialogs.script` | Manages custom dialogs and task conditions (e.g., task eligibility). |
| `xr_logic.script` | Handles spawn and scripted logic hooks, often monkeypatched. |
| `ui_mm_faction_select.script` | Manages faction selection UI logic at new game. |
| `ui_options.script` | Initializes and renders warfare settings in UI. |
| `ui_pda_warfare_tab.script` | Controls PDA Warfare tab rendering and interaction. |