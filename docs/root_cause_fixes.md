# Nil Defense Root Cause Fixes

This report summarizes adjustments made during Pass 3.

## game_relations.script
- Removed redundant `or {}` guards around faction tables.
- Tables `blacklist_pair`, `factions_table_all` and `factions_table` are defined at file load, so iteration safety is guaranteed.

## warfare_factions.script
- Restored numeric iteration over `factions` since the table is always defined.

## tasks_assault.script
- Reverted to numeric loops for cached faction lists and parameters. `cache_assault_func[task_id]` is created before use so nil checks were unnecessary.

## smart_terrain_warfare.script
- Replaced `ipairs(targets or {})` loop with numeric iteration.
- Updated `find_targets` and `find_targets_for_overflow` to return empty tables when faction is `monster` to avoid nil returns at call sites.

## sim_offline_combat.script
- Coordinator now waits for `SIMBOARD` initialization before registering callbacks. `smart_terrain_on_update` no longer checks for nil and assumes board readiness.

These changes eliminate nil guard patches and address underlying causes for potential nil values.
