## dialogs.script

### Function `give_task_mysteries_of_the_zone`
- Runtime: `give_task_mysteries_of_the_zone(a,b)`
- Gamma: `give_task_mysteries_of_the_zone(a,b)`
- Callsites: None found

### Function `warfare_disabled`
- Runtime: `warfare_disabled(a,b)`
- Gamma: `warfare_disabled(a,b)`
- Callsites: None found

### Function `has_2000_money`
- Runtime: `has_2000_money(first_speaker, second_speaker)`
- Gamma: `has_2000_money(first_speaker, second_speaker)`
- Callsites: None found

## faction_expansions.script

### Function `get_advanced_chance`
- Runtime: `get_advanced_chance(resource)`
- Gamma: `get_advanced_chance(resource)`
- Callsites:
  - gamma_walo/gamedata/scripts/faction_expansions.script:153:local advanced = get_advanced_chance(resource)
  - runtime files/gamedata/scripts/faction_expansions.script:150:local advanced = get_advanced_chance(resource)

## game_relations.script

### Function `safe_ini_r_float`
- Runtime: `safe_ini_r_float(ini, section, key, fallback)`
- Gamma: `safe_ini_r_float(ini, section, key, fallback)`
- Callsites: None found

### Function `safe_ini_r_s32`
- Runtime: `safe_ini_r_s32(ini, section, key, fallback)`
- Gamma: `safe_ini_r_s32(ini, section, key, fallback)`
- Callsites: None found

### Function `is_faction_pair_unaffected`
- Runtime: `is_faction_pair_unaffected(fac1, fac2)`
- Gamma: `is_faction_pair_unaffected(fac1, fac2)`
- Callsites:
  - gamma_walo/gamedata/scripts/smart_terrain_warfare.script:894:if (not game_relations.is_relation_allowed(faction_1,faction_2)) or (game_relations.is_faction_pair_unaffected(faction_1,faction_2)) or (faction_1 == faction_2) then
  - runtime files/gamedata/scripts/gameplay_disguise.script:977:and (not game_relations.is_faction_pair_unaffected(comm, default_comm))
  - runtime files/gamedata/scripts/smart_terrain_warfare.script:893:if (not game_relations.is_relation_allowed(faction_1,faction_2)) or (game_relations.is_faction_pair_unaffected(faction_1,faction_2)) or (faction_1 == faction_2) then

### Function `is_relation_allowed`
- Runtime: `is_relation_allowed(faction_1 , faction_2)`
- Gamma: `is_relation_allowed(faction_1 , faction_2)`
- Callsites:
  - gamma_walo/gamedata/scripts/game_relations.script:406:if is_relation_allowed( faction , killer_faction ) and ( natural_num + friend_num > friend_count_limit ) then
  - gamma_walo/gamedata/scripts/game_relations.script:446:if is_relation_allowed( faction , killer_faction ) and ( enemy_num > enemy_count_limit ) then
  - gamma_walo/gamedata/scripts/game_relations.script:469:if (comm ~= faction) and is_factions_enemies(faction, comm) and is_relation_allowed(faction , comm) then
  - gamma_walo/gamedata/scripts/game_relations.script:481:if (comm ~= faction) and (not is_factions_enemies(faction, comm)) and is_relation_allowed(faction , comm) then
  - gamma_walo/gamedata/scripts/smart_terrain_warfare.script:894:if (not game_relations.is_relation_allowed(faction_1,faction_2)) or (game_relations.is_faction_pair_unaffected(faction_1,faction_2)) or (faction_1 == faction_2) then
  - runtime files/gamedata/scripts/game_relations.script:400:if is_relation_allowed( factions_table[i] , killer_faction ) and ( natural_num + friend_num > friend_count_limit ) then
  - runtime files/gamedata/scripts/game_relations.script:439:if is_relation_allowed( factions_table[i] , killer_faction ) and ( enemy_num > enemy_count_limit ) then
  - runtime files/gamedata/scripts/game_relations.script:461:if (comm ~= factions_table[i]) and is_factions_enemies(factions_table[i], comm) and is_relation_allowed(factions_table[i] , comm) then
  - runtime files/gamedata/scripts/game_relations.script:472:if (comm ~= factions_table[i]) and (not is_factions_enemies(factions_table[i], comm)) and is_relation_allowed(factions_table[i] , comm) then
  - runtime files/gamedata/scripts/smart_terrain_warfare.script:893:if (not game_relations.is_relation_allowed(faction_1,faction_2)) or (game_relations.is_faction_pair_unaffected(faction_1,faction_2)) or (faction_1 == faction_2) then

### Function `reset_all_relations`
- Runtime: `reset_all_relations()`
- Gamma: `reset_all_relations()`
- Callsites:
  - gamma_walo/gamedata/scripts/game_relations.script:583:reset_all_relations()
  - runtime files/gamedata/scripts/game_relations.script:574:reset_all_relations()

### Function `calculate_relation_change`
- Runtime: `calculate_relation_change( victim_tbl, killer_tbl)`
- Gamma: `calculate_relation_change( victim_tbl, killer_tbl)`
- Callsites:
  - gamma_walo/gamedata/scripts/game_relations.script:526:calculate_relation_change( victim_tbl, killer_tbl)
  - gamma_walo/gamedata/scripts/game_relations.script:564:calculate_relation_change( victim_tbl, killer_tbl)
  - runtime files/gamedata/scripts/game_relations.script:517:calculate_relation_change( victim_tbl, killer_tbl)
  - runtime files/gamedata/scripts/game_relations.script:555:calculate_relation_change( victim_tbl, killer_tbl)

### Function `get_random_enemy_faction`
- Runtime: `get_random_enemy_faction(comm)`
- Gamma: `get_random_enemy_faction(comm)`
- Callsites:
  - runtime files/gamedata/scripts/xr_effects.script:3762:local rnd_enemy = game_relations.get_random_enemy_faction(community)

### Function `get_random_natural_faction`
- Runtime: `get_random_natural_faction(comm)`
- Gamma: `get_random_natural_faction(comm)`
- Callsites:
  - runtime files/gamedata/scripts/xr_effects.script:3763:local rnd_natural = game_relations.get_random_natural_faction(community)

### Function `online_npc_on_death`
- Runtime: `online_npc_on_death( victim, killer )`
- Gamma: `online_npc_on_death( victim, killer )`
- Callsites: None found

### Function `get_rank_relation`
- Runtime: `get_rank_relation(obj_1, obj_2)`
- Gamma: `get_rank_relation(obj_1, obj_2)`
- Callsites:
  - runtime files/gamedata/scripts/ui_debug_launcher.script:148:send_output('/Goodwill (Rank): %s', game_relations.get_rank_relation(o1, target) )

### Function `get_reputation_relation`
- Runtime: `get_reputation_relation(obj_1, obj_2)`
- Gamma: `get_reputation_relation(obj_1, obj_2)`
- Callsites:
  - runtime files/gamedata/scripts/ui_debug_launcher.script:149:send_output('/Goodwill (Reputation): %s', game_relations.get_reputation_relation(o1, target) )

## hq_coordinator.script

### Function `coordinator.register_base`
- Runtime: `coordinator.register_base(faction, base_id)`
- Gamma: `coordinator.register_base(faction, base_id)`
- Callsites:
  - gamma_walo/gamedata/scripts/daily_sim_engine.script:32:coordinator.register_base(base.owner, id)
  - runtime files/gamedata/scripts/daily_sim_engine.script:30:coordinator.register_base(base.owner, id)

## smart_terrain_warfare.script

### Function `process_targets`
- Runtime: `process_targets(smart)`
- Gamma: `process_targets(smart)`
- Callsites:
  - gamma_walo/gamedata/scripts/smart_terrain_warfare.script:364:process_targets(smart)
  - runtime files/gamedata/scripts/smart_terrain_warfare.script:363:process_targets(smart)

### Function `find_targets`
- Runtime: `find_targets(smart, faction_override, overflow_squad)`
- Gamma: `find_targets(smart, faction_override, overflow_squad)`
- Callsites:
  - gamma_walo/gamedata/scripts/smart_terrain_warfare.script:745:local targets = find_targets(smart, faction)
  - gamma_walo/gamedata/scripts/smart_terrain_warfare.script:1123:local targets = find_targets(smart)
  - gamma_walo/gamedata/scripts/smart_terrain_warfare.script:1173:local targets = find_targets(smart)
  - gamma_walo/gamedata/scripts/smart_terrain_warfare.script:4731:-- Used after find_targets()
  - runtime files/gamedata/scripts/smart_terrain_warfare.script:744:local targets = find_targets(smart, faction)
  - runtime files/gamedata/scripts/smart_terrain_warfare.script:1122:local targets = find_targets(smart)
  - runtime files/gamedata/scripts/smart_terrain_warfare.script:1171:local targets = find_targets(smart)
  - runtime files/gamedata/scripts/smart_terrain_warfare.script:4729:-- Used after find_targets()

