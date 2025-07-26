# Behavior Change Log

This report flags potential behavioral differences between `runtime files` and `gamma_walo`.

## dialogs.script
- `give_task_mysteries_of_the_zone`: 8 line diff (minor)
- `warfare_disabled`: 7 line diff (minor)
- `has_2000_money`: 8 line diff (minor)

## faction_expansions.script
- `get_advanced_chance`: 8 line diff (minor)

## game_relations.script
- `safe_ini_r_float`: 15 line diff (major)
- `safe_ini_r_s32`: 35 line diff (major)
- `is_faction_pair_unaffected`: 23 line diff (major)
- `is_relation_allowed`: 24 line diff (major)
- `reset_all_relations`: 31 line diff (major)
- `calculate_relation_change`: 84 line diff (major)
- `get_random_enemy_faction`: 22 line diff (major - return logic changed)
- `get_random_natural_faction`: 22 line diff (major)
- `online_npc_on_death`: 26 line diff (major)
- `get_rank_relation`: 28 line diff (major)
- `get_reputation_relation`: 28 line diff (major)

## hq_coordinator.script
- `coordinator.register_base`: 8 line diff (minor - return logic changed)

## smart_terrain_warfare.script
- `process_targets`: 16 line diff (major)
- `find_targets`: 15 line diff (major)
- `find_targets_for_overflow`: 15 line diff (major)

## squad_transport.script
- `transport.create`: 15 line diff (major - return logic changed)
- `transport.drop_cargo`: 23 line diff (major - return logic changed)

## tasks_assault.script
- `evaluate_smarts_squads`: 22 line diff (major)
- `evaluate_squads_smarts`: 22 line diff (major)
- `postpone_for_next_frame`: 153 line diff (major)

## tasks_defense.script
- `get_random_stalker_chatter`: 11 line diff (major)
- `barrier_defense_available`: 11 line diff (major)

## ui_options.script
- `init_opt_base`: 24 line diff (major)

## ui_pda_warfare_tab.script
- `pda_warfare_tab`: 17 line diff (major)

## warfare.script
- `initialize`: 8 line diff (minor)
- `on_game_start`: 17 line diff (major)
- `sort_priority_table`: 8 line diff (minor)

## warfare_factions.script
- `update`: 8 line diff (minor)

## warfare_options.script
- `override_functions`: 8 line diff (minor)
