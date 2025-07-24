# Runtime vs Gamma_Walo Diff

This report compares scripts in `runtime files/gamedata/scripts` against their counterparts in `gamma_walo/gamedata/scripts`.

| File | Added | Removed | Verdict |
| ---- | ----- | ------- | ------- |
| dialogs.script | 3 | 0 | keep |

<details><summary>Diff for dialogs.script</summary>
```diff
--- runtime files/gamedata/scripts/dialogs.script
+++ gamma_walo/gamedata/scripts/dialogs.script
@@ -32,6 +32,7 @@
 	task_manager.get_task_manager():give_task("mar_find_doctor_task")
 end
 
+-- Helper used in dialog preconditions to hide options when Warfare is active
 function warfare_disabled(a,b)
 	if _G.WARFARE then
 		return false
@@ -43,6 +44,7 @@
 -- Task stacking check
 -------------------------------------------
 local mark_task_per_npc = {}
+-- Returns the maximum simultaneous tasks an NPC can offer based on options
 function get_npc_task_limit()
 	return tonumber(ui_options.get("gameplay/general/max_tasks") or 2)
 end
@@ -1793,7 +1795,7 @@
 -----------------------------------------------------------------------------------
 -- TRADE
 -----------------------------------------------------------------------------------
---' ������������� ��������
+--'  
 function trade_init(seller, buyer)
 	db.storage[seller:id()].meet.begin_wait_to_see.begin = time_global()/1000
 	xr_position.setPosition(db.storage[seller:id()].meet.Seller,
```
</details>
| faction_expansions.script | 4 | 1 | keep |

<details><summary>Diff for faction_expansions.script</summary>
```diff
--- runtime files/gamedata/scripts/faction_expansions.script
+++ gamma_walo/gamedata/scripts/faction_expansions.script
@@ -7,7 +7,8 @@
 	2020/05/25 - Vintar
 	2020/05/31 - Vintar - lowered loner veteran chance
 	2021/02/27 - Vintar - lowered loner advanced/veteran chance again, removed rats from spawn
-	2021/03/02 - Vintar - removed black smoke poltergeist
+        2021/03/02 - Vintar - removed black smoke poltergeist
+        2025/07/24 - d0pe - documented spawn chance formulas
 
 	This file provides the chance for advanced/veteran squads to spawn instead of novice
 	squads, or picks a normal/rare mutant spawn section.
@@ -132,11 +133,13 @@
 
 -- old functions were overly complicated and had a weird minimum at 80% resource ownership where your squads would be worse on average
 -- new functions are monotonically increasing so that each point of resource is always a sizeable benefit
+-- Chance percentage for an advanced squad spawn given owned resources
 function get_advanced_chance(resource)
 --	return -1 * (100 * (1 / math.pow(warfare.resource_count / 2, 2))) * math.pow((resource - (warfare.resource_count / 2)), 2) + 100
 	return 150 * (math.pow((resource / warfare.resource_count), 0.8))
 end
 
+-- Chance percentage for a veteran squad spawn given owned resources
 function get_veteran_chance(resource)
 --	return -100 + (100 / (warfare.resource_count / 2)) * resource
 	return 100 * (math.pow((resource / warfare.resource_count), 2))
```
</details>
| game_fast_travel.script | 0 | 0 | keep |

<details><summary>Diff for game_fast_travel.script</summary>
```diff
```
</details>
| game_relations.script | 93 | 95 | keep |