### Function `find_targets_for_overflow`
- Runtime: `find_targets_for_overflow(smart, faction, search_all_levels)`
- Gamma: `find_targets_for_overflow(smart, faction, search_all_levels)`
- Callsites:
  - gamma_walo/gamedata/scripts/smart_terrain_warfare.script:760:local targets = find_targets_for_overflow(smart, faction)
  - gamma_walo/gamedata/scripts/smart_terrain_warfare.script:766:local new_targets = find_targets_for_overflow(smart, faction, true)				-- find target on any level for overflow squad (third field set to true)
  - gamma_walo/gamedata/scripts/smart_terrain_warfare.script:780:local targets = find_targets_for_overflow(smart, faction)
  - gamma_walo/gamedata/scripts/smart_terrain_warfare.script:784:local new_targets = find_targets_for_overflow(smart, faction, true)
  - runtime files/gamedata/scripts/smart_terrain_warfare.script:759:local targets = find_targets_for_overflow(smart, faction)
  - runtime files/gamedata/scripts/smart_terrain_warfare.script:765:local new_targets = find_targets_for_overflow(smart, faction, true)				-- find target on any level for overflow squad (third field set to true)
  - runtime files/gamedata/scripts/smart_terrain_warfare.script:779:local targets = find_targets_for_overflow(smart, faction)
  - runtime files/gamedata/scripts/smart_terrain_warfare.script:783:local new_targets = find_targets_for_overflow(smart, faction, true)

## squad_transport.script

### Function `transport.create`
- Runtime: `transport.create(task)`
- Gamma: `transport.create(task)`
- Callsites: None found

### Function `transport.drop_cargo`
- Runtime: `transport.drop_cargo(squad)`
- Gamma: `transport.drop_cargo(squad)`
- Callsites: None found

## tasks_assault.script

### Function `evaluate_smarts_squads`
- Runtime: `evaluate_smarts_squads(task_id, tbl, smart, squad_def, faction_def)`
- Gamma: `evaluate_smarts_squads(task_id, tbl, smart, squad_def, faction_def)`
- Callsites:
  - gamma_walo/gamedata/scripts/tasks_smart_control.script:387:evaluate_smarts_squads(task_id, targets, smart, def, enemy_faction_list)
  - gamma_walo/gamedata/scripts/tasks_assault.script:467:evaluate_smarts_squads(task_id, targets, smart, def, enemy_faction_list)
  - gamma_walo/gamedata/scripts/tasks_assault.script:489:evaluate_smarts_squads(task_id, targets, v, def, enemy_faction_list)
  - runtime files/gamedata/scripts/tasks_dominance.script:320:evaluate_smarts_squads(task_id, targets, v, def, enemy_faction_list)
  - runtime files/gamedata/scripts/tasks_smart_control.script:386:evaluate_smarts_squads(task_id, targets, smart, def, enemy_faction_list)
  - runtime files/gamedata/scripts/tasks_assault.script:451:evaluate_smarts_squads(task_id, targets, smart, def, enemy_faction_list)
  - runtime files/gamedata/scripts/tasks_assault.script:472:evaluate_smarts_squads(task_id, targets, v, def, enemy_faction_list)

### Function `evaluate_squads_smarts`
- Runtime: `evaluate_squads_smarts(task_id, var, squad, smart)`
- Gamma: `evaluate_squads_smarts(task_id, var, squad, smart)`
- Callsites:
  - gamma_walo/gamedata/scripts/tasks_smart_control.script:295:local squad_id = evaluate_squads_smarts(task_id, var, smart, smrt)
  - gamma_walo/gamedata/scripts/tasks_assault.script:335:local pass_this = evaluate_squads_smarts(task_id, var, squad, smart)
  - gamma_walo/gamedata/scripts/tasks_assault.script:345:local pass_this = evaluate_squads_smarts(task_id, var, squad, smart)
  - runtime files/gamedata/scripts/tasks_dominance.script:235:local squad_id = evaluate_squads_smarts(task_id, scripted, smrt_n, smrt_v)
  - runtime files/gamedata/scripts/tasks_smart_control.script:294:local squad_id = evaluate_squads_smarts(task_id, var, smart, smrt)
  - runtime files/gamedata/scripts/tasks_assault.script:321:local pass_this = evaluate_squads_smarts(task_id, var, squad, smart)
  - runtime files/gamedata/scripts/tasks_assault.script:331:local pass_this = evaluate_squads_smarts(task_id, var, squad, smart)

### Function `postpone_for_next_frame`
- Runtime: `postpone_for_next_frame(task_id, squad_id)`
- Gamma: `postpone_for_next_frame(task_id, squad_id)`
- Callsites:
  - runtime files/gamedata/scripts/tasks_fate.script:190:local function postpone_for_next_frame(map,freq)
  - runtime files/gamedata/scripts/tasks_bounty.script:216:local function postpone_for_next_frame(target_id)
  - runtime files/gamedata/scripts/monkey_rioc.script:4:local function postpone_for_next_frame(x)
  - runtime files/gamedata/scripts/tasks_delivery.script:161:local function postpone_for_next_frame(target_id)
  - runtime files/gamedata/scripts/tasks_stash.script:123:local function postpone_for_next_frame()
  - runtime files/gamedata/scripts/monkey_tasks_smart_control.script:3:function tasks_smart_control.postpone_for_next_frame(task_id, squad_id)

## tasks_defense.script

### Function `get_random_stalker_chatter`
- Runtime: `get_random_stalker_chatter()`
- Gamma: `get_random_stalker_chatter()`
- Callsites:
  - gamma_walo/gamedata/scripts/tasks_defense.script:76:local name, icon = get_random_stalker_chatter()
  - runtime files/gamedata/scripts/tasks_defense.script:74:local name, icon = get_random_stalker_chatter()

### Function `barrier_defense_available`
- Runtime: `barrier_defense_available(tid)`
- Gamma: `barrier_defense_available(tid)`
- Callsites:
  - gamma_walo/gamedata/scripts/tasks_defense.script:99:if barrier_defense_available('barrier_defense_monolith') then
  - gamma_walo/gamedata/scripts/tasks_defense.script:108:elseif barrier_defense_available('barrier_defense_zombie') then
  - gamma_walo/gamedata/scripts/tasks_defense.script:229:printl('barrier_defense_available(%s)',tid)
  - gamma_walo/gamedata/scripts/tasks_defense.script:241:-- printl('barrier_defense_available(%s) AAA',tid)
  - gamma_walo/gamedata/scripts/tasks_defense.script:247:-- printl('barrier_defense_available(%s) BBB',tid)
  - gamma_walo/gamedata/scripts/tasks_defense.script:252:-- printl('barrier_defense_available(%s) CCC',tid)
  - gamma_walo/gamedata/scripts/tasks_defense.script:255:-- printl('barrier_defense_available(%s) CCC1',tid)
  - gamma_walo/gamedata/scripts/tasks_defense.script:257:-- printl('barrier_defense_available(%s) CCC2',tid)
  - gamma_walo/gamedata/scripts/tasks_defense.script:259:-- printl('barrier_defense_available(%s) CCC3',tid)
  - gamma_walo/gamedata/scripts/tasks_defense.script:261:-- printl('barrier_defense_available(%s) CCC4',tid)
  - gamma_walo/gamedata/scripts/tasks_defense.script:268:-- printl('barrier_defense_available(%s) DDD',tid)
  - gamma_walo/gamedata/scripts/tasks_defense.script:283:-- printl('barrier_defense_available(%s) EEE',tid)
  - runtime files/gamedata/scripts/tasks_defense.script:97:if barrier_defense_available('barrier_defense_monolith') then
  - runtime files/gamedata/scripts/tasks_defense.script:106:elseif barrier_defense_available('barrier_defense_zombie') then
  - runtime files/gamedata/scripts/tasks_defense.script:227:printl('barrier_defense_available(%s)',tid)
  - runtime files/gamedata/scripts/tasks_defense.script:239:-- printl('barrier_defense_available(%s) AAA',tid)
  - runtime files/gamedata/scripts/tasks_defense.script:245:-- printl('barrier_defense_available(%s) BBB',tid)
  - runtime files/gamedata/scripts/tasks_defense.script:250:-- printl('barrier_defense_available(%s) CCC',tid)
  - runtime files/gamedata/scripts/tasks_defense.script:253:-- printl('barrier_defense_available(%s) CCC1',tid)
  - runtime files/gamedata/scripts/tasks_defense.script:255:-- printl('barrier_defense_available(%s) CCC2',tid)
  - runtime files/gamedata/scripts/tasks_defense.script:257:-- printl('barrier_defense_available(%s) CCC3',tid)
  - runtime files/gamedata/scripts/tasks_defense.script:259:-- printl('barrier_defense_available(%s) CCC4',tid)
  - runtime files/gamedata/scripts/tasks_defense.script:266:-- printl('barrier_defense_available(%s) DDD',tid)
  - runtime files/gamedata/scripts/tasks_defense.script:281:-- printl('barrier_defense_available(%s) EEE',tid)

