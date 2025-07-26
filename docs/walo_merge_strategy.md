# WALO Merge Strategy

This document defines how features from **old_walo** and **gammas patch** should be integrated into the `gamma_walo` scripts. It is derived from `docs/conflict_summary.md` and diff reports.

## old_walo

- **dialogs.script**
  - Port the `warfare_disabled` helper and maintain modified task limit logic.
  - Integrate the `important_docs` rewards table while keeping baseline trading code.
- **faction_expansions.script**
  - Replace advanced/veteran spawn chance functions with the simplified formulas from old_walo.
- **game_fast_travel.script**
  - Keep GAMMA baseline fast-travel stub; document Fair Fast Travel as optional addon.
- **game_relations.script**
  - Apply blacklist loop optimisations and maintain existing relation checks.
- **sim_offline_combat.script**
  - Use old_walo loop optimisations and removal of squad cap logic.
- **sim_squad_warfare.script**
  - Merge minor changelog comments only; code identical.
- **smart_terrain_warfare.script**
  - Preserve mutant attack rules and add nil checks as in old_walo.
- **tasks_assault.script** & **tasks_smart_control.script**
  - Adopt stability fixes and clearer debug messages.
- **ui_options.script**
  - Bring over warfare tweak options but ensure compatibility with GAMMA MCM.
- **ui_pda_warfare_tab.script**, **warfare.script**, **warfare_factions.script**, **warfare_options.script**, **xr_logic.script**
  - Review individually; most changes are default settings and menu tweaks. Merge only behaviour that affects functionality.

## gammas patch

- **faction_expansions.script**
  - Confirm patch formulas match old_walo changes and avoid duplication.
- **sim_squad_scripted.script**
  - Integrate target validation fix for scripted squads.
- **ui_options.script**
  - Include menu bindings required for GAMMA patch features when not conflicting with old_walo options.
- **ui_mm_faction_select.script**
  - No functional changes; keep baseline version.

This plan will guide subsequent implementation tasks for the WALO port.