<details><summary>Diff for game_relations.script</summary>
```diff
--- runtime files/gamedata/scripts/game_relations.script
+++ gamma_walo/gamedata/scripts/game_relations.script
@@ -24,36 +24,35 @@
 	-- rank_goodwill 								- the relation of rank of the character to the rank of the actor from [rank_relations]
 
 --]]
+
+
 function safe_ini_r_float(ini, section, key, fallback)
-	if ini and ini:section_exist(section) and ini:line_exist(section, key) then
-		return ini:r_float(section, key)
-	else
-		return fallback
-	end
+        if ini and ini:section_exist(section) and ini:line_exist(section, key) then
+                return ini:r_float(section, key)
+        else
+                return fallback
+        end
 end
 
 function safe_ini_r_s32(ini, section, key, fallback)
-	if ini and ini:section_exist(section) and ini:line_exist(section, key) then
-		return ini:r_s32(section, key)
-	else
-		return fallback
-	end
-end
-
-
-
+        if ini and ini:section_exist(section) and ini:line_exist(section, key) then
+                return ini:r_s32(section, key)
+        else
+                return fallback
+        end
+end
 --========================================< Controls >========================================--
 local ini_r
 if system_ini():section_exist("plugins\dynamic_faction_relations") then
-	ini_r = ini_file("plugins\dynamic_faction_relations.ltx")
+        ini_r = ini_file("plugins\dynamic_faction_relations.ltx")
 else
-	printf("[game_relations.script] WARNING: Missing dynamic_faction_relations.ltx")
+        printf("[game_relations.script] WARNING: Missing dynamic_faction_relations.ltx")
 end
 local ini_g
 if system_ini():section_exist("creatures\game_relations") then
-	ini_g = ini_file("creatures\game_relations.ltx")
+        ini_g = ini_file("creatures\game_relations.ltx")
 else
-	printf("[game_relations.script] WARNING: Missing game_relations.ltx")
+        printf("[game_relations.script] WARNING: Missing game_relations.ltx")
 end
 factions_table = {"stalker","bandit","csky","dolg","freedom","killer","army","ecolog","monolith","renegade","greh","isg"}
 factions_table_all = {"actor","bandit","dolg","ecolog","freedom","killer","army","monolith","monster","stalker","zombied","csky","renegade","greh","isg","trader","actor_stalker","actor_bandit","actor_dolg","actor_freedom","actor_csky","actor_ecolog","actor_killer","actor_army","actor_monolith","actor_renegade","actor_greh","actor_isg","actor_zombied","arena_enemy"}
@@ -153,13 +152,13 @@
 		return false
 	end
 	
-	for i=1,#blacklist_pair do
-		if (blacklist_pair[i][1] == fac1) and (blacklist_pair[i][2] == fac2) then
-			return true
-		elseif (blacklist_pair[i][2] == fac1) and (blacklist_pair[i][1] == fac2) then
-			return true
-		end
-	end
+        for _, pair in ipairs(blacklist_pair or {}) do -- added nil check
+                if (pair[1] == fac1) and (pair[2] == fac2) then
+                        return true
+                elseif (pair[2] == fac1) and (pair[1] == fac2) then
+                        return true
+                end
+        end
 	return false
 end
 
@@ -188,13 +187,13 @@
 	end
 	
 	-- Check blacklisted pairs 
-	for i = 1, #blacklist_pair do
-		if (blacklist_pair[i][1] == faction_1) and (blacklist_pair[i][2] == faction_2) then
-			return false
-		elseif (blacklist_pair[i][2] == faction_1) and (blacklist_pair[i][1] == faction_2) then
-			return false
-		end
-	end
+        for _, pair in ipairs(blacklist_pair or {}) do -- added nil check
+                if (pair[1] == faction_1) and (pair[2] == faction_2) then
+                        return false
+                elseif (pair[2] == faction_1) and (pair[1] == faction_2) then
+                        return false
+                end
+        end
 	
 	return true
 end
@@ -307,17 +306,17 @@
 
 function reset_all_relations()
 	local tbl = {}
-	for i=1, #factions_table_all do
-		local value = ini_g:r_string_ex("communities_relations" , factions_table_all[i])
-		tbl[factions_table_all[i]] = str_explode(value,",")
-	end
-	
-	for i=1,#factions_table_all do
-		for j=1,#factions_table_all do
-			set_factions_community_num( factions_table_all[i] , factions_table_all[j] , tonumber(tbl[factions_table_all[i]][j]) )
-			--printf("TRX - " .. factions_table_all[i] .. " + " .. factions_table_all[j] .. " = " .. tonumber(tbl[factions_table_all[i]][j]))
-		end
-	end
+        for _, faction in ipairs(factions_table_all or {}) do -- added nil check
+                local value = ini_g:r_string_ex("communities_relations" , faction)
+                tbl[faction] = str_explode(value,",")
+        end
+
+        for _, faction_i in ipairs(factions_table_all or {}) do -- added nil check
+                for index_j, faction_j in ipairs(factions_table_all or {}) do
+                        set_factions_community_num( faction_i , faction_j , tonumber(tbl[faction_i][index_j]) )
+                        --printf("TRX - " .. faction_i .. " + " .. faction_j .. " = " .. tonumber(tbl[faction_i][index_j]))
+                end
+        end
 end
 
 function calculate_relation_change( victim_tbl, killer_tbl)
@@ -355,18 +354,18 @@
 	local enemy_num = 0
 	local natural_num = 0
 	local friend_num = 0
-	for i=1,#factions_table do
-		if (victim_faction ~= factions_table[i]) then
-			local rel = get_factions_community( victim_faction , factions_table[i] )
-			if (rel <= -1000) then
-				enemy_num = enemy_num + 1
-			elseif (rel > -1000) and (rel < 1000) then
-				natural_num = natural_num + 1
-			elseif (rel > -1000) and (rel < 1000) then
-				friend_num = friend_num + 1
-			end
-		end
-	end
+        for _, faction in ipairs(factions_table or {}) do -- added nil check
+                if (victim_faction ~= faction) then
+                        local rel = get_factions_community( victim_faction , faction )
+                        if (rel <= -1000) then
+                                enemy_num = enemy_num + 1
+                        elseif (rel > -1000) and (rel < 1000) then
+                                natural_num = natural_num + 1
+                        elseif (rel >= 1000) then -- fixed logic irrationality
+                                friend_num = friend_num + 1
+                        end
+                end
+        end
 	
 	-- return if killer and victim are from the same faction
 	if (killer_faction == victim_faction) then
@@ -375,9 +374,9 @@
 
 	-- If killed NPC was enemy of faction, raise relation toward killer faction:
 	if ( math.random( 100 ) > 50 ) then
-		for i = 1, #factions_table do
-			if ( factions_table[i] ~= killer_faction ) then
-				if ( is_factions_enemies( factions_table[i], victim_faction ) ) then
+                for _, faction in ipairs(factions_table or {}) do -- added nil check
+                        if ( faction ~= killer_faction ) then
+                                if ( is_factions_enemies( faction, victim_faction ) ) then
 					if ( math.random( 100 ) > 50 ) then -- random faction picker
 						
 						-- Relation calculation:
@@ -396,8 +395,8 @@
 						
 						local value = math.floor( death_value * ( v_rank + ( k_rank / 5 ) ) * ( v_rep_bad + ( k_rep_good / 10 ) ) )
 						
-						if is_relation_allowed( factions_table[i] , killer_faction ) and ( natural_num + friend_num > friend_count_limit ) then
-							change_faction_relations( factions_table[i], killer_faction, value )
+                                                if is_relation_allowed( faction , killer_faction ) and ( natural_num + friend_num > friend_count_limit ) then
+                                                        change_faction_relations( faction, killer_faction, value )
 							--printf("- Relations: Relations positive change | " .. factions_table[i] .. " <-> " .. killer_faction .. " relation change = " .. value)
 						else
 							--printf("% Relations: Relations change | " .. factions_table[i] .. " <-> " .. killer_faction .. " relation can't be changed!")
@@ -414,9 +413,9 @@
 
 	-- If killed NPC was friend or neutral to faction, lower relation toward killer faction:
 	else
-		for i = 1, #factions_table do
-			if ( factions_table[i] ~= killer_faction ) then
-				if ( not is_factions_enemies( factions_table[i], victim_faction ) ) then
+                for _, faction in ipairs(factions_table or {}) do -- added nil check
+                        if ( faction ~= killer_faction ) then
+                                if ( not is_factions_enemies( faction, victim_faction ) ) then
 					if ( math.random( 100 ) > 50 ) then -- random faction picker
 					
 						-- Relation calculation:
@@ -435,8 +434,8 @@
 						
 						local value = math.floor( death_value * ( v_rank + ( k_rank / 5 ) ) * ( v_rep_good + ( k_rep_bad / 10 ) ) )
 
-						if is_relation_allowed( factions_table[i] , killer_faction ) and ( enemy_num > enemy_count_limit ) then
-							change_faction_relations( factions_table[i], killer_faction, -(value) )
+                                                if is_relation_allowed( faction , killer_faction ) and ( enemy_num > enemy_count_limit ) then
+                                                        change_faction_relations( faction, killer_faction, -(value) )
 							--printf("- Relations: Relations negative change | " .. factions_table[i] .. " <-> " .. killer_faction .. " relation change = " .. -(value))
 						else
 							--printf("% Relations: Relations change | " .. factions_table[i] .. " <-> " .. killer_faction .. " relation can't be changed!")
@@ -455,24 +454,24 @@
 
 local rnd_enemy = {}
 function get_random_enemy_faction(comm)
-	empty_table(rnd_enemy)
-	for i = 1, #factions_table do
-		if (comm ~= factions_table[i]) and is_factions_enemies(factions_table[i], comm) and is_relation_allowed(factions_table[i] , comm) then
-			rnd_enemy[#rnd_enemy + 1] = factions_table[i]
-		end
-	end
-	return (#rnd_enemy > 0) and rnd_enemy[math.random(#rnd_enemy)] or nil
+        empty_table(rnd_enemy)
+        for _, faction in ipairs(factions_table or {}) do -- added nil check
+                if (comm ~= faction) and is_factions_enemies(faction, comm) and is_relation_allowed(faction , comm) then
+                        rnd_enemy[#rnd_enemy + 1] = faction
+                end
+        end
+        return (#rnd_enemy > 0) and rnd_enemy[math.random(#rnd_enemy)] or nil
 end
 
 local rnd_natural = {}
 function get_random_natural_faction(comm)
-	empty_table(rnd_natural)
-	for i = 1, #factions_table do
-		if (comm ~= factions_table[i]) and (not is_factions_enemies(factions_table[i], comm)) and is_relation_allowed(factions_table[i] , comm) then
-			rnd_natural[#rnd_natural + 1] = factions_table[i]
-		end
-	end
-	return (#rnd_natural > 0) and rnd_natural[math.random(#rnd_natural)] or nil
+        empty_table(rnd_natural)
+        for _, faction in ipairs(factions_table or {}) do -- added nil check
+                if (comm ~= faction) and (not is_factions_enemies(faction, comm)) and is_relation_allowed(faction , comm) then
+                        rnd_natural[#rnd_natural + 1] = faction
+                end
+        end
+        return (#rnd_natural > 0) and rnd_natural[math.random(#rnd_natural)] or nil
 end
 
 
@@ -559,10 +558,9 @@
 	if (USE_MARSHAL) then
 		if 	(alife_storage_manager.get_state().new_game_relations) then
 			-- Restore relations for each faction:
-			for i = 1, #factions_table do
-				for j = (i + 1), #factions_table do
-					local faction_1 = factions_table[i]
-					local faction_2 = factions_table[j]
+                        for index_i, faction_1 in ipairs(factions_table or {}) do -- added nil check
+                                for j = (index_i + 1), #factions_table do
+                                        local faction_2 = factions_table[j]
 					
 					load_relation ( faction_1 , faction_2 ) -- load and set overall faction relations:
 					load_relation ( "actor_" .. faction_1 , faction_2 ) -- load and set actor faction 1 / faction 2 relations:
@@ -924,12 +922,12 @@
 	if (not rank_relation) then
 		rank_relation = {}
 		
-		local rn = utils_obj.get_rank_list()
-		for i=1,#rn do
-			rank_relation[rn[i]] = {}
-			local t = parse_list(ini_sys,"rank_relations",rn[i])
-			for j,num in ipairs(t) do
-				rank_relation[rn[i]][rn[j]] = tonumber(num)
+                local rn = utils_obj.get_rank_list()
+                for _, rank in ipairs(rn or {}) do -- added nil check
+                        rank_relation[rank] = {}
+                        local t = parse_list(ini_sys,"rank_relations",rank)
+                        for j,num in ipairs(t) do
+                                rank_relation[rank][rn[j]] = tonumber(num)
 				--printf("-rank [%s][%s] = %s", rn[i], rn[j], tonumber(num))
 			end
 		end
@@ -946,12 +944,12 @@
 	if (not reputation_relation) then
 		reputation_relation = {}
 		
-		local rn = utils_obj.get_reputation_list()
-		for i=1,#rn do
-			reputation_relation[rn[i]] = {}
-			local t = parse_list(ini_sys,"reputation_relations",rn[i])
-			for j,num in ipairs(t) do
-				reputation_relation[rn[i]][rn[j]] = tonumber(num)
+                local rn = utils_obj.get_reputation_list()
+                for _, rep in ipairs(rn or {}) do -- added nil check
+                        reputation_relation[rep] = {}
+                        local t = parse_list(ini_sys,"reputation_relations",rep)
+                        for j,num in ipairs(t) do
+                                reputation_relation[rep][rn[j]] = tonumber(num)
 				--printf("-rep [%s][%s] = %s", rn[i], rn[j], tonumber(num))
 			end
 		end
```
</details>
| sim_offline_combat.script | 24 | 19 | keep |

