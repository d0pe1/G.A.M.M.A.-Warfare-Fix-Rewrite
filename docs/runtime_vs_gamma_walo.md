# Runtime vs Gamma_Walo Diff

This report compares scripts in `runtime files/gamedata/scripts` against their counterparts in `gamma_walo/gamedata/scripts`.

| File | Added | Removed | Verdict |
| ---- | ----- | ------- | ------- |
| dialogs.script | 4 | 1 | keep |

<details><summary>Diff for dialogs.script</summary>
```diff
diff --git a/runtime files/gamedata/scripts/dialogs.script b/gamma_walo/gamedata/scripts/dialogs.script
index 2b7f371..df30166 100644
--- a/runtime files/gamedata/scripts/dialogs.script	
+++ b/gamma_walo/gamedata/scripts/dialogs.script
@@ -34,0 +35 @@ end
+-- Helper used in dialog preconditions to hide options when Warfare is active
@@ -45,0 +47 @@ local mark_task_per_npc = {}
+-- Returns the maximum simultaneous tasks an NPC can offer based on options
@@ -1796 +1798 @@ end
---' ������������� ��������
+--'  
@@ -2470 +2472 @@ end
-local important_docs = {
+local important_docs = {
```
</details>
| faction_expansions.script | 4 | 1 | keep |

<details><summary>Diff for faction_expansions.script</summary>
```diff
diff --git a/runtime files/gamedata/scripts/faction_expansions.script b/gamma_walo/gamedata/scripts/faction_expansions.script
index b9e790e..63262e7 100644
--- a/runtime files/gamedata/scripts/faction_expansions.script	
+++ b/gamma_walo/gamedata/scripts/faction_expansions.script
@@ -10 +10,2 @@
-	2021/03/02 - Vintar - removed black smoke poltergeist
+        2021/03/02 - Vintar - removed black smoke poltergeist
+        2025/07/24 - d0pe - documented spawn chance formulas
@@ -134,0 +136 @@ local random_zombies = {
+-- Chance percentage for an advanced squad spawn given owned resources
@@ -139,0 +142 @@ end
+-- Chance percentage for a veteran squad spawn given owned resources
```
</details>
| game_fast_travel.script | 0 | 0 | identical |
| game_relations.script | 105 | 107 | keep |