## ui_options.script

### Function `init_opt_base`
- Runtime: `init_opt_base()`
- Gamma: `init_opt_base()`
- Callsites:
  - gamma_walo/gamedata/scripts/ui_options.script:1124:init_opt_base()
  - gamma_walo/gamedata/scripts/ui_options.script:1193:init_opt_base()
  - runtime files/gamedata/scripts/ui_options_modded_exes.script:10:ui_options.init_opt_base()
  - runtime files/gamedata/scripts/ui_sidhud_mcm.script:273:ui_options.init_opt_base()
  - runtime files/gamedata/scripts/ui_main_menu.script:24:ui_mcm.init_opt_base()
  - runtime files/gamedata/scripts/ui_mcm.script:380:init_opt_base()
  - runtime files/gamedata/scripts/ui_mcm.script:651:init_opt_base()
  - runtime files/gamedata/scripts/ui_mcm.script:731:init_opt_base()
  - runtime files/gamedata/scripts/ui_options.script:1123:init_opt_base()
  - runtime files/gamedata/scripts/ui_options.script:1192:init_opt_base()

## ui_pda_warfare_tab.script

### Function `pda_warfare_tab`
- Runtime: `not found`
- Gamma: `not found`
- Callsites:
  - gamma_walo/gamedata/scripts/ui_pda_warfare_tab.script:23:SINGLETON = SINGLETON or pda_warfare_tab()
  - runtime files/gamedata/scripts/ui_pda_warfare_tab.script:21:SINGLETON = SINGLETON or pda_warfare_tab()

## warfare.script

### Function `initialize`
- Runtime: `initialize()`
- Gamma: `initialize()`
- Callsites:
  - gamma_walo/gamedata/scripts/warfare.script:441:initialize()
  - runtime files/gamedata/scripts/xr_campfire_point.script:51:function action_point_campfire:initialize()
  - runtime files/gamedata/scripts/xr_campfire_point.script:52:action_base.initialize(self)
  - runtime files/gamedata/scripts/xr_combat_camper.script:53:function action_shoot:initialize()
  - runtime files/gamedata/scripts/xr_combat_camper.script:54:action_base.initialize( self )
  - runtime files/gamedata/scripts/xr_combat_camper.script:80:function action_look_around:initialize()
  - runtime files/gamedata/scripts/xr_combat_camper.script:81:action_base.initialize( self )
  - runtime files/gamedata/scripts/surge_manager_faster_emissions.script:3:sm_initialize(self)
  - runtime files/gamedata/scripts/surge_manager.script:144:function CSurgeManager:initialize()
  - runtime files/gamedata/scripts/surge_manager.script:239:self:initialize()
  - runtime files/gamedata/scripts/surge_manager.script:604:self:initialize()
  - runtime files/gamedata/scripts/surge_manager.script:1659:mgr:initialize()
  - runtime files/gamedata/scripts/surge_manager.script:1690:mgr:initialize()
  - runtime files/gamedata/scripts/surge_manager.script:1728:mgr:initialize()
  - runtime files/gamedata/scripts/surge_manager.script:1757:mgr:initialize()
  - runtime files/gamedata/scripts/idiots_combat_assault.script:45:function action_combat_assault:initialize()
  - runtime files/gamedata/scripts/idiots_combat_assault.script:46:action_base.initialize(self)
  - runtime files/gamedata/scripts/idiots_combat_guard.script:43:function action_combat_guard:initialize()
  - runtime files/gamedata/scripts/idiots_combat_guard.script:44:action_base.initialize(self)
  - runtime files/gamedata/scripts/psi_storm_manager.script:39:function CPsiStormManager:initialize()
  - runtime files/gamedata/scripts/psi_storm_manager.script:74:self:initialize()
  - runtime files/gamedata/scripts/psi_storm_manager.script:274:self:initialize()
  - runtime files/gamedata/scripts/psi_storm_manager.script:606:mgr:initialize()
  - runtime files/gamedata/scripts/psi_storm_manager.script:628:mgr:initialize()
  - runtime files/gamedata/scripts/psi_storm_manager.script:662:mgr:initialize()
  - runtime files/gamedata/scripts/psi_storm_manager.script:681:mgr:initialize()
  - runtime files/gamedata/scripts/z_npc_wounded_animation_fix_mcm.script:13:orig_action_wounded_initialize(self)
  - runtime files/gamedata/scripts/liz_inertia_expanded.script:197:if not is_initialized then initialize() end -- prevents super rare bug when actor updae called before first actor update
  - runtime files/gamedata/scripts/axr_npc_vs_box.script:63:function action_npc_vs_box:initialize()
  - runtime files/gamedata/scripts/axr_npc_vs_box.script:64:action_base.initialize(self)
  - runtime files/gamedata/scripts/xr_wounded.script:64:function action_wounded:initialize()
  - runtime files/gamedata/scripts/xr_wounded.script:65:action_base.initialize (self)
  - runtime files/gamedata/scripts/axr_beh.script:103:function action_beh:initialize()
  - runtime files/gamedata/scripts/axr_beh.script:104:action_base.initialize(self)
  - runtime files/gamedata/scripts/xr_danger.script:404:function action_danger:initialize()
  - runtime files/gamedata/scripts/xr_danger.script:405:action_base.initialize( self )
  - runtime files/gamedata/scripts/xr_meet.script:115:function action_meet_wait:initialize()
  - runtime files/gamedata/scripts/xr_meet.script:116:action_base.initialize(self)
  - runtime files/gamedata/scripts/surge_rush_scheme_evaluator_inside.script:46:function action_stalker_surge_rush_inside:initialize()
  - runtime files/gamedata/scripts/surge_rush_scheme_evaluator_inside.script:47:action_base.initialize(self)
  - runtime files/gamedata/scripts/surge_rush_scheme_evaluator_outside.script:41:function action_stalker_surge_rush_outside:initialize()
  - runtime files/gamedata/scripts/surge_rush_scheme_evaluator_outside.script:42:action_base.initialize(self)
  - runtime files/gamedata/scripts/idiots_surge.script:62:function action_surge:initialize()
  - runtime files/gamedata/scripts/idiots_surge.script:63:action_base.initialize(self)
  - runtime files/gamedata/scripts/xr_companion.script:43:function action_companion_activity:initialize()
  - runtime files/gamedata/scripts/xr_companion.script:45:action_base.initialize(self)
  - runtime files/gamedata/scripts/pulse_vortex_consistency_fix.script:134:psm_initialize(self)
  - runtime files/gamedata/scripts/xr_reach_task.script:123:function action_reach_task_location:initialize()
  - runtime files/gamedata/scripts/xr_reach_task.script:124:action_base.initialize( self )
  - runtime files/gamedata/scripts/idiots_combat_support.script:43:function action_combat_support:initialize()
  - runtime files/gamedata/scripts/idiots_combat_support.script:44:action_base.initialize(self)
  - runtime files/gamedata/scripts/idiots_combat_snipe.script:42:function action_combat_snipe:initialize()
  - runtime files/gamedata/scripts/idiots_combat_snipe.script:43:action_base.initialize(self)
  - runtime files/gamedata/scripts/z_npc_footsteps.script:73:self.st.move_mgr:initialize()
  - runtime files/gamedata/scripts/warfare.script:427:initialize()
  - runtime files/gamedata/scripts/item_device.script:435:initialize()
  - runtime files/gamedata/scripts/xrs_facer.script:163:function action_facer:initialize()
  - runtime files/gamedata/scripts/xrs_facer.script:164:action_base.initialize(self)
  - runtime files/gamedata/scripts/xrs_facer.script:388:function action_steal_up:initialize()
  - runtime files/gamedata/scripts/xrs_facer.script:389:action_base.initialize(self)

### Function `on_game_start`
- Runtime: `on_game_start()`
- Gamma: `on_game_start()`
- Callsites:
  - gamma_walo/gamedata/scripts/sim_squad_scripted.script:1441:-- function on_game_start()
  - runtime files/gamedata/scripts/sim_squad_scripted.script:1441:-- function on_game_start()
  - runtime files/gamedata/scripts/callbacks_gameobject.script:143:-- function on_game_start()
  - runtime files/gamedata/scripts/pda.script:433:function add_quick_slot_items_on_game_start()
  - runtime files/gamedata/scripts/dph_mcm_save_storage.script:15:Usually the only thing you need to do is call register_module(mod) from on_game_start() in your addon.
  - runtime files/gamedata/scripts/ui_main_menu.script:31:xrs_debug_tools.on_game_start()
  - runtime files/gamedata/scripts/grok_gamma_manual_on_startup.script:25:-- function on_game_start()
  - runtime files/gamedata/scripts/ui_mcm.script:341:--printf("%s.on_game_start()",t[i])
  - runtime files/gamedata/scripts/ui_mcm.script:2683:however it could be done as late as on_game_start() if one wanted to have an MCM option for global vs save specific options storing
  - runtime files/gamedata/scripts/tasks_placeable_waypoints.script:2460:on_game_start()
  - runtime files/gamedata/scripts/uni_anim_knives.script:193:-- function on_game_start()
  - runtime files/gamedata/scripts/zz_artefacts_belt_scroller_data.script:48:-- function on_game_start()
  - runtime files/gamedata/scripts/zzz_faction_expansions_loadall.script:21:function faction_expansions.on_game_start()