<details><summary>Diff for sim_offline_combat.script</summary>
```diff
--- runtime files/gamedata/scripts/sim_offline_combat.script
+++ gamma_walo/gamedata/scripts/sim_offline_combat.script
@@ -10,7 +10,8 @@
 	2021/02/04 - Vintar - removed Hybrid mode, re-enabled slider support for offline combat distance, changed ignore_list handling
 	2021/02/13 - Vintar - fixed warfare exclusions and missing monster factions related to call of pripyat allspawn mutants
 	2022/05/01 - Vintar - remove exemptions for `task_squads` and `task_giver_squads` to eliminate exempt squad buildup over time
-	2022/05/21 - Vintar - remove squad cap limitation, which wasn't correctly implemented for Warfare anyway
+        2022/05/21 - Vintar - remove squad cap limitation, which wasn't correctly implemented for Warfare anyway
+        2025/07/24 - d0pe - hardened offline combat loops
 
 	Offline Combat Simulator
 	Full simulation: When 2 enemy squads get close to each other, a battle will be simulated
@@ -104,24 +105,28 @@
 -------------------------------
 local function smart_terrain_on_update(smart)
 
-	empty_table(tbl_smart)
-	
-	for id,_ in pairs(SIMBOARD.smarts[smart.id].squads) do
-		tbl_smart[#tbl_smart+1] = id
-	end
+        empty_table(tbl_smart)
+
+        local smart_data = SIMBOARD.smarts[smart.id]
+        if not (smart_data and smart_data.squads) then
+                return -- added nil check
+        end
+
+        for id,_ in pairs(smart_data.squads) do
+                tbl_smart[#tbl_smart+1] = id
+        end
 	
 	if (#tbl_smart == 0) then
 		return
 	end
 	
-	shuffle_table(tbl_smart)
-	
-	local sim = alife()
-	local lid_1
-	
-	for i,id_1 in pairs(tbl_smart) do
-		local squad_1 = sim:object(id_1)
-		local section = squad_1 and squad_1:section_name()
+        shuffle_table(tbl_smart)
+
+        local sim = alife()
+
+        for _,id_1 in ipairs(tbl_smart) do
+                local squad_1 = sim:object(id_1)
+                local section = squad_1 and squad_1:section_name()
 		
 		if squad_1 and (not squad_1.online) and SIMBOARD.squads[squad_1.id] and (squad_1:npc_count() > 0)
 		then
@@ -130,8 +135,8 @@
 				return
 			end
 	
-			lid_1 = lid_1 or game_graph():vertex(squad_1.m_game_vertex_id):level_id()
-			if lid_1 and squads_by_level[lid_1] then 
+                        local lid_1 = game_graph():vertex(squad_1.m_game_vertex_id):level_id()
+                        if lid_1 and squads_by_level[lid_1] then
 				
 --				if (not task_squads[id_1]) and (not task_giver_squads[id_1]) then
 					-- disable offline combat for ignore list when Warfare is active
@@ -150,9 +155,9 @@
 							end
 						end
 				
-						-- Otherwise, scan for squads in the same map
-						for j,id_2 in pairs(tbl_smart) do
-							in_combat = validate_enemy(sim, lid_1, squad_1, id_1, id_2, community_1)
+                                                -- Otherwise, scan for squads in the same map
+                                                for _,id_2 in ipairs(tbl_smart) do
+                                                        in_combat = validate_enemy(sim, lid_1, squad_1, id_1, id_2, community_1)
 							if in_combat then
 								if enable_debug then
 									printf("% OCS | Battle in smart [%s]", smart:name())
```
</details>
| sim_squad_scripted.script | 1 | 1 | keep |