<details><summary>Diff for game_relations.script</summary>
```diff
diff --git a/runtime files/gamedata/scripts/game_relations.script b/gamma_walo/gamedata/scripts/game_relations.script
index 49739ae..652f76b 100644
--- a/runtime files/gamedata/scripts/game_relations.script	
+++ b/gamma_walo/gamedata/scripts/game_relations.script
@@ -27,16 +26,0 @@
-function safe_ini_r_float(ini, section, key, fallback)
-	if ini and ini:section_exist(section) and ini:line_exist(section, key) then
-		return ini:r_float(section, key)
-	else
-		return fallback
-	end
-end
-
-function safe_ini_r_s32(ini, section, key, fallback)
-	if ini and ini:section_exist(section) and ini:line_exist(section, key) then
-		return ini:r_s32(section, key)
-	else
-		return fallback
-	end
-end
-
@@ -44,0 +29,15 @@ end
+function safe_ini_r_float(ini, section, key, fallback)
+        if ini and ini:section_exist(section) and ini:line_exist(section, key) then
+                return ini:r_float(section, key)
+        else
+                return fallback
+        end
+end
+
+function safe_ini_r_s32(ini, section, key, fallback)
+        if ini and ini:section_exist(section) and ini:line_exist(section, key) then
+                return ini:r_s32(section, key)
+        else
+                return fallback
+        end
+end
@@ -46,12 +45,12 @@ end
-local ini_r
-if system_ini():section_exist("plugins\dynamic_faction_relations") then
-	ini_r = ini_file("plugins\dynamic_faction_relations.ltx")
-else
-	printf("[game_relations.script] WARNING: Missing dynamic_faction_relations.ltx")
-end
-local ini_g
-if system_ini():section_exist("creatures\game_relations") then
-	ini_g = ini_file("creatures\game_relations.ltx")
-else
-	printf("[game_relations.script] WARNING: Missing game_relations.ltx")
-end
+local ini_r
+if system_ini():section_exist("plugins\dynamic_faction_relations") then
+        ini_r = ini_file("plugins\dynamic_faction_relations.ltx")
+else
+        printf("[game_relations.script] WARNING: Missing dynamic_faction_relations.ltx")
+end
+local ini_g
+if system_ini():section_exist("creatures\game_relations") then
+        ini_g = ini_file("creatures\game_relations.ltx")
+else
+        printf("[game_relations.script] WARNING: Missing game_relations.ltx")
+end
@@ -156,7 +155,7 @@ function is_faction_pair_unaffected(fac1, fac2)
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
@@ -191,7 +190,7 @@ function is_relation_allowed (faction_1 , faction_2) -- Check if the relation be
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
@@ -310,11 +309,11 @@ function reset_all_relations()
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
@@ -358,12 +357,12 @@ function calculate_relation_change( victim_tbl, killer_tbl)
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
@@ -378,3 +377,3 @@ function calculate_relation_change( victim_tbl, killer_tbl)
-		for i = 1, #factions_table do
-			if ( factions_table[i] ~= killer_faction ) then
-				if ( is_factions_enemies( factions_table[i], victim_faction ) ) then
+                for _, faction in ipairs(factions_table or {}) do -- added nil check
+                        if ( faction ~= killer_faction ) then
+                                if ( is_factions_enemies( faction, victim_faction ) ) then
@@ -399,2 +398,2 @@ function calculate_relation_change( victim_tbl, killer_tbl)
-						if is_relation_allowed( factions_table[i] , killer_faction ) and ( natural_num + friend_num > friend_count_limit ) then
-							change_faction_relations( factions_table[i], killer_faction, value )
+                                                if is_relation_allowed( faction , killer_faction ) and ( natural_num + friend_num > friend_count_limit ) then
+                                                        change_faction_relations( faction, killer_faction, value )
@@ -417,3 +416,3 @@ function calculate_relation_change( victim_tbl, killer_tbl)
-		for i = 1, #factions_table do
-			if ( factions_table[i] ~= killer_faction ) then
-				if ( not is_factions_enemies( factions_table[i], victim_faction ) ) then
+                for _, faction in ipairs(factions_table or {}) do -- added nil check
+                        if ( faction ~= killer_faction ) then
+                                if ( not is_factions_enemies( faction, victim_faction ) ) then
@@ -438,2 +437,2 @@ function calculate_relation_change( victim_tbl, killer_tbl)
-						if is_relation_allowed( factions_table[i] , killer_faction ) and ( enemy_num > enemy_count_limit ) then
-							change_faction_relations( factions_table[i], killer_faction, -(value) )
+                                                if is_relation_allowed( faction , killer_faction ) and ( enemy_num > enemy_count_limit ) then
+                                                        change_faction_relations( faction, killer_faction, -(value) )
@@ -457,8 +456,8 @@ local rnd_enemy = {}
-function get_random_enemy_faction(comm)
-	empty_table(rnd_enemy)
-	for i = 1, #factions_table do
-		if (comm ~= factions_table[i]) and is_factions_enemies(factions_table[i], comm) and is_relation_allowed(factions_table[i] , comm) then
-			rnd_enemy[#rnd_enemy + 1] = factions_table[i]
-		end
-	end
-	return (#rnd_enemy > 0) and rnd_enemy[math.random(#rnd_enemy)] or nil
+function get_random_enemy_faction(comm)
+        empty_table(rnd_enemy)
+        for _, faction in ipairs(factions_table or {}) do -- added nil check
+                if (comm ~= faction) and is_factions_enemies(faction, comm) and is_relation_allowed(faction , comm) then
+                        rnd_enemy[#rnd_enemy + 1] = faction
+                end
+        end
+        return (#rnd_enemy > 0) and rnd_enemy[math.random(#rnd_enemy)] or nil
@@ -468,8 +467,8 @@ local rnd_natural = {}
-function get_random_natural_faction(comm)
-	empty_table(rnd_natural)
-	for i = 1, #factions_table do
-		if (comm ~= factions_table[i]) and (not is_factions_enemies(factions_table[i], comm)) and is_relation_allowed(factions_table[i] , comm) then
-			rnd_natural[#rnd_natural + 1] = factions_table[i]
-		end
-	end
-	return (#rnd_natural > 0) and rnd_natural[math.random(#rnd_natural)] or nil
+function get_random_natural_faction(comm)
+        empty_table(rnd_natural)
+        for _, faction in ipairs(factions_table or {}) do -- added nil check
+                if (comm ~= faction) and (not is_factions_enemies(faction, comm)) and is_relation_allowed(faction , comm) then
+                        rnd_natural[#rnd_natural + 1] = faction
+                end
+        end
+        return (#rnd_natural > 0) and rnd_natural[math.random(#rnd_natural)] or nil
@@ -562,4 +561,3 @@ local function on_game_load() -- Restore faction relations
-			for i = 1, #factions_table do
-				for j = (i + 1), #factions_table do
-					local faction_1 = factions_table[i]
-					local faction_2 = factions_table[j]
+                        for index_i, faction_1 in ipairs(factions_table or {}) do -- added nil check
+                                for j = (index_i + 1), #factions_table do
+                                        local faction_2 = factions_table[j]
@@ -927,6 +925,6 @@ function get_rank_relation(obj_1, obj_2)
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
@@ -949,6 +947,6 @@ function get_reputation_relation(obj_1, obj_2)
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
```
</details>
| sim_offline_combat.script | 26 | 21 | keep |

