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
- Callsites: None found

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
  - gamma_walo/gamedata/scripts/smart_terrain_warfare.script:894:	if (not game_relations.is_relation_allowed(faction_1,faction_2)) or (game_relations.is_faction_pair_unaffected(faction_1,faction_2)) or (faction_1 == faction_2) then
  - runtime files/gamedata/scripts/gameplay_disguise.script:977:				and (not game_relations.is_faction_pair_unaffected(comm, default_comm))
  - runtime files/gamedata/scripts/smart_terrain_warfare.script:893:	if (not game_relations.is_relation_allowed(faction_1,faction_2)) or (game_relations.is_faction_pair_unaffected(faction_1,faction_2)) or (faction_1 == faction_2) then

### Function `is_relation_allowed`
- Runtime: `is_relation_allowed(faction_1 , faction_2)`
- Gamma: `is_relation_allowed(faction_1 , faction_2)`
- Callsites:
  - gamma_walo/gamedata/scripts/smart_terrain_warfare.script:894:	if (not game_relations.is_relation_allowed(faction_1,faction_2)) or (game_relations.is_faction_pair_unaffected(faction_1,faction_2)) or (faction_1 == faction_2) then
  - runtime files/gamedata/scripts/smart_terrain_warfare.script:893:	if (not game_relations.is_relation_allowed(faction_1,faction_2)) or (game_relations.is_faction_pair_unaffected(faction_1,faction_2)) or (faction_1 == faction_2) then

### Function `reset_all_relations`
- Runtime: `reset_all_relations()`
- Gamma: `reset_all_relations()`
- Callsites: None found

### Function `calculate_relation_change`
- Runtime: `calculate_relation_change(victim_tbl, killer_tbl)`
- Gamma: `calculate_relation_change(victim_tbl, killer_tbl)`
- Callsites: None found

### Function `get_random_enemy_faction`
- Runtime: `get_random_enemy_faction(comm)`
- Gamma: `get_random_enemy_faction(comm)`
- Callsites:
  - runtime files/gamedata/scripts/xr_effects.script:3762:	local rnd_enemy = game_relations.get_random_enemy_faction(community)

### Function `get_random_natural_faction`
- Runtime: `get_random_natural_faction(comm)`
- Gamma: `get_random_natural_faction(comm)`
- Callsites:
  - runtime files/gamedata/scripts/xr_effects.script:3763:	local rnd_natural = game_relations.get_random_natural_faction(community)

### Function `online_npc_on_death`
- Runtime: `online_npc_on_death(victim, killer)`
- Gamma: `online_npc_on_death(victim, killer)`
- Callsites: None found

### Function `get_rank_relation`
- Runtime: `get_rank_relation(obj_1, obj_2)`
- Gamma: `get_rank_relation(obj_1, obj_2)`
- Callsites:
  - runtime files/gamedata/scripts/ui_debug_launcher.script:148:		send_output('/Goodwill (Rank): %s', game_relations.get_rank_relation(o1, target) )

### Function `get_reputation_relation`
- Runtime: `get_reputation_relation(obj_1, obj_2)`
- Gamma: `get_reputation_relation(obj_1, obj_2)`
- Callsites:
  - runtime files/gamedata/scripts/ui_debug_launcher.script:149:		send_output('/Goodwill (Reputation): %s', game_relations.get_reputation_relation(o1, target) )

## smart_terrain_warfare.script

### Function `process_targets`
- Runtime: `process_targets(smart)`
- Gamma: `process_targets(smart)`
- Callsites: None found

## tasks_assault.script