<details><summary>Diff for sim_squad_scripted.script</summary>
```diff
--- runtime files/gamedata/scripts/sim_squad_scripted.script
+++ gamma_walo/gamedata/scripts/sim_squad_scripted.script
@@ -136,7 +136,7 @@
 	
 	local new_id = tonumber(new_target)
 	local se_target = new_id and alife_object(new_id)
-	if se_target and (obj:clsid() == clsid.online_offline_group_s or obj:clsid() == clsid.smart_terrain) then
+	if se_target and (se_target:clsid() == clsid.online_offline_group_s or se_target:clsid() == clsid.smart_terrain) then
 		return new_id
 	end
 end
```
</details>
| sim_squad_warfare.script | 2 | 1 | keep |

<details><summary>Diff for sim_squad_warfare.script</summary>
```diff
--- runtime files/gamedata/scripts/sim_squad_warfare.script
+++ gamma_walo/gamedata/scripts/sim_squad_warfare.script
@@ -6,7 +6,8 @@
 	2020/09/22 - Vintar - loners no longer see other loner squads outside of fog of war (without PDA v2 or v3)
 	2021/02/13 - Vintar - added toggle capability for loner fog of war
 	2021/02/18 - Vintar - friendly random patrol squads are now labeled
-	2021/11/09 - Vintar - added goodwill on kill functionality
+        2021/11/09 - Vintar - added goodwill on kill functionality
+        2025/07/24 - d0pe - synced with modular warfare system
 
 	This file contains mostly retired functions, but still handles some squad-level stuff 
 	such as PDA squad spots and Warfare squad registration
```
</details>
| smart_terrain_warfare.script | 5 | 4 | keep |