<details><summary>Diff for sim_offline_combat.script</summary>
```diff
diff --git a/runtime files/gamedata/scripts/sim_offline_combat.script b/gamma_walo/gamedata/scripts/sim_offline_combat.script
index 781eef5..5008d0e 100644
--- a/runtime files/gamedata/scripts/sim_offline_combat.script	
+++ b/gamma_walo/gamedata/scripts/sim_offline_combat.script
@@ -13 +13,2 @@
-	2022/05/21 - Vintar - remove squad cap limitation, which wasn't correctly implemented for Warfare anyway
+        2022/05/21 - Vintar - remove squad cap limitation, which wasn't correctly implemented for Warfare anyway
+        2025/07/24 - d0pe - hardened offline combat loops
@@ -105,7 +106,12 @@ local m_class = {
-local function smart_terrain_on_update(smart)
-
-	empty_table(tbl_smart)
-	
-	for id,_ in pairs(SIMBOARD.smarts[smart.id].squads) do
-		tbl_smart[#tbl_smart+1] = id
-	end
+local function smart_terrain_on_update(smart)
+
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
@@ -117,8 +123,7 @@ local function smart_terrain_on_update(smart)
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
@@ -133,2 +138,2 @@ local function smart_terrain_on_update(smart)
-			lid_1 = lid_1 or game_graph():vertex(squad_1.m_game_vertex_id):level_id()
-			if lid_1 and squads_by_level[lid_1] then 
+                        local lid_1 = game_graph():vertex(squad_1.m_game_vertex_id):level_id()
+                        if lid_1 and squads_by_level[lid_1] then
@@ -153,3 +158,3 @@ local function smart_terrain_on_update(smart)
-						-- Otherwise, scan for squads in the same map
-						for j,id_2 in pairs(tbl_smart) do
-							in_combat = validate_enemy(sim, lid_1, squad_1, id_1, id_2, community_1)
+                                                -- Otherwise, scan for squads in the same map
+                                                for _,id_2 in ipairs(tbl_smart) do
+                                                        in_combat = validate_enemy(sim, lid_1, squad_1, id_1, id_2, community_1)
```
</details>
| sim_squad_scripted.script | 1 | 1 | keep |

<details><summary>Diff for sim_squad_scripted.script</summary>
```diff
diff --git a/runtime files/gamedata/scripts/sim_squad_scripted.script b/gamma_walo/gamedata/scripts/sim_squad_scripted.script
index 312d56f..5014d0b 100644
--- a/runtime files/gamedata/scripts/sim_squad_scripted.script	
+++ b/gamma_walo/gamedata/scripts/sim_squad_scripted.script
@@ -139 +139 @@ function sim_squad_scripted:get_script_target()
-	if se_target and (obj:clsid() == clsid.online_offline_group_s or obj:clsid() == clsid.smart_terrain) then
+	if se_target and (se_target:clsid() == clsid.online_offline_group_s or se_target:clsid() == clsid.smart_terrain) then
```
</details>
| sim_squad_warfare.script | 2 | 1 | keep |