### Function `sort_priority_table`
- Runtime: `sort_priority_table(tbl)`
- Gamma: `sort_priority_table(tbl)`
- Callsites:
  - gamma_walo/gamedata/scripts/sim_squad_warfare.script:787:targets = warfare.sort_priority_table(targets)
  - runtime files/gamedata/scripts/sim_squad_warfare.script:786:targets = warfare.sort_priority_table(targets)

## warfare_factions.script

### Function `update`
- Runtime: `update()`
- Gamma: `update()`
- Callsites:
  - gamma_walo/gamedata/scripts/sim_squad_scripted.script:144:function sim_squad_scripted:update()
  - gamma_walo/gamedata/scripts/sim_squad_scripted.script:146:cse_alife_online_offline_group.update(self)
  - gamma_walo/gamedata/scripts/sim_squad_scripted.script:235:self:specific_update(script_target_id)
  - gamma_walo/gamedata/scripts/sim_squad_scripted.script:237:self:generic_update()
  - gamma_walo/gamedata/scripts/sim_squad_scripted.script:276:function sim_squad_scripted:specific_update(script_target_id) -- This update is called for all squads with a scripted smart_terrain target
  - gamma_walo/gamedata/scripts/sim_squad_scripted.script:333:function sim_squad_scripted:generic_update() -- This update is called for all squads with no scripted assigned target
  - gamma_walo/gamedata/scripts/sim_squad_scripted.script:823:state_mgr:update()
  - gamma_walo/gamedata/scripts/sim_squad_scripted.script:824:state_mgr:update()
  - gamma_walo/gamedata/scripts/sim_squad_scripted.script:825:state_mgr:update()
  - gamma_walo/gamedata/scripts/sim_squad_scripted.script:826:state_mgr:update()
  - gamma_walo/gamedata/scripts/sim_squad_scripted.script:827:state_mgr:update()
  - gamma_walo/gamedata/scripts/sim_squad_scripted.script:828:state_mgr:update()
  - gamma_walo/gamedata/scripts/sim_squad_scripted.script:829:state_mgr:update()
  - gamma_walo/gamedata/scripts/ui_mm_faction_select.script:381:local function actor_on_first_update(binder,delta)
  - gamma_walo/gamedata/scripts/smart_terrain_warfare.script:291:function smart_terrain_on_update(smart)
  - gamma_walo/gamedata/scripts/dialogs.script:1227:st.meet.meet_manager:update()
  - gamma_walo/gamedata/scripts/dialogs.script:1360:-- game_stats.money_quest_update (num)
  - gamma_walo/gamedata/scripts/dialogs.script:1367:-- game_stats.money_quest_update(-num)
  - gamma_walo/gamedata/scripts/dialogs.script:1827:-- game_stats.money_quest_update (num)
  - gamma_walo/gamedata/scripts/dialogs.script:1837:-- game_stats.money_quest_update(-num)
  - gamma_walo/gamedata/scripts/sim_offline_combat.script:106:local function smart_terrain_on_update(smart)
  - gamma_walo/gamedata/scripts/sim_offline_combat.script:171:local function squad_on_update(squad_1)
  - gamma_walo/gamedata/scripts/tasks_defense.script:94:function actor_on_first_update()
  - gamma_walo/gamedata/scripts/tasks_defense.script:156:function npc_on_update(npc)
  - gamma_walo/gamedata/scripts/game_fast_travel.script:1795:function actor_on_first_update()
  - gamma_walo/gamedata/scripts/game_fast_travel.script:1807:function actor_on_update()
  - gamma_walo/gamedata/scripts/sim_squad_warfare.script:71:function squad_on_update(squad)
  - gamma_walo/gamedata/scripts/sim_squad_warfare.script:165:squad_warfare_update(squad)
  - gamma_walo/gamedata/scripts/sim_squad_warfare.script:199:function squad_warfare_update(squad)
  - gamma_walo/gamedata/scripts/warfare.script:323:function actor_on_update()
  - gamma_walo/gamedata/scripts/warfare.script:442:warfare_levels.update()
  - gamma_walo/gamedata/scripts/warfare.script:443:warfare_factions.update()
  - gamma_walo/gamedata/scripts/warfare.script:446:warfare_levels.update()
  - gamma_walo/gamedata/scripts/warfare.script:447:warfare_factions.update()
  - runtime files/gamedata/scripts/liz_inertia_expanded_crawl_sounds.script:14:function actor_on_update(_, delta)
  - runtime files/gamedata/scripts/bind_awr.script:149:function actor_on_first_update() --| Callback of the first Update actor. It is executed one-time after loading, _after_ spawn of all objects from all.spawn, unlike on_game_load
  - runtime files/gamedata/scripts/ssfx_weapons_dof.script:193:local function actor_on_update()
  - runtime files/gamedata/scripts/ssfx_weapons_dof.script:442:function actor_on_first_update()
  - runtime files/gamedata/scripts/speed.script:6:local function actor_on_first_update()
  - runtime files/gamedata/scripts/speed.script:24:actor_on_first_update()
  - runtime files/gamedata/scripts/grok_bleed_icon.script:1:function actor_on_first_update()
  - runtime files/gamedata/scripts/grok_bleed_icon.script:9:function actor_on_update()
  - runtime files/gamedata/scripts/Free_ZoomV2_mcm.script:135:function actor_on_first_update()
  - runtime files/gamedata/scripts/Free_ZoomV2_mcm.script:142:actor_on_update()
  - runtime files/gamedata/scripts/Free_ZoomV2_mcm.script:145:function actor_on_update()
  - runtime files/gamedata/scripts/sim_squad_scripted.script:144:function sim_squad_scripted:update()
  - runtime files/gamedata/scripts/sim_squad_scripted.script:146:cse_alife_online_offline_group.update(self)
  - runtime files/gamedata/scripts/sim_squad_scripted.script:235:self:specific_update(script_target_id)
  - runtime files/gamedata/scripts/sim_squad_scripted.script:237:self:generic_update()
  - runtime files/gamedata/scripts/sim_squad_scripted.script:276:function sim_squad_scripted:specific_update(script_target_id) -- This update is called for all squads with a scripted smart_terrain target
  - runtime files/gamedata/scripts/sim_squad_scripted.script:333:function sim_squad_scripted:generic_update() -- This update is called for all squads with no scripted assigned target
  - runtime files/gamedata/scripts/sim_squad_scripted.script:823:state_mgr:update()
  - runtime files/gamedata/scripts/sim_squad_scripted.script:824:state_mgr:update()
  - runtime files/gamedata/scripts/sim_squad_scripted.script:825:state_mgr:update()
  - runtime files/gamedata/scripts/sim_squad_scripted.script:826:state_mgr:update()
  - runtime files/gamedata/scripts/sim_squad_scripted.script:827:state_mgr:update()
  - runtime files/gamedata/scripts/sim_squad_scripted.script:828:state_mgr:update()
  - runtime files/gamedata/scripts/sim_squad_scripted.script:829:state_mgr:update()
  - runtime files/gamedata/scripts/safer_af_crafting_mcm.script:25:function actor_on_update(bind, delta)
  - runtime files/gamedata/scripts/simulation_objects.script:49:-- function actor_on_first_update() -- store unchangable info in _g, reuse rather than recall
  - runtime files/gamedata/scripts/demonized_ledge_grabbing.script:241:function actor_on_first_update()
  - runtime files/gamedata/scripts/gameplay_disguise.script:479:local function npc_on_update(npc)
  - runtime files/gamedata/scripts/gameplay_disguise.script:1004:local function actor_on_first_update()
  - runtime files/gamedata/scripts/gameplay_disguise.script:1020:local function actor_on_update()
  - runtime files/gamedata/scripts/gameplay_disguise.script:1043:hud_update()
  - runtime files/gamedata/scripts/gameplay_disguise.script:1227:function hud_update()
  - runtime files/gamedata/scripts/dotmarks_main.script:1497:function actor_on_first_update()
  - runtime files/gamedata/scripts/xcv_phantoms.script:35:function actor_on_first_update()
  - runtime files/gamedata/scripts/xcv_phantoms.script:154:function monster_on_update(npc)
  - runtime files/gamedata/scripts/xcv_phantoms.script:226:function actor_on_update()
  - runtime files/gamedata/scripts/ph_sound.script:47:function snd_source:update(delta)
  - runtime files/gamedata/scripts/fluid_aim.script:33:local function actor_on_update()
  - runtime files/gamedata/scripts/item_weapon.script:1023:local function actor_on_update()
  - runtime files/gamedata/scripts/npe_fair_fast_travel_tutorials_mcm.script:353:function actor_on_first_update()
  - runtime files/gamedata/scripts/lc_custom.script:2:function actor_on_first_update()
  - runtime files/gamedata/scripts/liz_inertia_expanded_patches.script:122:function actor_on_first_update()
  - runtime files/gamedata/scripts/wpo_loot.script:7:function trader_autoinject.update(npc)
  - runtime files/gamedata/scripts/utils_catspaw_hudmarks.script:461:function HUDMarkerManager:actor_on_update()
  - runtime files/gamedata/scripts/utils_catspaw_hudmarks.script:748:func_on_update (no default)
  - runtime files/gamedata/scripts/utils_catspaw_hudmarks.script:1218:function UIHUDMarker:actor_on_update()
  - runtime files/gamedata/scripts/utils_catspaw_hudmarks.script:1441:self.func_on_update(self, args)
  - runtime files/gamedata/scripts/utils_catspaw_hudmarks.script:1686:function actor_on_first_update()
  - runtime files/gamedata/scripts/callbacks_gameobject.script:432:function actor_on_first_update()
  - runtime files/gamedata/scripts/ui_mod_elements.script:18:function actor_on_first_update()
  - runtime files/gamedata/scripts/ui_mod_elements.script:710:--game_stats.money_quest_update(card_game_21_rate)
  - runtime files/gamedata/scripts/ui_mod_elements.script:715:--game_stats.money_quest_update(-card_game_21_rate)
  - runtime files/gamedata/scripts/bind_campfire.script:176:local function actor_on_update()
  - runtime files/gamedata/scripts/bind_campfire.script:328:function campfire_binder:update(delta)
  - runtime files/gamedata/scripts/bind_campfire.script:329:object_binder.update(self, delta)
  - runtime files/gamedata/scripts/surge_manager.script:62:get_surge_manager():update()
  - runtime files/gamedata/scripts/surge_manager.script:63:psi_storm_manager.get_psi_storm_manager():update()
  - runtime files/gamedata/scripts/surge_manager.script:601:function CSurgeManager:update()
  - runtime files/gamedata/scripts/alife_storage_manager.script:58:local function actor_on_first_update()
  - runtime files/gamedata/scripts/alife_storage_manager.script:59:alife_first_update() -- _G
  - runtime files/gamedata/scripts/weapon_cover_tilt.script:838:function actor_on_update(binder, delta)
  - runtime files/gamedata/scripts/weapon_cover_tilt.script:1236:function actor_on_first_update()
  - runtime files/gamedata/scripts/arti_jamming.script:299:local function actor_on_update()
  - runtime files/gamedata/scripts/camera_reanim_project.script:31:local function actor_on_update()
  - runtime files/gamedata/scripts/npe_dialog_tutorial.script:435:function actor_on_first_update()
  - runtime files/gamedata/scripts/grok_progressive_rad_damages.script:15:function actor_on_update()
  - runtime files/gamedata/scripts/actor_effects.script:1632:local function actor_on_update()
  - runtime files/gamedata/scripts/actor_effects.script:1849:local function actor_on_first_update()
  - runtime files/gamedata/scripts/ui_hud_dotmarks.script:2034:self:actor_on_update()
  - runtime files/gamedata/scripts/ui_hud_dotmarks.script:2975:function InteractPrompt:on_quickhelp_text_update(raw_text, loc_string, trimmed_text)
  - runtime files/gamedata/scripts/ui_hud_dotmarks.script:3083:function InteractPrompt:actor_on_update()
  - runtime files/gamedata/scripts/ui_hud_dotmarks.script:3445:function actor_on_first_update()
  - runtime files/gamedata/scripts/ui_hud_dotmarks.script:5234:function actor_on_update()
  - runtime files/gamedata/scripts/psi_storm_manager.script:272:function CPsiStormManager:update()
  - runtime files/gamedata/scripts/dynamic_emission_cover_mcm.script:12:function tb_coordinate_based_safe_zones.actor_on_update()
  - runtime files/gamedata/scripts/dynamic_emission_cover_mcm.script:13:base_tb_update()
  - runtime files/gamedata/scripts/dynamic_emission_cover_mcm.script:126:function actor_on_update()
  - runtime files/gamedata/scripts/drx_da_main_artefacts_movement.script:198:function actor_on_first_update()
  - runtime files/gamedata/scripts/uni_anim_detectors.script:67:function actor_on_first_update()
  - runtime files/gamedata/scripts/zz_rf_light_remover.script:5:base_radio_update(self)
  - runtime files/gamedata/scripts/zzz_rax_sortingplus_mcm.script:108:function actor_on_first_update()
  - runtime files/gamedata/scripts/zzz_rax_sortingplus_mcm.script:672:return cellupdate(self, obj)
  - runtime files/gamedata/scripts/sr_light.script:28:function action_light:update(delta)
  - runtime files/gamedata/scripts/soulslike_scenarios.script:576:actor_status_thirst.actor_on_update()
  - runtime files/gamedata/scripts/gunslinger_controller.script:541:function actor_on_update()
  - runtime files/gamedata/scripts/gunslinger_controller.script:569:function actor_on_first_update()
  - runtime files/gamedata/scripts/trader_autoinject.script:6:function trader_autoinject.update(npc)
  - runtime files/gamedata/scripts/trader_autoinject.script:42:function trade_manager.update(npc, force_refresh)
  - runtime files/gamedata/scripts/trader_autoinject.script:59:function timed_update(npc)
  - runtime files/gamedata/scripts/trader_autoinject.script:60:update(npc)
  - runtime files/gamedata/scripts/liz_fdda_redone_consumables.script:43:function actor_on_first_update()
  - runtime files/gamedata/scripts/liz_inertia_expanded.script:196:function actor_on_update(_, delta)
  - runtime files/gamedata/scripts/bullet_time_mcm.script:109:function slowmo_on_update()
  - runtime files/gamedata/scripts/zz_parts_in_tooltip.script:146:og_info_item_update(self, obj, sec, flags)
  - runtime files/gamedata/scripts/ui_pda_encyclopedia_tab.script:465:local function actor_on_first_update()
  - runtime files/gamedata/scripts/ui_pda_encyclopedia_tab.script:470:local function actor_on_update()
  - runtime files/gamedata/scripts/hf_map_objects.script:191:function actor_on_first_update()
  - runtime files/gamedata/scripts/xr_wounded.script:30:self.a.wound_manager:update()
  - runtime files/gamedata/scripts/xr_wounded.script:234:function Cwound_manager:update()
  - runtime files/gamedata/scripts/xr_wounded.script:302:--self:update()
  - runtime files/gamedata/scripts/xr_wounded.script:388:self:update()
  - runtime files/gamedata/scripts/xr_effects.script:912:--game_stats.money_quest_update( -(money) )
  - runtime files/gamedata/scripts/xr_effects.script:1561:planner:update()
  - runtime files/gamedata/scripts/xr_effects.script:1562:planner:update()
  - runtime files/gamedata/scripts/xr_effects.script:1563:planner:update()
  - runtime files/gamedata/scripts/xr_effects.script:1566:db.storage[npc:id()].state_mgr:update()
  - runtime files/gamedata/scripts/xr_effects.script:1567:db.storage[npc:id()].state_mgr:update()
  - runtime files/gamedata/scripts/xr_effects.script:1568:db.storage[npc:id()].state_mgr:update()
  - runtime files/gamedata/scripts/xr_effects.script:1569:db.storage[npc:id()].state_mgr:update()
  - runtime files/gamedata/scripts/xr_effects.script:1570:db.storage[npc:id()].state_mgr:update()
  - runtime files/gamedata/scripts/xr_effects.script:1571:db.storage[npc:id()].state_mgr:update()
  - runtime files/gamedata/scripts/xr_effects.script:1572:db.storage[npc:id()].state_mgr:update()
  - runtime files/gamedata/scripts/xr_effects.script:2028:--	planner:update()
  - runtime files/gamedata/scripts/xr_effects.script:2029:--	planner:update()
  - runtime files/gamedata/scripts/xr_effects.script:2030:--	planner:update()
  - runtime files/gamedata/scripts/xr_effects.script:2032:state_mgr:update()
  - runtime files/gamedata/scripts/xr_effects.script:2033:state_mgr:update()
  - runtime files/gamedata/scripts/xr_effects.script:2034:state_mgr:update()
  - runtime files/gamedata/scripts/xr_effects.script:2035:state_mgr:update()
  - runtime files/gamedata/scripts/xr_effects.script:2036:state_mgr:update()
  - runtime files/gamedata/scripts/xr_effects.script:2037:state_mgr:update()
  - runtime files/gamedata/scripts/xr_effects.script:2038:state_mgr:update()
  - runtime files/gamedata/scripts/xr_effects.script:3339:player:faction_brain_update()
  - runtime files/gamedata/scripts/xr_effects.script:3383:--squad:update()
  - runtime files/gamedata/scripts/xr_effects.script:3438:squad:update()
  - runtime files/gamedata/scripts/xr_effects.script:3511:squad:update()
  - runtime files/gamedata/scripts/lc_extra_transitions.script:69:function actor_on_first_update()
  - runtime files/gamedata/scripts/grok_no_north_faction_in_south.script:231:local function npc_on_update(npc)
  - runtime files/gamedata/scripts/visual_memory_manager.script:247:function actor_on_first_update()
  - runtime files/gamedata/scripts/tasks_mystery_of_the_swamps.script:532:function actor_on_first_update()
  - runtime files/gamedata/scripts/tasks_mystery_of_the_swamps.script:553:function actor_on_update()
  - runtime files/gamedata/scripts/tasks_pump_station_defense.script:42:function actor_on_first_update()
  - runtime files/gamedata/scripts/zz_companion_inventory_fix_mcm.script:62:function npc_on_update(npc)
  - runtime files/gamedata/scripts/z_beefs_nvgs.script:517:function actor_on_update()
  - runtime files/gamedata/scripts/z_beefs_nvgs.script:562:-- local function actor_on_first_update()
  - runtime files/gamedata/scripts/grok_remove_knife_ammo_on_start.script:45:function actor_on_first_update()
  - runtime files/gamedata/scripts/bind_table_fan.script:32:function haru_placeable_fan_wrapper:update(delta)
  - runtime files/gamedata/scripts/bind_table_fan.script:33:bind_hf_base.hf_binder_wrapper.update(self, delta)
  - runtime files/gamedata/scripts/xr_danger.script:91:local function npc_on_update(npc)
  - runtime files/gamedata/scripts/ui_mm_faction_select.script:381:local function actor_on_first_update(binder,delta)
  - runtime files/gamedata/scripts/msv_over_radiation_status_mcm.script:86:function actor_on_first_update()
  - runtime files/gamedata/scripts/bind_hf_static.script:23:function hf_static_binder:update(delta)
  - runtime files/gamedata/scripts/bind_hf_static.script:24:object_binder.update(self, delta)
  - runtime files/gamedata/scripts/sr_psy_antenna.script:172:function PsyAntenna:update(dt)
  - runtime files/gamedata/scripts/sr_psy_antenna.script:329:function action_psy_antenna:update( delta )
  - runtime files/gamedata/scripts/ssfx_lut.script:123:local function actor_on_update()
  - runtime files/gamedata/scripts/ssfx_lut.script:138:local function actor_on_first_update()
  - runtime files/gamedata/scripts/fakelens.script:97:function actor_on_update()
  - runtime files/gamedata/scripts/smart_terrain_warfare.script:290:function smart_terrain_on_update(smart)
  - runtime files/gamedata/scripts/liz_inertia_expanded_crawl_state_tracker.script:13:function actor_on_update()
  - runtime files/gamedata/scripts/itms_manager.script:199:function actor_on_first_update()
  - runtime files/gamedata/scripts/itms_manager.script:1167:function ItemProcessor:update()
  - runtime files/gamedata/scripts/bind_hf_base.script:68:function hf_binder_wrapper:update(delta)
  - runtime files/gamedata/scripts/bind_hf_base.script:144:function base_binder:update(delta)
  - runtime files/gamedata/scripts/bind_hf_base.script:145:object_binder.update(self, delta)
  - runtime files/gamedata/scripts/bind_hf_base.script:149:self.wrapper:update(delta)
  - runtime files/gamedata/scripts/dialogs.script:1225:st.meet.meet_manager:update()
  - runtime files/gamedata/scripts/dialogs.script:1358:-- game_stats.money_quest_update (num)
  - runtime files/gamedata/scripts/dialogs.script:1365:-- game_stats.money_quest_update(-num)
  - runtime files/gamedata/scripts/dialogs.script:1825:-- game_stats.money_quest_update (num)
  - runtime files/gamedata/scripts/dialogs.script:1835:-- game_stats.money_quest_update(-num)
  - runtime files/gamedata/scripts/weight.script:17:local function actor_on_first_update()
  - runtime files/gamedata/scripts/weight.script:25:actor_on_first_update()
  - runtime files/gamedata/scripts/weight.script:48:actor_on_first_update()
  - runtime files/gamedata/scripts/sr_camp.script:126:function CCampManager:update()
  - runtime files/gamedata/scripts/sr_camp.script:133:self.sound_manager:update()
  - runtime files/gamedata/scripts/sr_camp.script:239:self.sound_manager:update()
  - runtime files/gamedata/scripts/sr_camp.script:347:camp.sound_manager:update()
  - runtime files/gamedata/scripts/sr_camp.script:360:camp.sound_manager:update()
  - runtime files/gamedata/scripts/ui_sidhud_mcm.script:198:local function actor_on_first_update()
  - runtime files/gamedata/scripts/ui_sidhud_mcm.script:204:local function actor_on_update()
  - runtime files/gamedata/scripts/cozy_campfire.script:18:function actor_on_update()
  - runtime files/gamedata/scripts/zone_keeper.script:238:function actor_on_first_update()
  - runtime files/gamedata/scripts/TB_RF_Receiver_Packages.script:982:function actor_on_first_update()
  - runtime files/gamedata/scripts/TB_RF_Receiver_Packages.script:1058:function actor_on_update()
  - runtime files/gamedata/scripts/placeable_items_trade.script:54:function trader_autoinject.update(npc)
  - runtime files/gamedata/scripts/zzz_player_injuries.script:49:function actor_on_first_update()
  - runtime files/gamedata/scripts/zzz_player_injuries.script:1488:function actor_on_update()
  - runtime files/gamedata/scripts/xr_meet.script:55:self.a.meet_manager:update()
  - runtime files/gamedata/scripts/xr_meet.script:283:function Cmeet_manager:update()
  - runtime files/gamedata/scripts/dynamic_news_manager.script:91:function actor_on_first_update()
  - runtime files/gamedata/scripts/dynamic_news_manager.script:95:function actor_on_update()
  - runtime files/gamedata/scripts/ssfx_terrain_parallax.script:44:local function actor_on_first_update()
  - runtime files/gamedata/scripts/ea_light.script:30:light:update()
  - runtime files/gamedata/scripts/ea_light.script:48:light:update()
  - runtime files/gamedata/scripts/ea_light.script:59:light:update()
  - runtime files/gamedata/scripts/grok_casings_sounds.script:348:function actor_on_first_update()
  - runtime files/gamedata/scripts/grok_artefacts_bip.script:81:function actor_on_first_update()
  - runtime files/gamedata/scripts/grok_artefacts_bip.script:88:function actor_on_update()
  - runtime files/gamedata/scripts/vks_trade_inject.script:97:function trader_autoinject.update(npc)
  - runtime files/gamedata/scripts/liz_inertia_expanded_crawl.script:86:function actor_on_update(_, delta)
  - runtime files/gamedata/scripts/pda_inter_x_tasks.script:350:function actor_on_first_update()
  - runtime files/gamedata/scripts/pda_inter_x_tasks.script:488:function setup_tasks_on_update()
  - runtime files/gamedata/scripts/pda_inter_x_tasks.script:952:function manage_cooldowns_on_update()
  - runtime files/gamedata/scripts/pda_inter_x_tasks.script:980:function manage_tasks_on_update()
  - runtime files/gamedata/scripts/pda_inter_x_tasks.script:1113:function manage_pda_x_on_update()
  - runtime files/gamedata/scripts/z_mark_switch.script:148:function actor_on_update()
  - runtime files/gamedata/scripts/grok_sniper_remover.script:42:function actor_on_update()
  - runtime files/gamedata/scripts/modxml_tutorial_hooks.script:252:function actor_on_first_update()
  - runtime files/gamedata/scripts/liz_fdda_redone_backpack_equip.script:24:function actor_on_first_update()
  - runtime files/gamedata/scripts/pda_inter_x_trade.script:101:function setup_traders_on_update()
  - runtime files/gamedata/scripts/pda_inter_x_trade.script:248:function manage_orders_on_update()
  - runtime files/gamedata/scripts/model_dropper_mcm.script:136:function actor_on_update()
  - runtime files/gamedata/scripts/model_dropper_mcm.script:166:function actor_on_first_update()
  - runtime files/gamedata/scripts/zz_item_artefact.script:130:object_binder.update(self, delta)
  - runtime files/gamedata/scripts/grok_nes.script:235:function npc_on_update(npc)
  - runtime files/gamedata/scripts/arszi_psy.script:65:function actor_on_update()
  - runtime files/gamedata/scripts/outfit_speed_mcm.script:13:local function actor_on_update()
  - runtime files/gamedata/scripts/drx_da_main_traders.script:75:function trader_autoinject.update(npc)
  - runtime files/gamedata/scripts/fix_beefnvg_anim.script:3:function actor_on_first_update()
  - runtime files/gamedata/scripts/lua_help_ex.script:394:function get_total_weight_force_update()
  - runtime files/gamedata/scripts/haru_specialized_storage_boxes.script:127:binder_update(self, delta)
  - runtime files/gamedata/scripts/axr_companions.script:86:local function squad_on_first_update(squad)
  - runtime files/gamedata/scripts/axr_companions.script:103:local function squad_on_update(squad)
  - runtime files/gamedata/scripts/axr_companions.script:266:local function actor_on_first_update()
  - runtime files/gamedata/scripts/factionID_hud_mcm.script:157:function actor_on_first_update()
  - runtime files/gamedata/scripts/factionID_hud_mcm.script:405:function actor_on_update()
  - runtime files/gamedata/scripts/hidden_threat.script:16:local function hidden_threat_update()
  - runtime files/gamedata/scripts/hidden_threat.script:207:local function actor_on_first_update()
  - runtime files/gamedata/scripts/grok_actor_damage_balancer.script:970:function actor_on_first_update()
  - runtime files/gamedata/scripts/ish_kill_tracker.script:657:local function actor_on_first_update()
  - runtime files/gamedata/scripts/dead_device.script:13:function actor_on_update()
  - runtime files/gamedata/scripts/dead_device.script:18:zz_glowstick_mcm.actor_on_update()
  - runtime files/gamedata/scripts/grok_dynamic_despawner.script:187:local function npc_on_update(npc)
  - runtime files/gamedata/scripts/grok_dynamic_despawner.script:220:local function monster_on_update(npc)
  - runtime files/gamedata/scripts/grok_dynamic_despawner.script:250:local function actor_on_update()
  - runtime files/gamedata/scripts/quickdraw.script:41:function actor_on_update()
  - runtime files/gamedata/scripts/scope_fov_mcm.script:37:local function actor_on_first_update()
  - runtime files/gamedata/scripts/utils_catspaw_taskmonitor.script:122:function actor_on_update()
  - runtime files/gamedata/scripts/lam2.script:260:function actor_on_update(_, delta)
  - runtime files/gamedata/scripts/m1a1_autoinject.script:51:function trader_autoinject.update(npc)
  - runtime files/gamedata/scripts/zz_glowstick_mcm.script:54:function actor_on_update()
  - runtime files/gamedata/scripts/zz_glowstick_mcm.script:226:function actor_on_first_update()
  - runtime files/gamedata/scripts/zz_glowstick_mcm.script:514:function glowstick_binder:update(delta)
  - runtime files/gamedata/scripts/zz_glowstick_mcm.script:953:function trader_autoinject.update(npc)
  - runtime files/gamedata/scripts/sim_offline_combat.script:105:local function smart_terrain_on_update(smart)
  - runtime files/gamedata/scripts/sim_offline_combat.script:171:local function squad_on_update(squad_1)
  - runtime files/gamedata/scripts/grok_psy_fields_in_the_north.script:28:local function actor_on_first_update()
  - runtime files/gamedata/scripts/grok_psy_fields_in_the_north.script:51:function actor_on_update()
  - runtime files/gamedata/scripts/operacia_monolith.script:7:function actor_on_update()
  - runtime files/gamedata/scripts/subtitles_ui.script:319:function hud_update()
  - runtime files/gamedata/scripts/subtitles_ui.script:441:function on_first_update()
  - runtime files/gamedata/scripts/subtitles_ui.script:456:hud_update()
  - runtime files/gamedata/scripts/bind_crow.script:59:function crow_binder:update(delta)
  - runtime files/gamedata/scripts/bind_crow.script:61:object_binder.update(self, delta)
  - runtime files/gamedata/scripts/kit_binder.script:20:function kit_binder:update(delta)
  - runtime files/gamedata/scripts/ish_campfire_saving.script:185:function actor_on_first_update()
  - runtime files/gamedata/scripts/tasks_chimera_scan.script:51:function send_update(task_id)
  - runtime files/gamedata/scripts/npe_logging.script:129:local function actor_on_first_update()
  - runtime files/gamedata/scripts/item_artefact.script:221:local function actor_on_first_update()
  - runtime files/gamedata/scripts/item_artefact.script:352:function artefact_binder:update(delta)
  - runtime files/gamedata/scripts/item_artefact.script:353:object_binder.update(self, delta)
  - runtime files/gamedata/scripts/game_setup.script:367:local function actor_on_first_update()
  - runtime files/gamedata/scripts/game_setup.script:456:local function actor_on_update()
  - runtime files/gamedata/scripts/tasks_mirage.script:266:function actor_on_update()
  - runtime files/gamedata/scripts/melee_trade_inject.script:68:function trader_autoinject.update(npc)
  - runtime files/gamedata/scripts/tasks_defense.script:92:function actor_on_first_update()
  - runtime files/gamedata/scripts/tasks_defense.script:154:function npc_on_update(npc)
  - runtime files/gamedata/scripts/bind_anomaly_field.script:221:function dyn_anomalies_update()
  - runtime files/gamedata/scripts/bind_anomaly_field.script:339:pAno_light:update()
  - runtime files/gamedata/scripts/bind_anomaly_field.script:412:function pulse_anomaly_update()
  - runtime files/gamedata/scripts/bind_anomaly_field.script:421:pAno_light:update()
  - runtime files/gamedata/scripts/bind_anomaly_field.script:475:local function actor_on_first_update()
  - runtime files/gamedata/scripts/bind_anomaly_field.script:483:local function actor_on_update()
  - runtime files/gamedata/scripts/bind_anomaly_field.script:484:pulse_anomaly_update()
  - runtime files/gamedata/scripts/bind_anomaly_field.script:609:function anomaly_field_binder:update(delta)
  - runtime files/gamedata/scripts/bind_anomaly_field.script:610:object_binder.update(self, delta)
  - runtime files/gamedata/scripts/grok_gamma_manual_on_startup.script:5:-- function actor_on_first_update()
  - runtime files/gamedata/scripts/campfire_placeable.script:35:function actor_on_first_update()
  - runtime files/gamedata/scripts/campfire_placeable.script:428:function trader_autoinject.update(npc)
  - runtime files/gamedata/scripts/item_exo_device.script:265:function actor_on_first_update()
  - runtime files/gamedata/scripts/item_exo_device.script:320:function actor_on_update()
  - runtime files/gamedata/scripts/npe_events.script:259:local function actor_on_update()
  - runtime files/gamedata/scripts/drx_da_main.script:2772:bind_anomaly_field_update(self, delta)
  - runtime files/gamedata/scripts/drx_da_main.script:2850:function actor_on_update()
  - runtime files/gamedata/scripts/drx_da_main.script:3088:function actor_on_first_update()
  - runtime files/gamedata/scripts/meat_spoiling.script:38:function actor_on_update()
  - runtime files/gamedata/scripts/smr_loot.script:407:local function actor_on_first_update()
  - runtime files/gamedata/scripts/zzz_bas_laser_control.script:37:function actor_on_update()
  - runtime files/gamedata/scripts/test_npe_execution_client.script:325:local function client_on_update()
  - runtime files/gamedata/scripts/test_npe_execution_client.script:329:function client_on_first_update()
  - runtime files/gamedata/scripts/zzz_craft_use_in_tooltip_mcm.script:184:og_info_item_update(self, obj, sec, flags)
  - runtime files/gamedata/scripts/anom_stash_trade.script:141:function trader_autoinject.update(npc)
  - runtime files/gamedata/scripts/game_fast_travel.script:1795:function actor_on_first_update()
  - runtime files/gamedata/scripts/game_fast_travel.script:1807:function actor_on_update()
  - runtime files/gamedata/scripts/dynamic_npc_armor_visuals.script:54:function npc_armor_visual_update(npc)
  - runtime files/gamedata/scripts/liz_fdda_redone_backpack.script:29:function actor_on_first_update()
  - runtime files/gamedata/scripts/custom_functor_autoinject.script:435:local function actor_on_first_update()
  - runtime files/gamedata/scripts/detec_bone_hide.script:19:function actor_on_update()
  - runtime files/gamedata/scripts/liz_fdda_redone_mutant_skinning.script:27:function actor_on_first_update()
  - runtime files/gamedata/scripts/z_ph_door_bar_arena_remover.script:50:function actor_on_first_update()
  - runtime files/gamedata/scripts/liz_fdda_redone_headgear_animations.script:27:function actor_on_first_update()
  - runtime files/gamedata/scripts/tasks_urgent_orders.script:15:function actor_on_first_update()
  - runtime files/gamedata/scripts/camp_lum.script:8:function actor_on_first_update()
  - runtime files/gamedata/scripts/tasks_placeable_waypoints.script:5312:function actor_on_update()
  - runtime files/gamedata/scripts/tasks_placeable_waypoints.script:5316:function actor_on_first_update()
  - runtime files/gamedata/scripts/sim_squad_warfare.script:70:function squad_on_update(squad)
  - runtime files/gamedata/scripts/sim_squad_warfare.script:164:squad_warfare_update(squad)
  - runtime files/gamedata/scripts/sim_squad_warfare.script:198:function squad_warfare_update(squad)
  - runtime files/gamedata/scripts/z_companions_dont_blow_disguises.script:21:orig_gameplay_disguise_npc_on_update(npc)
  - runtime files/gamedata/scripts/liz_fdda_redone_armor_plate.script:26:function actor_on_first_update()
  - runtime files/gamedata/scripts/ssfx_rain_footsteps.script:32:function actor_on_first_update()
  - runtime files/gamedata/scripts/true_first_person_death.script:68:function actor_on_first_update()
  - runtime files/gamedata/scripts/bas_nvg_scopes.script:55:function bas_actor_on_update()
  - runtime files/gamedata/scripts/ui_debug_launcher.script:197:trade_manager.update(o1, true)
  - runtime files/gamedata/scripts/smr_pop.script:1425:local function actor_on_first_update()
  - runtime files/gamedata/scripts/nta_utils.script:516:pAno_light:update()
  - runtime files/gamedata/scripts/nta_utils.script:521:pAno_light:update()
  - runtime files/gamedata/scripts/nta_utils.script:601:function actor_on_first_update()
  - runtime files/gamedata/scripts/despawn_monolith_grenades.script:17:function trader_autoinject.update(npc)
  - runtime files/gamedata/scripts/zz_treasure_manager_pba_less_artys.script:109:function actor_on_first_update()
  - runtime files/gamedata/scripts/dotmarks_callbacks.script:80:on_quickhelp_text_update(raw_text, loc_string, trimmed_text, flags)
  - runtime files/gamedata/scripts/soulslike.script:936:local function actor_on_first_update()
  - runtime files/gamedata/scripts/rax_icon_layers.script:66:return base_update(self, obj)
  - runtime files/gamedata/scripts/uni_anim_knives.script:78:-- function actor_on_first_update()
  - runtime files/gamedata/scripts/grok_masks_reflections.script:110:function actor_on_first_update()
  - runtime files/gamedata/scripts/placeable_furniture.script:187:local function actor_on_update()
  - runtime files/gamedata/scripts/tasks_guide.script:258:function actor_on_update()
  - runtime files/gamedata/scripts/tasks_guide.script:270:function actor_on_first_update()
  - runtime files/gamedata/scripts/swm_legs.script:915:function actor_update()
  - runtime files/gamedata/scripts/swm_legs.script:957:function actor_on_first_update()
  - runtime files/gamedata/scripts/item_milpda.script:803:function actor_on_first_update()
  - runtime files/gamedata/scripts/actor_status_sleep.script:200:function actor_on_update()
  - runtime files/gamedata/scripts/bind_light_furniture.script:95:function placeable_light_wrapper:update(delta)
  - runtime files/gamedata/scripts/bind_light_furniture.script:96:bind_hf_base.hf_binder_wrapper.update(self, delta)
  - runtime files/gamedata/scripts/actor_status_thirst.script:167:function actor_on_update(b,d)
  - runtime files/gamedata/scripts/lower_weapon_sprint.script:234:local function actor_on_update()
  - runtime files/gamedata/scripts/perk_based_artefacts.script:1165:light:update()
  - runtime files/gamedata/scripts/perk_based_artefacts.script:1230:light:update()
  - runtime files/gamedata/scripts/perk_based_artefacts.script:1250:light:update()
  - runtime files/gamedata/scripts/perk_based_artefacts.script:3911:light:update()
  - runtime files/gamedata/scripts/perk_based_artefacts.script:4257:monster_update(self, delta)
  - runtime files/gamedata/scripts/perk_based_artefacts.script:4522:function actor_on_update()
  - runtime files/gamedata/scripts/perk_based_artefacts.script:4709:function actor_on_first_update()
  - runtime files/gamedata/scripts/bind_digital_clock_furniture.script:20:function haru_placeable_digital_clock_wrapper:update(delta)
  - runtime files/gamedata/scripts/bind_digital_clock_furniture.script:21:bind_hf_base.hf_binder_wrapper.update(self, delta)
  - runtime files/gamedata/scripts/warfare.script:309:function actor_on_update()
  - runtime files/gamedata/scripts/warfare.script:428:warfare_levels.update()
  - runtime files/gamedata/scripts/warfare.script:429:warfare_factions.update()
  - runtime files/gamedata/scripts/warfare.script:432:warfare_levels.update()
  - runtime files/gamedata/scripts/warfare.script:433:warfare_factions.update()
  - runtime files/gamedata/scripts/new_tasks_addon_tasks_utils.script:407:function actor_on_first_update()
  - runtime files/gamedata/scripts/liz_fdda_redone_headgear_animations_hotkey.script:82:function actor_on_first_update()
  - runtime files/gamedata/scripts/z_3d_scopes.script:171:function actor_on_update()
  - runtime files/gamedata/scripts/TB_Coordinate_Based_Safe_Zones.script:176:function actor_on_update()
  - runtime files/gamedata/scripts/leer_fdda_redone_af_inspect.script:113:light:update()
  - runtime files/gamedata/scripts/leer_fdda_redone_af_inspect.script:130:light:update()
  - runtime files/gamedata/scripts/leer_fdda_redone_af_inspect.script:142:light:update()
  - runtime files/gamedata/scripts/item_radio.script:1011:local function actor_on_first_update()
  - runtime files/gamedata/scripts/item_radio.script:1111:local function actor_on_update()
  - runtime files/gamedata/scripts/safe_start_mcm.script:70:function actor_on_update()
  - runtime files/gamedata/scripts/safe_start_mcm.script:82:function actor_on_first_update()
  - runtime files/gamedata/scripts/grok_vehicles_spawner.script:48:function actor_on_first_update()
  - runtime files/gamedata/scripts/smart_terrain.script:1238:function se_smart_terrain:update()
  - runtime files/gamedata/scripts/smart_terrain.script:1239:cse_alife_smart_zone.update( self )
  - runtime files/gamedata/scripts/dialogs_lostzone.script:842:local function actor_on_first_update()
  - runtime files/gamedata/scripts/agroprom_drugkit_spawner_gamma.script:1:function actor_on_first_update()
  - runtime files/gamedata/scripts/placeable_radio.script:163:function placeable_radio_wrapper:update(delta)
  - runtime files/gamedata/scripts/item_device.script:378:local function actor_on_first_update()
  - runtime files/gamedata/scripts/item_device.script:700:function device_binder:update(delta)
  - runtime files/gamedata/scripts/item_device.script:701:object_binder.update(self, delta)
  - runtime files/gamedata/scripts/ground_coffee.script:84:function trader_autoinject.update(npc)
  - runtime files/gamedata/scripts/actor_status.script:476:local function actor_on_first_update()
  - runtime files/gamedata/scripts/actor_status.script:483:local function actor_on_update()
  - runtime files/gamedata/scripts/souslike_gamemode_injector_mcm.script:125:local function actor_on_first_update()
  - runtime files/gamedata/scripts/coffee_drink.script:84:function trader_autoinject.update(npc)
  - runtime files/gamedata/scripts/grok_gotta_go_fast.script:3:local function actor_on_first_update()
  - runtime files/gamedata/scripts/grok_gotta_go_fast.script:9:function actor_on_update()
  - runtime files/gamedata/scripts/wpn_sway_enable.script:19:function actor_on_first_update()
  - runtime files/gamedata/scripts/wpn_sway_enable.script:59:function actor_on_update()
  - runtime files/gamedata/scripts/pda_inter_gui.script:1129:function actor_on_update()
  - runtime files/gamedata/scripts/pda_inter_gui.script:1147:function actor_on_first_update()
  - runtime files/gamedata/scripts/AGDD_voiced_actor.script:257:function actor_on_update(binder,delta) --thinker function, handles conditional sounds
  - runtime files/gamedata/scripts/ssfx_rain_hud_raindrops.script:28:local function actor_on_update()
  - runtime files/gamedata/scripts/ssfx_rain_hud_raindrops.script:73:function actor_on_first_update()
  - runtime files/gamedata/scripts/emission_guard_patch.script:1:function actor_on_first_update()
  - runtime files/gamedata/scripts/emission_guard_patch.script:11:function squad_on_update(squad)

## warfare_options.script

### Function `override_functions`
- Runtime: `override_functions()`
- Gamma: `override_functions()`
- Callsites: None found