<details><summary>Diff for smart_terrain_warfare.script</summary>
```diff
--- runtime files/gamedata/scripts/smart_terrain_warfare.script
+++ gamma_walo/gamedata/scripts/smart_terrain_warfare.script
@@ -26,7 +26,8 @@
 	2022/03/06 - Vintar - monster spawn numbers based on level lair capacity
 	2022/04/15 - Ace - Fix for crash when dead allied defenders try to send a message after invasion force is defeated
 	2022/04/22 - Vintar - Mutants from X8 and Pripyat Underpass can no longer transition out
-	2022/04/30 - Vintar - Main base attack prevention also applies to mutants
+        2022/04/30 - Vintar - Main base attack prevention also applies to mutants
+        2025/07/24 - d0pe - added nil checks for target selection
 	
 	This file handles the majority of warfare-related script tasks, such as squad behavior,
 	targeting, smart terrain updates, ownership checks, patrol behavior, etc.
@@ -1121,9 +1122,9 @@
 	if ((pda_actor.manual_control and smart.owning_faction ~= warfare.actor_faction) or (not pda_actor.manual_control)) then
 		local targets = find_targets(smart)
 			
-		if (#targets > 0) then
-			for i=1,#targets do
-				if not (smart.target_smarts[targets[i][2]]) then
+                if (#targets > 0) then
+                        for _, target in ipairs(targets or {}) do -- added nil check
+                                if not (smart.target_smarts[target[2]]) then
 					local target_delta = target_smart_count - invading_faction_props.min_smart_targets_per_base
 					if (target_delta < 0) then
 						local other = alife_object(targets[i][2])
```
</details>
| tasks_assault.script | 62 | 46 | keep |

<details><summary>Diff for tasks_assault.script</summary>
```diff
--- runtime files/gamedata/scripts/tasks_assault.script
+++ gamma_walo/gamedata/scripts/tasks_assault.script
@@ -1,6 +1,10 @@
 --[[
 - Remade by Tronex
 - 2019/4/23
+
+	Edit Log:
+	2020/5/29 - Vintar - added Warfare compatibility
+	
 - Global functions for assault tasks, with support for pre-info before accepting
 	
 	Parameters for precondition
@@ -71,6 +75,7 @@
 
 
 ---------------------------< Utility >---------------------------
+-- Verify squad section name is not a low-tier mutant used for tasks
 function is_legit_mutant_squad(squad)
 	local section = squad and squad:section_name()
 	return squad and (not sfind(section,"tushkano")) and (not sfind(section,"rat")) and true or false
@@ -97,15 +102,17 @@
 	for sq_id,_ in pairs(smrt.squads) do
 		--printf("# %s | found squad (%s) in smart: %s", task_id, sq_id, smrt_name)
 		
+		-- if warfare, override checks on stay time, default squad stuff
 		-- if smart's squad is on its level + they are targeting it
 		local squad = alife_object(sq_id)
 		if squad and simulation_objects.is_on_the_same_level(squad, smart)
 		and squad.current_target_id and (squad.current_target_id == smrt_id)
 		and (squad.current_action == 1)
-		and (squad:npc_count() >= squad_def.num)
+		and (((squad:npc_count() >= squad_def.num)
 		and squad.stay_time
 		and ((not squad_def.stay_time) or (squad_def.stay_time and (game.get_game_time():diffSec(squad.stay_time) <= tonumber(squad_def.stay_time))))
-		and (squad_def.scripted or (not squad:get_script_target()))
+		and (squad_def.scripted or (not squad:get_script_target())))
+		or (_G.WARFARE and not squad:get_script_target()))
 		then
 			--printf("# %s | smart (%s) [%s] w/ squad (%s) [%s] = Checking", task_id, smrt_id, smrt_name, sq_id, squad.player_id)
 			
@@ -133,15 +140,14 @@
 		and (squad.current_target_id and squad.current_target_id == smart.id and squad.current_action == 1) 
 		then
 			--printf("- %s | squad (%s) [%s] is targeting smart (%s)", task_id, squad.id, squad.player_id, smart.id)
-			for i = 1, #cache_assault_func[task_id] do
-				local fac = cache_assault_func[task_id][i]
+                        for _, fac in ipairs(cache_assault_func[task_id] or {}) do -- added nil check
 				if (is_legit_mutant_squad(squad) and squad.player_id == fac) then
 					-- updating data
 					var.squad_id = squad.id
 					save_var( db.actor, task_id, var )
 					
 					-- reset gametime so they don't leave
-					squad.stay_time = game.get_game_time() 
+                                        squad.stay_time = game.get_game_time()
 					squad.force_online = true
 					--printf("- %s | squad (%s) [%s] is saved", task_id, squad.id, squad.player_id)
 					return true
@@ -274,21 +280,22 @@
 		cache_assault_func[task_id] = {}
 		local params = parse_list(task_manager.task_ini,task_id,"status_functor_params")
 		if var.is_enemy then
-			for i=1,#params do
-				if is_squad_monster[params[i]] or factions_list[params[i]] then
-					cache_assault_func[task_id][i] = params[i]
-					printf("/ %s | Faction [%s] is re-added to cache_assault_func table", task_id, params[i])
-				end
-			end
+                        for _, param in ipairs(params or {}) do -- added nil check
+                                if is_squad_monster[param] or factions_list[param] then
+                                        local idx = #cache_assault_func[task_id] + 1
+                                        cache_assault_func[task_id][idx] = param
+                                        printf("/ %s | Faction [%s] is re-added to cache_assault_func table", task_id, param)
+                                end
+                        end
 		elseif (not is_squad_monster[params[1]]) then
 			for fac,_ in pairs(factions_list) do
 				local cnt = 0
 				local is_enemy_to_actor = true --game_relations.is_factions_enemies(fac, get_actor_true_community())
-				for i=1,#params do
-					if (fac ~= params[i]) and is_enemy_to_actor and game_relations.is_factions_enemies(fac, params[i]) then
-						cnt = cnt + 1
-					end
-				end
+                                for _, param in ipairs(params or {}) do -- added nil check
+                                        if (fac ~= param) and is_enemy_to_actor and game_relations.is_factions_enemies(fac, param) then
+                                                cnt = cnt + 1
+                                        end
+                                end
 				if (cnt == #params) then
 					local idx = #cache_assault_func[task_id] + 1
 					cache_assault_func[task_id][idx] = fac
@@ -298,6 +305,10 @@
 		end
 		if (#cache_assault_func[task_id] == 0) then
 			printe("! %s | no enemy factions found",task_id)
+--[[
+        SERIOUS NO NORTH TASKS BEFORE BS
+        AND THE NORTHERN JOB
+--]]
 			return "fail"
 		end
 	end
@@ -393,23 +404,23 @@
 	
 	--// Collect enemy factions
 	if def.is_enemy then -- if faction parameters are enemies
-		for i=1,#p_status do
-			if is_squad_monster[p_status[i]] or factions_list[p_status[i]] then
-				--printf("/ %s | Faction [%s] is added to enemy_faction_list table", task_id, p_status[i])
-				enemy_faction_list[p_status[i]] = true
-			end
-		end
+                for _, status in ipairs(p_status or {}) do -- added nil check
+                        if is_squad_monster[status] or factions_list[status] then
+                                --printf("/ %s | Faction [%s] is added to enemy_faction_list table", task_id, status)
+                                enemy_faction_list[status] = true
+                        end
+                end
 		
 	elseif (not is_squad_monster[p_status[1]]) then -- if faction parameters are matutal factions
 		for fac,_ in pairs(factions_list) do
 			local cnt = 0
 			local is_enemy_to_actor = true --game_relations.is_factions_enemies(fac, get_actor_true_community())
-			for i=1,#p_status do
-				if (fac ~= p_status[i]) and is_enemy_to_actor and game_relations.is_factions_enemies(fac, p_status[i]) then
-					cnt = cnt + 1
-				end
-			end
-			if (cnt == #p_status) then
+                for _, status in ipairs(p_status or {}) do -- added nil check
+                                if (fac ~= status) and is_enemy_to_actor and game_relations.is_factions_enemies(fac, status) then
+                                        cnt = cnt + 1
+                                end
+                        end
+                        if (cnt == #p_status) then
 				enemy_faction_list[fac] = true
 				--printf("/ %s | Faction [%s] is added to enemy_faction_list table", task_id, fac)
 			end
@@ -418,30 +429,30 @@
 	
 	if is_empty(enemy_faction_list) then
 		printe("! %s | no enemy factions found", task_id)
+--[[
+        SERIOUS NO NORTH TASKS BEFORE BS
+        AND THE NORTHERN JOB
+--]]
+        local additionalBlacklist = {}
+        local mcm_scanMode = blacklist_helper.GetMcmDropdownValue()
+        local northernMaps = blacklist_helper.GetNorthernMaps()
+
+        if mcm_scanMode and mcm_scanMode > 0  then
+                def.scan = mcm_scanMode
+        end
+
+        if blacklist_helper.ShouldBlacklistNorth() then
+                additionalBlacklist = northernMaps
+        elseif northernMaps[level.name()] then -- Player is in the Northern region and rightfully so
+                additionalBlacklist = blacklist_helper.GetSouthernMaps()
+        end
+--[[
+        SERIOUS NO NORTH TASKS BEFORE BS
+        AND THE NORTHERN JOB
+--]]
 		return false
 	end
 	
---[[
-	SERIOUS NO NORTH TASKS BEFORE BS
-	AND THE NORTHERN JOB
---]]
-	local additionalBlacklist = {}
-	local mcm_scanMode = blacklist_helper.GetMcmDropdownValue()
-	local northernMaps = blacklist_helper.GetNorthernMaps()
-
-	if mcm_scanMode and mcm_scanMode > 0  then
-		def.scan = mcm_scanMode
-	end
-
-	if blacklist_helper.ShouldBlacklistNorth() then
-		additionalBlacklist = northernMaps
-	elseif northernMaps[level.name()] then -- Player is in the Northern region and rightfully so
-		additionalBlacklist = blacklist_helper.GetSouthernMaps()
-	end
---[[
-	SERIOUS NO NORTH TASKS BEFORE BS
-	AND THE NORTHERN JOB
---]]
 	
 	--// Search all smarts
 	local targets = {} -- target[squad_id] = smart_id
@@ -459,7 +470,8 @@
 			
 				-- if smart is not in blacklisted location
 				local smart_level = sim:level_name(gg:vertex(v.m_game_vertex_id):level_id())
-				if (not blacklisted_maps[smart_level] and not additionalBlacklist[smart_level]) then
+				if (not blacklisted_maps[smart_level]) then
+				
 					-- if smart location is proper to the parameter
 					local is_online = v.online
 					local is_nearby = sfind(simulation_objects.config:r_value(actor_level, "target_maps", 0, ""), smart_level)
```
</details>
| tasks_smart_control.script | 1 | 0 | keep |