<details><summary>Diff for sim_squad_warfare.script</summary>
```diff
diff --git a/runtime files/gamedata/scripts/sim_squad_warfare.script b/gamma_walo/gamedata/scripts/sim_squad_warfare.script
index 0507932..d208c3d 100644
--- a/runtime files/gamedata/scripts/sim_squad_warfare.script	
+++ b/gamma_walo/gamedata/scripts/sim_squad_warfare.script
@@ -9 +9,2 @@
-	2021/11/09 - Vintar - added goodwill on kill functionality
+        2021/11/09 - Vintar - added goodwill on kill functionality
+        2025/07/24 - d0pe - synced with modular warfare system
```
</details>
| smart_terrain_warfare.script | 5 | 4 | keep |

<details><summary>Diff for smart_terrain_warfare.script</summary>
```diff
diff --git a/runtime files/gamedata/scripts/smart_terrain_warfare.script b/gamma_walo/gamedata/scripts/smart_terrain_warfare.script
index 1347c85..4136306 100644
--- a/runtime files/gamedata/scripts/smart_terrain_warfare.script	
+++ b/gamma_walo/gamedata/scripts/smart_terrain_warfare.script
@@ -29 +29,2 @@
-	2022/04/30 - Vintar - Main base attack prevention also applies to mutants
+        2022/04/30 - Vintar - Main base attack prevention also applies to mutants
+        2025/07/24 - d0pe - added nil checks for target selection
@@ -1124,3 +1125,3 @@ function process_targets(smart)
-		if (#targets > 0) then
-			for i=1,#targets do
-				if not (smart.target_smarts[targets[i][2]]) then
+                if (#targets > 0) then
+                        for _, target in ipairs(targets or {}) do -- added nil check
+                                if not (smart.target_smarts[target[2]]) then
```
</details>
| tasks_assault.script | 62 | 46 | keep |

<details><summary>Diff for tasks_assault.script</summary>
```diff
diff --git a/runtime files/gamedata/scripts/tasks_assault.script b/gamma_walo/gamedata/scripts/tasks_assault.script
index 318c51a..5a76954 100644
--- a/runtime files/gamedata/scripts/tasks_assault.script	
+++ b/gamma_walo/gamedata/scripts/tasks_assault.script
@@ -3,0 +4,4 @@
+
+	Edit Log:
+	2020/5/29 - Vintar - added Warfare compatibility
+	
@@ -73,0 +78 @@ local blacklisted_maps = { -- List of maps to skip in scans
+-- Verify squad section name is not a low-tier mutant used for tasks
@@ -99,0 +105 @@ function evaluate_smarts_squads(task_id, tbl, smart, squad_def, faction_def)
+		-- if warfare, override checks on stay time, default squad stuff
@@ -105 +111 @@ function evaluate_smarts_squads(task_id, tbl, smart, squad_def, faction_def)
-		and (squad:npc_count() >= squad_def.num)
+		and (((squad:npc_count() >= squad_def.num)
@@ -108 +114,2 @@ function evaluate_smarts_squads(task_id, tbl, smart, squad_def, faction_def)
-		and (squad_def.scripted or (not squad:get_script_target()))
+		and (squad_def.scripted or (not squad:get_script_target())))
+		or (_G.WARFARE and not squad:get_script_target()))
@@ -136,2 +143 @@ function evaluate_squads_smarts(task_id, var, squad, smart)
-			for i = 1, #cache_assault_func[task_id] do
-				local fac = cache_assault_func[task_id][i]
+                        for _, fac in ipairs(cache_assault_func[task_id] or {}) do -- added nil check
@@ -144 +150 @@ function evaluate_squads_smarts(task_id, var, squad, smart)
-					squad.stay_time = game.get_game_time() 
+                                        squad.stay_time = game.get_game_time()
@@ -277,6 +283,7 @@ task_status_functor.assault_task_status_functor = function (tsk,task_id)
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
@@ -287,5 +294,5 @@ task_status_functor.assault_task_status_functor = function (tsk,task_id)
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
@@ -300,0 +308,4 @@ task_status_functor.assault_task_status_functor = function (tsk,task_id)
+--[[
+        SERIOUS NO NORTH TASKS BEFORE BS
+        AND THE NORTHERN JOB
+--]]
@@ -396,6 +407,6 @@ xr_conditions.validate_assault_task = function(actor, npc, p)
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
@@ -407,6 +418,6 @@ xr_conditions.validate_assault_task = function(actor, npc, p)
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
@@ -420,0 +432,21 @@ xr_conditions.validate_assault_task = function(actor, npc, p)
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
@@ -424,21 +455,0 @@ xr_conditions.validate_assault_task = function(actor, npc, p)
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
@@ -462 +473,2 @@ xr_conditions.validate_assault_task = function(actor, npc, p)
-				if (not blacklisted_maps[smart_level] and not additionalBlacklist[smart_level]) then
+				if (not blacklisted_maps[smart_level]) then
+				
```
</details>
| tasks_smart_control.script | 1 | 0 | keep |