### Function `evaluate_smarts_squads`
- Runtime: `evaluate_smarts_squads(task_id, tbl, smart, squad_def, faction_def)`
- Gamma: `evaluate_smarts_squads(task_id, tbl, smart, squad_def, faction_def)`
- Callsites:
  - gamma_walo/gamedata/scripts/tasks_smart_control.script:61:function evaluate_smarts_squads(task_id, tbl, smart, squad_def, faction_def)
  - gamma_walo/gamedata/scripts/tasks_smart_control.script:387:			evaluate_smarts_squads(task_id, targets, smart, def, enemy_faction_list)
  - runtime files/gamedata/scripts/tasks_dominance.script:58:function evaluate_smarts_squads(task_id, tbl, smart, squad_def, faction_def)
  - runtime files/gamedata/scripts/tasks_dominance.script:320:				evaluate_smarts_squads(task_id, targets, v, def, enemy_faction_list)
  - runtime files/gamedata/scripts/tasks_smart_control.script:60:function evaluate_smarts_squads(task_id, tbl, smart, squad_def, faction_def)
  - runtime files/gamedata/scripts/tasks_smart_control.script:386:			evaluate_smarts_squads(task_id, targets, smart, def, enemy_faction_list)

### Function `evaluate_squads_smarts`
- Runtime: `evaluate_squads_smarts(task_id, var, squad, smart)`
- Gamma: `evaluate_squads_smarts(task_id, var, squad, smart)`
- Callsites:
  - gamma_walo/gamedata/scripts/tasks_smart_control.script:103:function evaluate_squads_smarts(task_id, var, smart, smrt)
  - gamma_walo/gamedata/scripts/tasks_smart_control.script:295:		local squad_id = evaluate_squads_smarts(task_id, var, smart, smrt)
  - runtime files/gamedata/scripts/tasks_dominance.script:98:function evaluate_squads_smarts(task_id, scripted, smart, smrt)
  - runtime files/gamedata/scripts/tasks_dominance.script:235:			local squad_id = evaluate_squads_smarts(task_id, scripted, smrt_n, smrt_v)
  - runtime files/gamedata/scripts/tasks_smart_control.script:102:function evaluate_squads_smarts(task_id, var, smart, smrt)
  - runtime files/gamedata/scripts/tasks_smart_control.script:294:		local squad_id = evaluate_squads_smarts(task_id, var, smart, smrt)

### Function `postpone_for_next_frame`
- Runtime: `postpone_for_next_frame(task_id, squad_id)`
- Gamma: `postpone_for_next_frame(task_id, squad_id)`
- Callsites:
  - gamma_walo/gamedata/scripts/tasks_smart_control.script:137:function postpone_for_next_frame(task_id, squad_id)
  - runtime files/gamedata/scripts/tasks_fate.script:190:	local function postpone_for_next_frame(map,freq)
  - runtime files/gamedata/scripts/tasks_dominance.script:130:function postpone_for_next_frame(task_id, community, lvl)
  - runtime files/gamedata/scripts/tasks_bounty.script:216:	local function postpone_for_next_frame(target_id)
  - runtime files/gamedata/scripts/monkey_rioc.script:4:    local function postpone_for_next_frame(x)
  - runtime files/gamedata/scripts/tasks_delivery.script:161:	local function postpone_for_next_frame(target_id)
  - runtime files/gamedata/scripts/tasks_smart_control.script:136:function postpone_for_next_frame(task_id, squad_id)
  - runtime files/gamedata/scripts/monkey_tasks_smart_control.script:3:function tasks_smart_control.postpone_for_next_frame(task_id, squad_id)
  - runtime files/gamedata/scripts/tasks_measure.script:171:function postpone_for_next_frame(task_id,level_target)
  - runtime files/gamedata/scripts/tasks_stash.script:123:	local function postpone_for_next_frame()

## ui_options.script

### Function `init_opt_base`
- Runtime: `init_opt_base()`
- Gamma: `init_opt_base()`
- Callsites:
  - runtime files/gamedata/scripts/ui_main_menu.script:24:	ui_mcm.init_opt_base()
  - runtime files/gamedata/scripts/ui_mcm.script:182:function init_opt_base()
  - runtime files/gamedata/scripts/ui_mcm.script:380:	init_opt_base()
  - runtime files/gamedata/scripts/ui_mcm.script:651:		init_opt_base()
  - runtime files/gamedata/scripts/ui_mcm.script:731:		init_opt_base()
  - runtime files/gamedata/scripts/ui_sidhud_mcm.script:273:		ui_options.init_opt_base()
  - runtime files/gamedata/scripts/ui_options_modded_exes.script:10:	ui_options.init_opt_base()