<details><summary>Diff for tasks_smart_control.script</summary>
```diff
--- runtime files/gamedata/scripts/tasks_smart_control.script
+++ gamma_walo/gamedata/scripts/tasks_smart_control.script
@@ -52,6 +52,7 @@
 }
 
 ---------------------------< Utility >---------------------------
+-- Check squad section name is valid for smart control tasks
 function is_legit_mutant_squad(squad)
 	local section = squad and squad:section_name()
 	return squad and (not sfind(section,"tushkano")) and (not sfind(section,"rat")) and true or false
```
</details>
| ui_mm_faction_select.script | 0 | 0 | keep |

<details><summary>Diff for ui_mm_faction_select.script</summary>
```diff
```
</details>
| ui_options.script | 6 | 5 | keep |

<details><summary>Diff for ui_options.script</summary>
```diff
--- runtime files/gamedata/scripts/ui_options.script
+++ gamma_walo/gamedata/scripts/ui_options.script
@@ -26,7 +26,8 @@
 	2020/11/07 - Vintar - added resurgence chance as option
 	2021/02/13 - Vintar - added 'overflow overrides manual control' and 'extra loner fog of war' toggle, min smart targets per base
 	2021/11/09 - Vintar - added goodwill on kill options, added back "hide all smarts" option, added 'old autocapture' option
-	2022/02/26 - Vintar - added main base attack deprioritization option
+        2022/02/26 - Vintar - added main base attack deprioritization option
+        2025/07/24 - d0pe - minor formatting cleanup
 	
 --]]
 
@@ -124,7 +125,7 @@
 		{ id= "texture_lod"            ,type= "track"    ,val= 2	,cmd= "texture_lod"	                ,min= 0     ,max= 4     ,step= 1 	,no_str= true	  ,invert= true     ,vid= true	,restart= true	},
 		{ id= "geometry_lod"           ,type= "track"    ,val= 2	,cmd= "r__geometry_lod"	            ,min= 0.1   ,max= 1.5   ,step= 0.1 },
 		{ id= "mipbias"           	   ,type= "track"    ,val= 2	,cmd= "r__tf_mipbias"	            ,min= -0.5  ,max= 0.5   ,step= 0.1 	,no_str= true 	  ,invert= true },
-		{ id= "tf_aniso"               ,type= "track"    ,val= 2	,cmd= "r__tf_aniso"	                ,min= 1     ,max= 16    ,step= 4    ,vid= true	},
+                { id= "tf_aniso"               ,type= "track"    ,val= 2       ,cmd= "r__tf_aniso"                      ,min= 1     ,max= 16    ,step= 4    ,vid= true  },
 		{ id= "ssample"                ,type= "track"    ,val= 2	,cmd= "r__supersample"	            ,min= 1     ,max= 8     ,step= 1       ,vid= true      ,precondition= {for_renderer,"renderer_r1","renderer_r2a","renderer_r2","renderer_r2.5"} },
 		{ id= "ssample_list"           ,type= "list"     ,val= 0	,cmd= "r3_msaa"	                    ,content={ {"st_opt_off","st_opt_off"},{"2x","x2"},{"4x","x4"},{"8x","x8"} }	    ,vid= true          ,precondition= {for_renderer,"renderer_r3","renderer_r4"} , no_str= true  },
 		{ id= "smaa"           		   ,type= "list"     ,val= 0	,cmd= "r2_smaa"	                    ,content={ {"off","st_opt_off"},{"low","st_opt_low"},{"medium","st_opt_medium"},{"high","st_opt_high"},{"ultra","st_opt_ultra"} } ,precondition= {for_renderer,"renderer_r2a","renderer_r2","renderer_r2.5","renderer_r3","renderer_r4"}, no_str= true  },
@@ -429,9 +430,9 @@
 	{ id= "general"      	,sh=true ,gr={
 		{ id= "slide_alife"		,type= "slide"	  ,link= "ui_options_slider_alife"	 ,text= "ui_mm_title_alife"		,size= {512,50}		},
 
-		{ id= "alife_mutant_pop"  		,type= "list"    ,val= 2  ,def= 0.75 	 ,content= {{0.25} , {0.5} , {0.75} , {1}}		,no_str= true  },
-		{ id= "alife_stalker_pop"  		,type= "list"    ,val= 2  ,def= 0.5 	 ,content= {{0.25} , {0.5} , {0.75} , {1}}		,no_str= true  },
-		{ id= "offline_combat"  		,type= "list"    ,val= 0  ,def= "full" 	 ,content= {{"full","full"} , {"on_smarts_only","on_smarts_only"}, {"off","off"}} },
+                { id= "alife_mutant_pop"                ,type= "list"    ,val= 2  ,def= 0.75     ,content= {{0.25} , {0.5} , {0.75} , {1}}              ,no_str= true  },
+                { id= "alife_stalker_pop"               ,type= "list"    ,val= 2  ,def= 0.5      ,content= {{0.25} , {0.5} , {0.75} , {1}}              ,no_str= true  },
+		{ id= "offline_combat"  		,type= "list"    ,val= 0  ,def= "full" 	 ,content= {{"full","full"}, {"on_smarts_only","on_smarts_only"}, {"off","off"}} },
 		{ id= "excl_dist"  				,type= "list"    ,val= 2  ,def= 75 	 	 ,content= {{0} , {25} , {50} , {75} , {100}}	,no_str= true  },
 		{ id= "dynamic_anomalies"        ,type= "check"    ,val= 1	,def= true	 },
 		{ id= "dynamic_relations"        ,type= "check"    ,val= 1	,def= false	 },
```
</details>
| ui_pda_warfare_tab.script | 2 | 1 | keep |