<details><summary>Diff for tasks_smart_control.script</summary>
```diff
diff --git a/runtime files/gamedata/scripts/tasks_smart_control.script b/gamma_walo/gamedata/scripts/tasks_smart_control.script
index d1d48e1..00a01ed 100644
--- a/runtime files/gamedata/scripts/tasks_smart_control.script	
+++ b/gamma_walo/gamedata/scripts/tasks_smart_control.script
@@ -54,0 +55 @@ local factions_list = { -- List of allowed factions
+-- Check squad section name is valid for smart control tasks
```
</details>
| ui_mm_faction_select.script | 3 | 0 | keep |

<details><summary>Diff for ui_mm_faction_select.script</summary>
```diff
diff --git a/runtime files/gamedata/scripts/ui_mm_faction_select.script b/gamma_walo/gamedata/scripts/ui_mm_faction_select.script
index cf266a0..ef28129 100644
--- a/runtime files/gamedata/scripts/ui_mm_faction_select.script	
+++ b/gamma_walo/gamedata/scripts/ui_mm_faction_select.script
@@ -1568 +1568 @@ function UINewGame:UpdateDescr()
-				str_stats = str_stats .. "%c[0,150,150,150] %c[0,50,175,50]" .. game.translate_string("st_faction_" .. k) .. "\\n"
+				str_stats = str_stats .. "%c[0,150,150,150] %c[0,50,175,50]" .. game.translate_string("st_faction_" .. k) .. "\\n"
@@ -1570 +1570 @@ function UINewGame:UpdateDescr()
-				str_stats = str_stats .. "%c[0,150,150,150] %c[0,175,50,50]" .. game.translate_string("st_faction_" .. k) .. "\\n"
+				str_stats = str_stats .. "%c[0,150,150,150] %c[0,175,50,50]" .. game.translate_string("st_faction_" .. k) .. "\\n"
@@ -1572 +1572 @@ function UINewGame:UpdateDescr()
-				str_stats = str_stats .. "%c[0,150,150,150] %c[0,175,175,50]" .. game.translate_string("st_faction_" .. k) .. "\\n"
+				str_stats = str_stats .. "%c[0,150,150,150] %c[0,175,175,50]" .. game.translate_string("st_faction_" .. k) .. "\\n"
```
</details>
| ui_options.script | 6 | 5 | keep |

