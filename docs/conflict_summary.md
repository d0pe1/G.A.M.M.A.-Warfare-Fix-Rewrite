# Conflict Summary

This document lists high level differences between the baseline runtime scripts and the versions found in `old_walo` and `gammas patch`. It is generated manually from `docs/runtime_vs_gamma_walo.md` and guides future merge work.

## old_walo

- **dialogs.script**
  - Adds helper `warfare_disabled` and modifies task limits.
  - Introduces `important_docs` table and expanded reward logic.
- **faction_expansions.script**
  - Adjusts spawn chance formulas for advanced and veteran squads.
- **game_fast_travel.script**
  - Replaces full Fair Fast Travel system with a lightweight stub.
- **game_relations.script**
  - Tweaks relation checks and blacklist handling.
- **sim_offline_combat.script**
  - Removes unused squad cap logic and tightens battle loops.
- **sim_squad_warfare.script**
  - Minor changelog updates; base functionality largely same.
- **smart_terrain_warfare.script**
  - Adds nil checks for target selection and preserves mutant attack rules.
- **tasks_assault.script** / **tasks_smart_control.script**
  - Various stability fixes and clearer debug output.
- **ui_options.script**
  - Additional menu options for warfare tweaks.
- **ui_pda_warfare_tab.script**, **warfare.script**, **warfare_factions.script**, **warfare_options.script**, **xr_logic.script**
  - Numerous tweaks to menu behaviour and default settings.

## gammas patch

- **faction_expansions.script**
  - Similar spawn chance tweaks as old_walo plus documentation.
- **sim_squad_scripted.script**
  - Corrects target validation when squads change tasks.
- **ui_options.script**
  - Adds menu bindings used by the patch.
- **ui_mm_faction_select.script**
  - Only whitespace differences; no functional changes.

These differences must be reviewed in detail before porting features into the `gamma_walo` codebase.