<details><summary>Diff for ui_pda_warfare_tab.script</summary>
```diff
--- runtime files/gamedata/scripts/ui_pda_warfare_tab.script
+++ gamma_walo/gamedata/scripts/ui_pda_warfare_tab.script
@@ -3,7 +3,8 @@
 =======================================================================================
 	Original creator: Tronex
 	Edit log: 
-	2020/05/24 - Vintar
+        2020/05/24 - Vintar
+        2025/07/24 - d0pe - clarified tab overview
 
 	New PDA tab for Warfare mode: faction war
 	This file converts the 'contacts' tab into a faction ranking info tab. Faction squad
```
</details>
| warfare.script | 17 | 1 | keep |

<details><summary>Diff for warfare.script</summary>
```diff
--- runtime files/gamedata/scripts/warfare.script
+++ gamma_walo/gamedata/scripts/warfare.script
@@ -7,13 +7,27 @@
 	2020/10/22 - Vintar - fixed vanilla bug where random patrols were unmarked as random patrols upon game save/load
 	2021/02/16 - Vintar - allowed loner random patrols to be unmarked on game save, so that process_loners() can handle them, saved calculated distances between smart terrains
 	2021/02/22 - Vintar - added initial mutant spawns to non-random start. Random start mutants now spawn on lairs. Under attack status saved
-	2021/03/19 - Vintar - fix for lower population factor initial spawns
+        2021/03/19 - Vintar - fix for lower population factor initial spawns
+        2025/07/24 - d0pe - added verbose logger and helper utilities
 
 	This file deals with warfare's essential data, such as squad registration with warfare,
 	and saving/loading important parameters like respawn timers, squad targets, faction info
 =======================================================================================
 
 --]]
+
+-- Enable verbose debug tracing when requested
+if _G.verbose_logs == 1 then
+    -- Load logger from the same directory as this script so it works both
+    -- when installed under gamedata/ and when running from the repo.
+    local dir = debug.getinfo(1, "S").source
+    dir = dir and dir:gsub("@", ""):match("^(.*[\\/])") or ""
+    local path = dir .. "verbose_logger.script"
+    local ok, err = pcall(dofile, path)
+    if not ok then
+        printf("[VERBOSE] Failed to load logger: %s", tostring(err))
+    end
+end
 
 --_G.DEACTIVATE_SIM_ON_NON_LINKED_LEVELS = false
 --_G.ProcessEventQueueState = function() return end
@@ -478,6 +492,7 @@
 
 FACTION_TERRITORY_RADIUS = 100
 
+-- Fisher-Yates shuffle used for randomizing squad lists
 function shuffleTable( t )
     local rand = math.random 
     local iterations = #t
@@ -978,6 +993,7 @@
 	end) return tbl
 end
 
+-- 2D squared distance ignoring Y axis used by AI distance checks
 function distance_to_xz_sqr(a, b)
 	return math.pow(b.x - a.x, 2) + math.pow(b.z - a.z, 2)
 end
```
</details>
| warfare_factions.script | 5 | 3 | keep |