<details><summary>Diff for ui_options.script</summary>
```diff
diff --git a/runtime files/gamedata/scripts/ui_options.script b/gamma_walo/gamedata/scripts/ui_options.script
index 8b78546..3588be3 100644
--- a/runtime files/gamedata/scripts/ui_options.script	
+++ b/gamma_walo/gamedata/scripts/ui_options.script
@@ -29 +29,2 @@
-	2022/02/26 - Vintar - added main base attack deprioritization option
+        2022/02/26 - Vintar - added main base attack deprioritization option
+        2025/07/24 - d0pe - minor formatting cleanup
@@ -127 +128 @@ options = {
-		{ id= "tf_aniso"               ,type= "track"    ,val= 2	,cmd= "r__tf_aniso"	                ,min= 1     ,max= 16    ,step= 4    ,vid= true	},
+                { id= "tf_aniso"               ,type= "track"    ,val= 2       ,cmd= "r__tf_aniso"                      ,min= 1     ,max= 16    ,step= 4    ,vid= true  },
@@ -432,3 +433,3 @@ options = {
-		{ id= "alife_mutant_pop"  		,type= "list"    ,val= 2  ,def= 0.75 	 ,content= {{0.25} , {0.5} , {0.75} , {1}}		,no_str= true  },
-		{ id= "alife_stalker_pop"  		,type= "list"    ,val= 2  ,def= 0.5 	 ,content= {{0.25} , {0.5} , {0.75} , {1}}		,no_str= true  },
-		{ id= "offline_combat"  		,type= "list"    ,val= 0  ,def= "full" 	 ,content= {{"full","full"} , {"on_smarts_only","on_smarts_only"}, {"off","off"}} },
+                { id= "alife_mutant_pop"                ,type= "list"    ,val= 2  ,def= 0.75     ,content= {{0.25} , {0.5} , {0.75} , {1}}              ,no_str= true  },
+                { id= "alife_stalker_pop"               ,type= "list"    ,val= 2  ,def= 0.5      ,content= {{0.25} , {0.5} , {0.75} , {1}}              ,no_str= true  },
+		{ id= "offline_combat"  		,type= "list"    ,val= 0  ,def= "full" 	 ,content= {{"full","full"}, {"on_smarts_only","on_smarts_only"}, {"off","off"}} },
```
</details>
| ui_pda_warfare_tab.script | 2 | 1 | keep |

<details><summary>Diff for ui_pda_warfare_tab.script</summary>
```diff
diff --git a/runtime files/gamedata/scripts/ui_pda_warfare_tab.script b/gamma_walo/gamedata/scripts/ui_pda_warfare_tab.script
index 97bd70a..af507c5 100644
--- a/runtime files/gamedata/scripts/ui_pda_warfare_tab.script	
+++ b/gamma_walo/gamedata/scripts/ui_pda_warfare_tab.script
@@ -6 +6,2 @@
-	2020/05/24 - Vintar
+        2020/05/24 - Vintar
+        2025/07/24 - d0pe - clarified tab overview
```
</details>
| warfare.script | 18 | 1 | keep |

<details><summary>Diff for warfare.script</summary>
```diff
diff --git a/runtime files/gamedata/scripts/warfare.script b/gamma_walo/gamedata/scripts/warfare.script
index 6ea4ff4..8969a81 100644
--- a/runtime files/gamedata/scripts/warfare.script	
+++ b/gamma_walo/gamedata/scripts/warfare.script
@@ -10 +10,2 @@
-	2021/03/19 - Vintar - fix for lower population factor initial spawns
+        2021/03/19 - Vintar - fix for lower population factor initial spawns
+        2025/07/24 - d0pe - added verbose logger and helper utilities
@@ -16 +17,14 @@
---]]
+--]]
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
@@ -480,0 +495 @@ FACTION_TERRITORY_RADIUS = 100
+-- Fisher-Yates shuffle used for randomizing squad lists
@@ -980,0 +996 @@ end
+-- 2D squared distance ignoring Y axis used by AI distance checks
```
</details>
| warfare_factions.script | 6 | 4 | keep |

<details><summary>Diff for warfare_factions.script</summary>
```diff
diff --git a/runtime files/gamedata/scripts/warfare_factions.script b/gamma_walo/gamedata/scripts/warfare_factions.script
index 94d4737..821e1c2 100644
--- a/runtime files/gamedata/scripts/warfare_factions.script	
+++ b/gamma_walo/gamedata/scripts/warfare_factions.script
@@ -9 +9,2 @@
-	2021/11/22 - Vintar - slight change to resurgence base count
+        2021/11/22 - Vintar - slight change to resurgence base count
+        2025/07/24 - d0pe - added nil checks for faction lists
@@ -57,3 +58,3 @@ faction_timers = {}
-for i=1,#factions do
-	factions_p[factions[i]] = true
-end
+for _, fac in ipairs(factions or {}) do -- added nil check
+        factions_p[fac] = true
+end
@@ -84,0 +86 @@ end
+-- Update timers and patrol logic for a single faction
```
</details>
| warfare_monkeypatches.script | 0 | 0 | identical |
| warfare_options.script | 3 | 1 | keep |