## ui_pda_warfare_tab.script

### Function `pda_warfare_tab`
- Runtime: not found
- Gamma: not found
- Callsites: None found

## warfare.script

### Function `initialize`
- Runtime: `initialize()`
- Gamma: `initialize()`
- Callsites:
  - runtime files/gamedata/scripts/z_npc_footsteps.script:73:	self.st.move_mgr:initialize()
  - runtime files/gamedata/scripts/liz_fdda_redone_item_pickup.script:23:function initialize()
  - runtime files/gamedata/scripts/actor_status_gasmask.script:11:function initialize()
  - runtime files/gamedata/scripts/liz_fdda_redone_outfit.script:142:function initialize()
  - runtime files/gamedata/scripts/psi_storm_manager.script:39:function CPsiStormManager:initialize()
  - runtime files/gamedata/scripts/psi_storm_manager.script:74:		self:initialize()
  - runtime files/gamedata/scripts/psi_storm_manager.script:274:		self:initialize()
  - runtime files/gamedata/scripts/psi_storm_manager.script:606:		mgr:initialize()
  - runtime files/gamedata/scripts/psi_storm_manager.script:628:	mgr:initialize()
  - runtime files/gamedata/scripts/psi_storm_manager.script:662:		mgr:initialize()

### Function `on_game_start`
- Runtime: `on_game_start()`
- Gamma: `on_game_start()`
- Callsites:
  - gamma_walo/gamedata/scripts/sim_offline_combat.script:771:function on_game_start()
  - gamma_walo/gamedata/scripts/game_fast_travel.script:203:function on_game_start()
  - gamma_walo/gamedata/scripts/game_fast_travel.script:1887:function on_game_start()
  - gamma_walo/gamedata/scripts/faction_expansions.script:206:function on_game_start()
  - gamma_walo/gamedata/scripts/ui_mm_faction_select.script:433:function on_game_start()
  - gamma_walo/gamedata/scripts/game_relations.script:578:function on_game_start() -- Register NPC killed callback and restore faction relations:
  - gamma_walo/gamedata/scripts/sim_squad_scripted.script:1441:-- function on_game_start()
  - gamma_walo/gamedata/scripts/warfare_options.script:304:function on_game_start()
  - runtime files/gamedata/scripts/weapon_cover_tilt.script:1247:function on_game_start()
  - runtime files/gamedata/scripts/utils_catspaw_hudmarks.script:1690:function on_game_start()

### Function `sort_priority_table`
- Runtime: `sort_priority_table(tbl)`
- Gamma: `sort_priority_table(tbl)`
- Callsites: None found

## warfare_factions.script

### Function `update`
- Runtime: `update()`
- Gamma: `update()`
- Callsites:
  - gamma_walo/gamedata/scripts/sim_offline_combat.script:106:local function smart_terrain_on_update(smart)
  - gamma_walo/gamedata/scripts/sim_offline_combat.script:176:local function squad_on_update(squad_1)
  - gamma_walo/gamedata/scripts/game_fast_travel.script:1795:function actor_on_first_update()
  - gamma_walo/gamedata/scripts/game_fast_travel.script:1807:function actor_on_update()
  - gamma_walo/gamedata/scripts/ui_mm_faction_select.script:381:local function actor_on_first_update(binder,delta)
  - gamma_walo/gamedata/scripts/sim_squad_scripted.script:144:function sim_squad_scripted:update()
  - gamma_walo/gamedata/scripts/sim_squad_scripted.script:146:	cse_alife_online_offline_group.update(self)
  - gamma_walo/gamedata/scripts/sim_squad_scripted.script:235:		self:specific_update(script_target_id)
  - gamma_walo/gamedata/scripts/sim_squad_scripted.script:237:		self:generic_update()
  - gamma_walo/gamedata/scripts/sim_squad_scripted.script:276:function sim_squad_scripted:specific_update(script_target_id) -- This update is called for all squads with a scripted smart_terrain target

## warfare_options.script

### Function `override_functions`
- Runtime: `override_functions()`
- Gamma: `override_functions()`
- Callsites: None found