<details><summary>Diff for warfare_factions.script</summary>
```diff
--- runtime files/gamedata/scripts/warfare_factions.script
+++ gamma_walo/gamedata/scripts/warfare_factions.script
@@ -6,7 +6,8 @@
 	2020/11/07 - Vintar - Resurgence chance added to resurgence calculation
 	2021/02/19 - Vintar - stronger resurgence attempts, now uses fetch_smart_distance(), debug messages
 	2021/03/27 - Vintar - loners exempt from random patrol targeting. Random patrols no longer spawn too close to actor.
-	2021/11/22 - Vintar - slight change to resurgence base count
+        2021/11/22 - Vintar - slight change to resurgence base count
+        2025/07/24 - d0pe - added nil checks for faction lists
 
 	This file handles faction-level warfare stuff like random patrols, resurgences, etc.
 =======================================================================================
@@ -54,8 +55,8 @@
 faction_information = {}
 faction_timers = {}
 
-for i=1,#factions do
-	factions_p[factions[i]] = true
+for _, fac in ipairs(factions or {}) do -- added nil check
+        factions_p[fac] = true
 end
 
 --[[
@@ -82,6 +83,7 @@
 	end
 end
 
+-- Update timers and patrol logic for a single faction
 function update_faction(faction)
 	if (not faction or faction == "none") then
 		return
```
</details>
| warfare_monkeypatches.script | 0 | 0 | keep |

<details><summary>Diff for warfare_monkeypatches.script</summary>
```diff
```
</details>
| warfare_options.script | 3 | 1 | keep |

<details><summary>Diff for warfare_options.script</summary>
```diff
--- runtime files/gamedata/scripts/warfare_options.script
+++ gamma_walo/gamedata/scripts/warfare_options.script
@@ -8,7 +8,8 @@
 	2021/02/13 - Vintar - reads in overflow override, loner fog of war
 	2021/02/16 - Vintar - added min smart targets per base
 	2021/11/09 - Vintar - added goodwill on kill options, added back "hide all smarts" option, added 'old autocapture' option
-	2022/02/26 - Vintar - added main base attack deprioritization option
+        2022/02/26 - Vintar - added main base attack deprioritization option
+        2025/07/24 - d0pe - added random start helper
 
 	This file reads the main menu options for warfare so that script functions can access them.
 =======================================================================================
@@ -228,6 +229,7 @@
 	sim_squad_scripted.sim_squad_scripted.specific_update = function(self, script_target_id) end
 end
 
+-- Pick a random start location from faction lists
 function get_random_start_location()
 	warfare.printd(0, "get_random_start_location")
 
```
</details>
| xr_logic.script | 1 | 0 | keep |

<details><summary>Diff for xr_logic.script</summary>
```diff
--- runtime files/gamedata/scripts/xr_logic.script
+++ gamma_walo/gamedata/scripts/xr_logic.script
@@ -36,6 +36,7 @@
 	end
 end
 
+-- Spawn configured items into an NPCs inventory during initialization
 function spawn_items(npc, st)
 	--utils_data.debug_write("spawner:spawn_items")
 	if not (st.ini and st.section_logic) then 
```
</details>
| base_node_logic.script | new file | - | new module |
| daily_sim_engine.script | new file | - | new module |
| diplomacy_core.script | new file | - | new module |
| diplomacy_system.script | new file | - | new module |
| faction_ai_logic.script | new file | - | new module |
| faction_philosophy.script | new file | - | new module |
| faction_state.script | new file | - | new module |
| hq_coordinator.script | new file | - | new module |
| legendary_squad_system.script | new file | - | new module |
| meta_overlord.script | new file | - | new module |
| monolith_ai.script | new file | - | new module |
| node_system.script | new file | - | new module |
| pda_context_menu.script | new file | - | new module |
| placeable_system.script | new file | - | new module |
| resource_pool.script | new file | - | new module |
| resource_system.script | new file | - | new module |
| squad_gear_scaler.script | new file | - | new module |
| squad_spawn_system.script | new file | - | new module |
| squad_transport.script | new file | - | new module |
| ui_pda_diplomacy.script | new file | - | new module |
| verbose_logger.script | new file | - | new module |