<details><summary>Diff for warfare_options.script</summary>
```diff
diff --git a/runtime files/gamedata/scripts/warfare_options.script b/gamma_walo/gamedata/scripts/warfare_options.script
index 9f49ffa..8dc93e7 100644
--- a/runtime files/gamedata/scripts/warfare_options.script	
+++ b/gamma_walo/gamedata/scripts/warfare_options.script
@@ -11 +11,2 @@
-	2022/02/26 - Vintar - added main base attack deprioritization option
+        2022/02/26 - Vintar - added main base attack deprioritization option
+        2025/07/24 - d0pe - added random start helper
@@ -230,0 +232 @@ end
+-- Pick a random start location from faction lists
```
</details>
| xr_logic.script | 29 | 0 | keep |

<details><summary>Diff for xr_logic.script</summary>
```diff
diff --git a/runtime files/gamedata/scripts/xr_logic.script b/gamma_walo/gamedata/scripts/xr_logic.script
index 59b6bdc..bf55109 100644
--- a/runtime files/gamedata/scripts/xr_logic.script	
+++ b/gamma_walo/gamedata/scripts/xr_logic.script
@@ -38,0 +39 @@ end
+-- Spawn configured items into an NPCs inventory during initialization
@@ -128 +129 @@ function configure_schemes(npc, ini, ini_filename, stype, section_logic, gulag_n
-	--  
+	--  
@@ -150 +151 @@ end
---        
+--        
@@ -163 +164 @@ function determine_section_to_activate(npc, ini, section_logic, actor)
-	--        ,   %%
+	--        ,   %%
@@ -179 +180 @@ end
---     ,        enable_generic_schemes
+--     ,        enable_generic_schemes
@@ -186 +187 @@ end
---     ,        disable_generic_schemes
+--     ,        disable_generic_schemes
@@ -192,3 +193,3 @@ end
---     :      
---     gulag_name 
---  section  ,       .
+--     :      
+--     gulag_name 
+--  section  ,       .
@@ -258 +259 @@ function activate_by_section(npc, ini, section, gulag_name, loading)
-	--  :
+	--  :
@@ -261 +262 @@ function activate_by_section(npc, ini, section, gulag_name, loading)
-	--   :
+	--   :
@@ -265,2 +266,2 @@ function activate_by_section(npc, ini, section, gulag_name, loading)
-	-- schemes[scheme]    (),    
-	-- _G[]     ()  
+	-- schemes[scheme]    (),    
+	-- _G[]     ()  
@@ -284 +285 @@ function activate_by_section(npc, ini, section, gulag_name, loading)
-		--         
+		--         
@@ -296,3 +297,3 @@ end
--- :
---	    ( ,  )   
---	 .
+-- :
+--	    ( ,  )   
+--	 .
@@ -356 +357 @@ end
--- st - storage  
+-- st - storage  
@@ -379 +380 @@ end
---'         
+--'         
@@ -529,2 +530,2 @@ end
---     ,  .
---  section == nil,    .
+--     ,  .
+--  section == nil,    .
@@ -652 +653 @@ function is_active(npc, st)
-	--              
+	--              
@@ -662,2 +663,2 @@ end
---         "  +infop1  -infop2 +infop3 ... "
---  :
+--         "  +infop1  -infop2 +infop3 ... "
+--  :
@@ -718 +719 @@ function parse_infop(rslt, str)
-			--   
+			--   
@@ -753 +754 @@ end
---   src :
+--   src :
@@ -755 +756 @@ end
---  :
+--  :
@@ -1025,2 +1026,2 @@ end
---    ,       ,
---  nil,       ,   .
+--    ,       ,
+--  nil,       ,   .
```
</details>
| diplomacy_core.script | new file | - | new module |
| diplomacy_system.script | new file | - | new module |
| faction_ai_logic.script | new file | - | new module |
| faction_philosophy.script | new file | - | new module |
| legendary_squad_system.script | new file | - | new module |
| meta_overlord.script | new file | - | new module |
| monolith_ai.script | new file | - | new module |
| node_system.script | new file | - | new module |
| pda_context_menu.script | new file | - | new module |
| placeable_system.script | new file | - | new module |
| resource_pool.script | new file | - | new module |
| resource_system.script | new file | - | new module |
| squad_gear_scaler.script | new file | - | new module |
| ui_pda_diplomacy.script | new file | - | new module |
| verbose_logger.script | new file | - | new module |
