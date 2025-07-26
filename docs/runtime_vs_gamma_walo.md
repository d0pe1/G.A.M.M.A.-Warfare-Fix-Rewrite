# Runtime vs Mod Diff Report

## Differences for old_walo
### dialogs.script
```diff
--- /workspace/G.A.M.M.A.-Warfare-Fix-Rewrite/runtime files/gamedata/scripts/dialogs.script

+++ /workspace/G.A.M.M.A.-Warfare-Fix-Rewrite/old walo/gamedata/scripts/dialogs.script

@@ -32,7 +32,6 @@

 	task_manager.get_task_manager():give_task("mar_find_doctor_task")
 end
 
--- Helper used in dialog preconditions to hide options when Warfare is active
 function warfare_disabled(a,b)
 	if _G.WARFARE then
 		return false
@@ -44,7 +43,6 @@

 -- Task stacking check
 -------------------------------------------
 local mark_task_per_npc = {}
--- Returns the maximum simultaneous tasks an NPC can offer based on options
 function get_npc_task_limit()
 	return tonumber(ui_options.get("gameplay/general/max_tasks") or 2)
 end
@@ -2470,6 +2468,13 @@

 -- Trade important documents
 -----------------------------------------------------------------------------------
 local important_docs = {
+	["main_story_1_quest_case"] = 10000,
+	["main_story_2_lab_x18_documents"] = 13000,
+	["main_story_3_lab_x16_documents"] = 16000,
+	["main_story_4_lab_x10_documents"] = 20000,
+	["main_story_5_lab_x8_documents"] = 13000,
+	["main_story_6_jup_ug_documents"] = 14000,
+	["main_story_7_mon_con_documents"] = 25000,
 }
 
 local important_docs_warfare_names = {
@@ -2549,6 +2554,8 @@

 
 function trade_important_documents_reward(a,b)
 	local sweets_1 = {
+		"af_aac",
+		"af_iam",
 		"af_plates",
 		"af_camelbak",
 		"af_surge_up",
```
### faction_expansions.script
```diff
--- /workspace/G.A.M.M.A.-Warfare-Fix-Rewrite/runtime files/gamedata/scripts/faction_expansions.script

+++ /workspace/G.A.M.M.A.-Warfare-Fix-Rewrite/old walo/gamedata/scripts/faction_expansions.script

@@ -7,8 +7,7 @@

 	2020/05/25 - Vintar
 	2020/05/31 - Vintar - lowered loner veteran chance
 	2021/02/27 - Vintar - lowered loner advanced/veteran chance again, removed rats from spawn
-        2021/03/02 - Vintar - removed black smoke poltergeist
-        2025/07/24 - d0pe - documented spawn chance formulas
+	2021/03/02 - Vintar - removed black smoke poltergeist
 
 	This file provides the chance for advanced/veteran squads to spawn instead of novice
 	squads, or picks a normal/rare mutant spawn section.
@@ -133,13 +132,11 @@

 
 -- old functions were overly complicated and had a weird minimum at 80% resource ownership where your squads would be worse on average
 -- new functions are monotonically increasing so that each point of resource is always a sizeable benefit
--- Chance percentage for an advanced squad spawn given owned resources
 function get_advanced_chance(resource)
 --	return -1 * (100 * (1 / math.pow(warfare.resource_count / 2, 2))) * math.pow((resource - (warfare.resource_count / 2)), 2) + 100
 	return 150 * (math.pow((resource / warfare.resource_count), 0.8))
 end
 
--- Chance percentage for a veteran squad spawn given owned resources
 function get_veteran_chance(resource)
 --	return -100 + (100 / (warfare.resource_count / 2)) * resource
 	return 100 * (math.pow((resource / warfare.resource_count), 2))
```
### game_fast_travel.script
```diff
--- /workspace/G.A.M.M.A.-Warfare-Fix-Rewrite/runtime files/gamedata/scripts/game_fast_travel.script

+++ /workspace/G.A.M.M.A.-Warfare-Fix-Rewrite/old walo/gamedata/scripts/game_fast_travel.script

@@ -1,332 +1,19 @@

--- ======================================================================
---[[	Fair Fast Travel System
--- ==================================================================--]]
-script_name 	= "game_fast_travel"
-script_version 	= "2.18.1"
-release_date 	= 20250718.1
---[[=====================================================================
-	Author: Catspaw (CatspawMods @ ModDB)
-	Source: https://www.moddb.com/mods/stalker-anomaly/addons/fair-fast-travel-duration-for-anomaly-151
-	https://www.youtube.com/@CatspawAdventures
-
-	Based on the Fast Travel system in Anomaly 1.5.2 by:
-		Alundaio (original author)
-		sLoPpYdOtBiGhOlE (marker names, menu and config options, etc)
-
-	Additional credits:
-		TheMrDemonized (Limited and Paid Fast Travel, code help)
-		Grimscribe (Immersive Fast Travel Overhaul)
-		Arszi (Radiation Overhaul)
-
--- ======================================================================
---		DEPENDENCIES AND SHORTCUTS
--- ====================================================================]]
-assert(utils_catspaw_common and utils_catspaw_common.import_metatable,
-    "\n! ERROR: Fair Fast Travel requires utils_catspaw_common, which does not exist or is outdated!\n"
-)
-assert(utils_catspaw_text,
-    "\n! ERROR: Fair Fast Travel requires utils_catspaw_text, which does not exist!\n"
-)
-assert(utils_catspaw_mapspots,
-    "\n! ERROR: Fair Fast Travel requires utils_catspaw_mapspots, which does not exist!\n"
-)
-printf("Fair Fast Travel v%s (rel %s) began initialization at %s", script_version, release_date, time_global())
-utils_catspaw_common.import_metatable(this, utils_catspaw_common)
-utils_catspaw_common.import_metatable(this, utils_catspaw_text)
-utils_catspaw_common.import_metatable(this, utils_catspaw_mapspots)
--- ======================================================================
-local dl, vl
-logprefix   = "[FFT] "
-debuglogs   = false
-verbose     = false
-debug_dump  = false
-
-function allow_local_logging(onoff)
-    if onoff then
-        dl = function(logtext, ...) dlog(this, logtext, ...) end
-        vl = function(logtext, ...) vlog(this, logtext, ...) end
-    else
-        dl = function(logtext, ...) dlog(nil, logtext, ...) end
-        vl = function(logtext, ...) vlog(nil, logtext, ...) end
-    end
-end
-allow_local_logging(true)
-
-function set_debug_logging(debug_en, verbose_en, dump_en)
-    if (debug_en ~= nil) then debuglogs = debug_en end
-    if (verbose_en ~= nil) then verbose = verbose_en end
-    if (dump_en ~= nil) then debug_dump = dump_en end
-end
-
---set_debug_logging(true, true, true) --uncomment this line to enable all logging for troubleshooting
--- First two values will be overridden by MCM once the game loads
-
-local dotip 			= function(tiptext, dur, src, beep, icon, snd) dotip(tiptext, dur, src or gts("st_fftd_ftsystem"), beep, icon or "ui_iconsTotal_found_money", snd) end
--- ======================================================================
-local parse_tokens 		= parse_color_tokens
-local in_sine 			= easing.InSine
-local get_mcm 			= get_mcm_or_default_val
-local psk           	= utils_data.parse_string_keys
-local get_spot_desc 	= dynamic_news_helper.GetPointDescription
-local gts 				= game.translate_string
-local sformat 			= string.format
-local gg 				= game_graph
-local floor 			= math.floor
--- ======================================================================
-skillsystem_exists 		= (haru_skills ~= nil)
-stored_satiety			= 1
-locations_found 		= 0
-campfire_dest_adj 		= {x = -1.5, y = 0, z = 0} -- to avoid depositing the player inside a lit campfire
-npe_shown 				= {}
-local actor_last_seen 	= 0
-local next_tick 		= time_global()
-local menu_options 		= {}	-- used at runtime
-local xml       		= CScriptXmlInit()
-local color_dimmed 		= {a = 200,	r = 255,g = 255,b = 255}
--- ======================================================================
--- 		VANILLA SETTINGS
--- ======================================================================
-longnames 		= false
-markermessage 	= false
-tsmarts 		= nil
-basecfg = {
-	["ft"] = {
-		state 	= 0,
-		enabled = true,
-		combat 	= false,
-		weight 	= false,
-		damage 	= false,
-		storm 	= false,
-		notime 	= false,
-	},
-	["bp"] = {
-		enabled = true,
-		combat 	= false,
-		weight 	= false,
-		damage 	= false,
-		storm 	= false,
-		notime 	= false,
-	},
-	["gt"] = {
-		enabled = true,
-		combat 	= false,
-		weight 	= true,
-		damage 	= true,
-		storm 	= false,
-		notime 	= false,
-	},
-}
-
--- ======================================================================
---[[	FAST TRAVEL TEXT SUBSTITUTION TOKENS
--- ======================================================================
-	These can be used to customize the strings used in the PDA context 
-	menus and guide dialogue. The table containing these tokens is 
-	initialized at runtime by the parse_trip_tokens function. The strings 
-	that can currently be customized are initialized just below.
---]]
-local def_distdur 	= "($distkm, $estdur$time)"
-local def_st_fare	= ": fareval $rubles"
-local def_context	= "$go_to $dest $distdur$farestr$gated"
-distdur_string 		= def_distdur
-fare_string 		= def_st_fare
-context_string 		= def_context
-guide_menu_text 	= "$dest. $clr_gld[$fareval $rubles] $clr_wht$distdur"
-vanilla_menu_text 	= "$dest. $clr_orn[$fareval $rubles]" 	-- vanilla style
-gated_menu_text 	= "$clr_ui2$dest. $clr_red$gated"
---[[
-		$dest:		localized name of the destination
-		$distm:		distance to destination, in meters
-		$distkm:	distance shown in kilometers if > 1000
-		$time:		trip duration in format hh:mm
-		$fareval:	final adjusted fare
-		$dur_t:		total trip duration in minutes
-		$dur_h:		hour portion of hh:mm trip duration
-		$dur_m:		minutes portion of hh:mm trip duration
-		$level: 	level name of destination, if known
-		$gated: 	localized warning shown if scorcher blocks N-S route
-		$estdur: 	if random duration enabled, localized "at least "
-		$go_to: 	localized "Fast/Backpack travel to" or "Hire a guide to"
-		$rubles: 	localized currency abbreviation
-		$farestr: 	fare_string, parsed and shown only if cost > 0
-			Customizable in fare_string, can contain other tokens
-		$distdur: 	distdur_string, parsed and shown only if enabled
-			Customizable in distdur_string, can contain other tokens
---]]			
--- ======================================================================
--- 		LOOKUP TABLES
--- ======================================================================
--- 	Most of these are populated at runtime via load_file_data()
-local zone_spawn_version
-local travel_data 			= {}
-td 							= {}
-all_travel_types 			= {} -- public iterable quick string lookup for travel type name
-spawned_travel_zones 		= {}
-fast_travel_restrictors 	= {}
-level_ids 					= {}
-northern_maps 				= {}
-guide_ignored_levels 		= {} -- Levels in which guides will refuse to come meet you
--- ======================================================================
---[[ 	CUSTOM FAST TRAVEL CALLBACKS
--- ======================================================================
-	These new callbacks allow other scripts to cleanly override or tweak
-	fast travel on a per-trip basis.
-
-	Both callbacks send a table as their only parameter, containing trip
-	data in the structure shown below in "default_trip_data".
-
-	See map_spot_menu_property_clicked for more details about how this
-	works, and default_trip_data below for the format of the table.
-
-	I am no longer bothering to nil-check AddScriptCallback. If you're 
-	still on Anomaly 1.5.1, it is LONG past time to upgrade.
--- ====================================================================]]
-AddScriptCallback("on_try_fast_travel") 		-- sent before any travel logic takes place
-AddScriptCallback("on_before_fast_travel") 		-- sent after all travel logic, just before taking action
-AddScriptCallback("on_new_fast_travel_point") 	-- sent when first encountering any new fast travel point
-
---[[=====================================================================
-	EXAMPLE:
-	If you wanted to block the player from fast traveling out of the 
-	Brain Scorcher as long as the countdown is active, you could put 
-	something like this in its own script:
--- ======================================================================
-
-function scorcher_travel_check(trip)
-    if (level.name() == "l10u_bunker") and IsStoryMode() and (not dialogs.actor_true_monolith()) and (not game_statistics.has_actor_achievement("duga_free")) then
-        trip.ret_value = false
-        hide_hud_pda()
-        actor_menu.set_msg(1, game.translate_string("st_fft_travel_psyblocked"), 4)
-    end
-end
-
-function on_game_start()
-    RegisterScriptCallback("on_before_fast_travel", scorcher_travel_check)
-end
-
--- ======================================================================
-	Setting trip.ret_value to false aborts travel if the player is on
-	the correct level, in story mode, isn't Monolith, and doesn't have 
-	the	Duga Free achievement they get for shutting off the Scorcher.
--- ====================================================================]]
-
-local default_trip_data = {
-	--[[=================================================================
-		This table holds the data structure and default starting
-		values for all fast travel trips.
-
-		It is populated during travel logic and sent as the 
-		sole parameter for the above callbacks.
-		
-		Modifying any of these values will propagate to the
-		travel logic that follows the callback.
-	--=================================================================]]
-	id 					= nil, 	-- destination object ID
-	started 			= false,-- set true once travel logic begins
-	tt 					= nil,	-- travel type: ft, bp, or gt
-	maploc 				= nil, 	-- "map" if changing maps, "loc" if not
-	cfg 				= {}, 	-- will contain full config table for travel type
-	apos 				= nil,	-- actor position
-	dpos 				= nil,	-- destination position
-	dest 				= nil,	-- destination server object
-	dist 				= 0,	-- final distance
-	durt 				= 0,	-- total trip duration in minutes
-	durh 				= 0,	-- trip duration in hours
-	durm 				= 0,	-- trip duration in minutes
-	cost 				= 0,	-- trip cost in rubles
-	erst 				= nil,	-- localization text string for error, if any
-	smart 				= nil,	-- target smart, if any
-	level 				= nil,  -- target level name
-	is_bp 				= nil, 	-- for mapspot text generation at runtime, don't set/change
-	npc 				= false,-- flag indicating that travel began from a guide NPC
-	text 				= nil, 	-- text of the menu option that was clicked
-	hide_pda 			= true, -- hide PDA after local travel
-	ret_value 			= true,	-- set false to abort all further action/cancel trip
-	paid 				= false,-- guide cost already paid or waived by another script
-	nosquad 			= nil,	-- if true, FFT will not teleport the actor's squad
-}
-
-trip = {}
-
-function reset_trip_data()
-	trip = dup_table(default_trip_data)
-	return trip
-end
-
-function dump_trip_data(tdata)
-	local div = "\n~ ------------------------------------------------------------------------"
-	tdata = tdata or trip
-	local dump = div.."\n# DUMPING TRIP DATA"..div
-	for k,v in pairs(tdata) do
-		dump = dump.."\n"..k.." = "..(v or "")
-	end
-	dump = dump..div
-	printf(logprefix..dump)
-end
-
-function debug_dump_trip_data(tdata)
-	if debuglogs and verbose then
-		dump_trip_data(tdata)
-	end
-end
-
--- ======================================================================
--- Utility functions
--- ======================================================================
-
-function level_id_for_name(n)
-	-- logging is spammy, disable when not needed
-	--vl("level_id_for_name: %s = %s", n, level_ids[n])
-	return level_ids[n]
-end
-
-
-function actor_rank_val()
-	if not db.actor then return 0 end
-	return clamp(db.actor:character_rank(), 0, prog_rank_cap or 56000)
-end
-
-
-function monolith_science_toys_off()
-	return
-		has_alife_info("story_mode_disabled") or
-		(	
-			has_alife_info("yan_labx16_switcher_primary_off") and
-			has_alife_info("bar_deactivate_radar_done")
-		)
-end
-
-function get_travel_type(tt, maploc_or_bool)
-	-- disable this log line when not testing
-	-- vl("get_travel_type: tt %s | maploc_or_bool %s",tt,maploc_or_bool)
-	if not (tt and td[tt]) then
-		return td
-	elseif maploc_or_bool == nil then
-		return td[tt]
-	else
-		local maploc = maploc_or_bool
-		if type(maploc_or_bool) ~= "string" then
-			maploc = maploc_or_bool and "map" or "loc"
-		end
-		return td[tt][maploc]
-	end
-end
-
-
-local function use_skillsystem()
-	return skillsystem_exists and skillsystem_enabled and skillsystem_started
-end
-
-
-function hide_pda()
-	if trip.hide_pda then
-		hide_hud_all()
-	end
-end
-
-
-function bbp_extra_weight()
-	-- vanilla function
+------------------------------
+-- Fast Travel system
+-- author: Alundaio
+-- Modified: sLoPpYdOtBiGhOlE (marker names, menu and config options, etc)
+------------------------------
+local enabled = 0
+local combattravel = false
+local weighttravel = false
+local damagetravel = false
+local stormtravel = false
+local longnames = false
+local markermessage = false
+local notime = false
+local tsmarts = nil
+
+local function bbp_extra_weight()
 	local w = 0
 	
 	local function itr(npc,itm)
@@ -342,1558 +29,183 @@

 	return w
 end
 
--- ======================================================================
--- Condition checks - prereqs for travel
-
--- The silent option in these isn't currently used, but is there in case 
--- it's ever necessary to do one of these checks without taking action
--- ======================================================================
-
-function actor_has_ftzone_permission(ftzone, mode)
-	-- Mode 0: no zone restrictions
-	-- Mode 1: can only initiate travel from friendly base
-	-- Mode 2: can only initiate travel from own faction base
-	local comm = fast_travel_restrictors[ftzone] and fast_travel_restrictors[ftzone].default_owner
-	if not comm then return true end
-	local acomm = zones_use_disguises and character_community(db.actor):sub(7) or get_actor_true_community()
-	local is_enemy = game_relations.is_factions_enemies(comm,acomm)
-	-- don't enable, log line is spammy when travel zone indicator is active
-	--printf("[FFT] actor_has_ftzone_permission for %s in mode %s: comm %s | acomm %s | is_enemy %s",ftzone,mode,comm,acomm,is_enemy)
-	return (
-		(mode == 0) or
-		((mode == 1) and not is_enemy) or
-		((mode == 2) and (comm == acomm))
-	) and true or false
-end
-
-
-function get_zone_mode(tt)
-	tt = tt or "ft"
-	return td[tt] and td[tt]["cfg"] and td[tt]["cfg"].zone_mode
-end
-
-function get_camp_mode(tt)
-	tt = tt or "ft"
-	return td[tt] and td[tt]["loc"] and td[tt]["loc"].camp_mode
-end
-
-
-function campfires_are_bases(tt)
-	return td[tt] and td[tt]["cfg"] and td[tt]["cfg"].campfire_base
-end
-
-
-function is_lit_campfire(se_obj)
-	if not se_obj then return end
-	if (se_obj:clsid() ~= clsid.zone_campfire) then return false end
-	local campfire = bind_campfire.campfires_all[se_obj.id].campfire
-	if campfire and campfire.is_on then
-		return campfire:is_on()
-	end
-end
-
-function is_travel_allowed_to_campfire(tt, se_obj)
-	local mode = get_camp_mode(tt)
-	return (mode > 1) or ((mode > 0) and is_lit_campfire(se_obj))
-end
-
-function actor_is_near_lit_campfire(dist)
-	local campfire = bind_campfire.get_nearby_campfire(dist or campfire_origin_dist, true)
-	return campfire and campfire:is_on()
-end
-
-
-function actor_in_travel_zone(tt)
-	if not db.actor then return end
-	tt = tt or "ft"
-	local mode = td[tt]["cfg"].zone_mode or 0
-	if mode == 0 then
-		-- Feature not enabled, allow all travel origins
-		return true
-	end
-
-	if campfires_are_bases(tt) and actor_is_near_lit_campfire() then
-		return true
-	end
-
-	for k,v in pairs(spawned_travel_zones) do
-		if db.actor_inside_zones[k] then
-			-- log line is spammy when travel zone indicator is active
-			--vl("actor is inside travel zone %s",k)
-			if actor_has_ftzone_permission(v.loc, mode) then
-				return true
-			end
-		end
-	end
-	return false
-end
-
-
-function actor_in_recent_combat()
-	if not db.actor then return end
-    local xr_combat_npcs 	= xr_combat_ignore.fighting_with_actor_npcs
-    if is_empty(xr_combat_npcs) then
-    	-- don't enable, this logging line is really spammy
-    	--vl("actor_in_recent_combat: Not fighting with any NPCs, returning false")
-    return false end
-
-    for id,_ in pairs(xr_combat_npcs) do
-		if id and (id > 0) then
-			local npc = get_object_by_id(id)
-			if npc and npc:alive() then
-				local npos = npc and npc:position()
-				local dist = db.actor:position():distance_to(npos) or 0
-				if dist <= npc_combat_distance then
-				    local now = time_global()
-					if npc and npc:alive() and npc:see(db.actor) then
-						actor_last_seen = now
-						--vl("NPC %s is in combat with actor, last saw actor at %s")
-						return true
-					end
-					if actor_last_seen < (now + npc_combat_timeout) then
-						--vl("Actor has been seen in the last %s seconds",npc_combat_timeout/1000)
-						return true
-					end
-				end
-			else
-				table.remove(xr_combat_ignore.fighting_with_actor_npcs, id)
-			end
-		end
-	end
-end
-
-
-function combat_travel_ok(tt,silent)
-	-- Prevent fast travel while in combat
-	if not (tt and basecfg[tt]) then return false end
-	local fighting = false
-	local combattravel = basecfg[tt].combat
+local function map_spot_menu_add_property(property_ui,id,level_name)
+	local se_obj = id > 0 and alife_object(id)
+	if not (se_obj) then
+		return
+	end
+	if (DEV_DEBUG) or (enabled > 0 and se_obj:clsid() == clsid.smart_terrain and tsmarts[se_obj:name()]) then
+		if (longnames) then
+				property_ui:AddItem(game.translate_string("st_pda_fast_travel_to").." ".. game.translate_string(level_name).." "..game.translate_string(se_obj:name()))
+		else
+				property_ui:AddItem(game.translate_string("st_pda_fast_travel_to").." "..game.translate_string(se_obj:name()))
+		end
+	end
+end
+
+local function map_spot_menu_property_clicked(property_ui,id,level_name,prop)
+	local se_obj = alife_object(id)
+	if not (se_obj) then
+		return
+	end
+
+	if (longnames) then
+		if (prop ~= (game.translate_string("st_pda_fast_travel_to").." "..game.translate_string(level_name).." "..game.translate_string(se_obj:name()))) then
+			return
+		end
+	else
+		if (prop ~= (game.translate_string("st_pda_fast_travel_to").." "..game.translate_string(se_obj:name()))) then
+			return
+		end
+	end
+
+	-- Prevent fast travel if in combat.
 	if not (combattravel) then
-		fighting = actor_in_recent_combat()
-		dl("Condition check: fighting = %s | combattravel %s",fighting,combattravel)
-		if fighting and not (silent or combattravel) then
-			hide_hud_pda()
-			cancel_travel_message(gts("st_travel_event"))
-		end
-	end
-	return combattravel or not fighting
-end
-
-
-function weight_travel_ok(tt,silent)
-	-- Prevent fast travel while overloaded
-	if not (tt and basecfg[tt]) then return false end
-	local overweight = false
-	local weighttravel = basecfg[tt].weight
-	if not weighttravel then
+		if not (is_empty(xr_combat_ignore.fighting_with_actor_npcs)) then
+			hide_hud_pda()
+			actor_menu.set_msg(1, game.translate_string("st_travel_event"),4)
+			return
+		end
+	end
+
+	-- Prevent fast travel while overloaded.
+	if not (weighttravel) then
 		local suit = db.actor:item_in_slot(7)
-		overweight = (db.actor:get_total_weight() - db.actor:get_actor_max_walk_weight() - (suit and suit:get_additional_max_weight() or 0) - bbp_extra_weight()) > 0
-		dl("Condition check: overweight = %s | weighttravel %s",overweight,weighttravel)
-		if overweight and not (silent or weighttravel) then
-			hide_hud_pda()
-			cancel_travel_message(gts("st_travel_overloaded"))
-		end
-	end
-	return weighttravel or not overweight
-end
-
-
-function damage_travel_ok(tt,silent)
-	-- Prevent fast travel if injured, bleeding, and/or iradiated
-	if not (tt and basecfg[tt]) then return false end
-	local damagetravel 	= basecfg[tt].damage
-	if not damagetravel then
-		local actor 	= db.actor
-		local hurt 		= (actor.health < minimum_health)
-		local radiation = (actor.radiation > 0)
-		if radiation and arszi_radiation then
-			local arrad = arszi_radiation
-			radiation 	= 
-				(arrad.settings.fastTravelWithRads == 1) and
-				(db.actor.radiation <= arrad.settings.RADIATION_THRESHOLD) or
-				(arrad.settings.fastTravelWithRads == 2)
-			dl("arszi_radiation installed, radiation = %s",radiation)
-		end
-		local bleeding 	= (actor.bleeding > 0)
-		local cond 		= actor:cast_Actor():conditions()
-		local hangry 	= (cond:GetSatiety() < minimum_satiety)
-		local damaged 	= (hurt or bleeding or radiation or hangry)
-
-		dl("Condition check: damaged = %s | damagetravel %s",damaged,damagetravel)
-		if damaged and not (silent or damagetravel) then
-			local hurtmsg = ""
-			if ((hurt or bleeding) and radiation) then
-				hurtmsg = "st_sleep_bleeding_irradiated"
-			elseif (hurt or bleeding) then
-				hurtmsg = "st_sleep_bleeding"
+		local diff = db.actor:get_total_weight() - db.actor:get_actor_max_walk_weight() - (suit and suit:get_additional_max_weight() or 0) - bbp_extra_weight()
+		if diff > 0 then
+			hide_hud_pda()
+			actor_menu.set_msg(1, game.translate_string("st_travel_overloaded"),4)
+			return
+		end
+	end
+
+	-- Prevent fast travel if bleeding and/or iradiated.
+	if not (damagetravel) then
+		local bleeding = db.actor.bleeding > 0
+		local radiation = db.actor.radiation > 0
+		if (bleeding or radiation) then
+			if (bleeding and radiation) then
+				actor_menu.set_msg(1, game.translate_string("st_sleep_bleeding_irradiated"),5)
+			elseif (bleeding) then
+				actor_menu.set_msg(1, game.translate_string("st_sleep_bleeding"),4)
 			elseif (radiation) then
-				hurtmsg = "st_sleep_irradiated"
-			end
-			hide_hud_pda()
-			cancel_travel_message(gts(hurtmsg))
-		end
-	end
-	return damagetravel or not damaged
-end
-
-
-function storm_travel_ok(tt,silent)
-	-- Prevent fast travel if an emission or psi-storm currently ongoing
-	if not (tt and basecfg[tt]) then return false end
-	local stormy = false
-	local stormtravel = basecfg[tt].storm
+				actor_menu.set_msg(1, game.translate_string("st_sleep_irradiated"),4)
+			end
+			hide_hud_pda()
+			return
+		end
+	end
+
+	-- Prevent fast travel if an emission or psi-storm currently ongoing.
 	if not (stormtravel) then
-		stormy = (xr_conditions.surge_started() or psi_storm_manager.is_started())
-		dl("Condition check: stormy = %s | stormtravel %s",stormy,stormtravel)
-		if stormy and not (silent or stormtravel) then
-			hide_hud_pda()
-			cancel_travel_message(gts("st_travel_event"))
-		end
-	end
-	return stormtravel or not stormy
-end	
-
-
-function guide_travel_ok(tt,silent)
-	if (tt ~= "gt") then return true end
-	local level_name = level.name()
-	local guide_ok = not guide_ignored_levels[level_name]
-	dl("Condition check: guide_ok = %s | guide_ignored_levels[%s] %s",guide_ok,level_name,guide_ignored_levels[level_name])
-	if not guide_ok then
-		if silent then
-			trip.erst = gts(err_ignored)
+		if (xr_conditions.surge_started() or psi_storm_manager.is_started()) then
+			actor_menu.set_msg(1, game.translate_string("st_travel_event"),4)
+			hide_hud_pda()
+			return
+		end
+	end
+
+	-- forward time when traveling
+	if not (notime) then
+		local dist = db.actor:position():distance_to(se_obj.position)
+		level.change_game_time(0,math.floor(dist/1000)+math.random(0,2),math.random(1,59))
+		surge_manager.get_surge_manager().time_forwarded = true
+		psi_storm_manager.get_psi_storm_manager().time_forwarded = true
+		level_weathers.get_weather_manager():forced_weather_change()
+	end
+
+	if (se_obj.online) then
+		db.actor:set_actor_position(se_obj.position)
+		hide_hud_pda()
+	else
+		ChangeLevel(se_obj.position, se_obj.m_level_vertex_id, se_obj.m_game_vertex_id, VEC_ZERO, true)
+	end
+end
+
+-- Used for Visit_Only mode, catches the player near the marker and updates things.
+local function actor_on_interaction(typ, obj, name)
+	if (enabled ~= 1) or IsWarfare() then
+		return
+	end
+	
+	if (typ ~= "smarts") then
+		return
+	end
+	
+	if not (tsmarts[name]) then
+		return
+	end
+	
+	if (level.map_has_object_spot(obj.id, "fast_travel") == 0) then
+		if (longnames) then
+			local smart = alife():object(obj.id)
+			local level_name = alife():level_name(smart and game_graph():vertex(smart.m_game_vertex_id):level_id())			
+			level.map_add_object_spot(obj.id, "fast_travel", game.translate_string(level_name).." "..game.translate_string(name))
+			if (markermessage) then
+				actor_menu.set_msg(1, game.translate_string(level_name).." "..game.translate_string(name).." "..game.translate_string("st_fast_travel_discovered"), 4)
+			end
 		else
-			hide_hud_pda()
-			cancel_travel_message(gts(err_ignored))
-		end
-	end
-	return guide_ok
-end
-
-function get_map_hazard_coef(orig, dest)
-	if not use_map_hazard_coef then return 1 end
-	local haz1 = orig and map_hazard_coefs[orig] or 1
-	local haz2 = dest and map_hazard_coefs[dest] or 1
-	return use_hazard_coef_avg and ((haz1 + haz2) / 2) or greater_of(haz1, haz2)
-end
-
-function get_rounded_cost(cost, is_npc)
-	if nice_round_numbers and not is_npc then
-		local old = cost
-		cost = round100(cost)
-		if cost < 100 then cost = 100 end
-		--vl("rounding %s down to nearest 100: %s",old, cost)
-	end
-	return cost
-end
-
-function travel_cost_coef(tt, is_npc)
-	is_npc = is_npc and true or false
-	local coef = is_npc and guide_npc_cost_coef
-	return coef or (td and td[tt] and td[tt]["cfg"] and td[tt]["cfg"].cost_coef) or 0
-end
-
-function cost_to_travel(dist, tt, is_npc, map_coef)
-	tt = tt or "gt"
-	local rankadj 	= 1
-	local logstr 	= ""
-	if progressive_cost then
-		local coef	= prog_coef_max or 1
-		local rank	= (actor_rank_val() or 0)			-- actor rank
-		local rval	= rank / (prog_rank_cap or 56000)	-- rank value 0-1 towards cap
-		local rprog = in_sine(rval)						-- rankval applied to curve
-		rankadj 	= ((pc and rprog) or 0) * coef 		-- final cost multiplier (1 if disabled)
-		logstr 		= string.format("[ rank %s | val %s | prog %s = adj %s ] | ", rank, rval, rprog, rankadj)
-	end
-	local basecost 	= dist * travel_cost_coef(tt, is_npc)
-	local adjcost 	= get_rounded_cost(math.floor( basecost + (basecost * rankadj * (map_coef or 1)) ), is_npc)
-	vl("cost_to_travel: %s RU | dist %s | base %s | map_coef %s (%s) | %s",
-		adjcost, dist, basecost, map_coef, map_coef or 1, logstr)
-	return adjcost
-end
-
-
-function charge_for_travel(cost,silent,msg,icon,snd,check_only)
-	local can_afford = db.actor:money() >= cost
-	if can_afford and not check_only then
-		dl("Charging actor %s RU",cost)
-		db.actor:give_money(-cost)
-		if not silent then
-			msg = msg or trip.faretxt or "st_fftd_farepaid_guide"
-			local dur = 10000
-			local st_cost = sformat("$clr_gld%s $clr_wht%s", cost, gts(st_rubles))
-			st_cost = parse_tokens(st_cost, nil, true)
-			local tiptext =	sformat(gts(msg),st_cost)
-			dotip(tiptext,dur,gts("st_fftd_ftsystem"),true,icon,snd)
-		end
-	end
-	return can_afford
-end
-
-
-function pin_travel_allowed(tt)
-	return td[tt] and td[tt]["cfg"].allow_pin_travel
-end
-
-
-function travel_cooldown_enabled(tt)
-	tt = tt or "ft"
-	local cden = (td and td[tt]["cfg"].travel_cooldown or 0) > 0
-	dl("travel_cooldown_enabled(%s) = %s",tt,cden)
-	return cden
-end
-
-function travel_on_cooldown(tt)
-	tt = tt or "ft"
-	if not travel_cooldown_enabled(tt) then return end
-	local next_travel = td[tt].next_travel or 0
-	local t = get_time_elapsed()
-	if t and next_travel then
-		local toosoon = (t < next_travel)
-		dl("travel_on_cooldown(%s) = %s",toosoon)
-		return toosoon
-	end
-end
-
-function travel_cooldown_remaining(tt)
-	tt = tt or "ft"
-	local elapsed = get_time_elapsed()
-	local cdrem = math.ceil(td[tt].next_travel - elapsed)
-	dl("travel_cooldown_remaining(%s) = %s",tt,cdrem)
-	return cdrem
-end
-
-function update_travel_cooldown(tt)
-	if shared_ft_cooldown then
-		dl("shared_ft_cooldown is %s, triggering cooldowns for all travel types",shared_ft_cooldown)
-		for k,_ in pairs (all_travel_types) do
-			td[k].next_travel = get_time_elapsed() + (td[k]["cfg"].travel_cooldown * 6)
-		end
-	else
-		td[tt].next_travel = get_time_elapsed() + (td[tt]["cfg"].travel_cooldown * 6)
-		dl("shared_ft_cooldown is %s | gte %s | next_travel for %s is %s",shared_ft_cooldown,get_time_elapsed(),tt,td[tt].next_travel)
-	end
-end
-
-function scorcher_blocks_travel(start_map, end_map)
-	if monolith_science_toys_off() then return false end
-	--vl("scorcher_blocks_travel: %s -> %s | start_map north %s | end_map north %s",start_map,end_map,northern_maps[start_map],northern_maps[end_map])
-	return gate_northern_travel and (northern_maps[start_map] ~= northern_maps[end_map])
-end
-
--- ======================================================================
--- Mapspot generation
--- ======================================================================
-
-function generate_distance_text(dist, km)
-	if km and (dist >= 1000) then
-		-- if km is passed true, will try to abbreviate distances >1000 as e.g. 1.1km from 1142m
-		distance = tostring(floor(dist * .01) * 0.1)..gts("st_fftd_mapspot_kilometers")
-	else
-		distance = tostring(floor(dist))..gts("st_fftd_mapspot_meters")
-	end	
-	-- spammy debug log line, do not enable except for testing
-	--vl("generate_distance_text(%s,%s): %s",dist,km,distance)
-	return distance
-end
-
-function parse_trip_tokens(parse_string, tdata, color_support)
-	vl("parse_trip_tokens for string (color: %s): %s",color_support,parse_string)
-	local mtrs 	= gts("st_fftd_mapspot_meters")
-	local kmtrs = gts("st_fftd_mapspot_kilometers")
-	
-	tdata		= tdata or trip
-	if not (parse_string and tdata) then return end
-	local bs 	= scorcher_blocks_travel(level.name(), tdata.level or level.name())
-	local psy 	= bs and not ((tdata.tt == "gt") and npc_guides_ignore_bs)
-	local gated = psy and gts("st_fft_northgate_text") or ""
-	local dest 	= tdata.destname or (tdata.dest and tdata.dest:name()) or ""
-	local lvl 	= gts(tdata.level) or ""
-	local dist 	= tdata.dist or 0
-	local fare 	= tdata.cost or 0
-	local t 	= tostring(tdata.durt or 0)
-	local h 	= tdata.durh or 0
-	local m 	= tdata.durm or 0
-	local str_h = tostring(h) or ""
-	local tstr 	= str_h..":"..sformat("%02d",m)
-	local distm = generate_distance_text(dist)
-	local distk = generate_distance_text(dist, true)
-	local rubles= gts(st_rubles)
-	local estd 	= ""
-	local go_to = ""
-	local cmenu = false
-	if tdata.cfg then
-		local maploc 	= (lvl ~= level.name()) and "map" or "loc"
-		local cfg = tdata.cfg[maploc]
-		if cfg then
-			cmenu = true
-			local isrnd	= cfg.israndom and true or false
-			estd		= isrnd and gts("st_fftd_mapspot_estdur").." " or ""
-			if tdata.tt == "gt" then
-				go_to 	= gts("st_fftd_mapspot_guideto")
-			elseif tdata.is_bp then
-				go_to 	= gts("st_pda_backpack_travel_to")
-				dest 	= get_stash_hint(tdata.id) or dest
-			else
-				go_to 	= gts("st_pda_fast_travel_to")
-			end
-			if (longnames) then	dest = lvl.." "..dest end
-		end
-	end
-
-	local tokens = {
-		-- string replacement tokens for guide text (preamble, route lists, etc)
-		["dest"]	= dest,		-- 	$dest:		localized name of the destination
-		["distm"]	= distm,	-- 	$distm:		distance to destination, in meters
-		["distkm"]	= distk, 	-- 	$distkm:	distance shown in kilometers if > 1000
-		["time"]	= tstr,		-- 	$time:		trip duration in format hh:mm
-		["fareval"]	= fare,		-- 	$fareval:	final adjusted fare (numbers only)
-		["dur_t"] 	= t,		-- 	$dur_t:		total trip duration in minutes
-		["dur_h"]	= h,		-- 	$dur_h:		hour portion of hh:mm trip duration
-		["dur_m"] 	= m,		-- 	$dur_m:		minutes portion of hh:mm trip duration
-		["level"] 	= lvl,		-- 	$level: 	level name of destination, if known
-		["gated"]	= gated,	-- 	$gated: 	localized warning shown if scorcher blocks N-S route
-		["estdur"]	= estd, 	-- 	$estdur: 	if random duration enabled, localized "at least "
-		["go_to"] 	= go_to, 	-- 	$go_to: 	localized "Fast/Backpack travel to" or "Hire a guide to"
-		["rubles"] 	= rubles, 	-- 	$rubles: 	localized currency abbreviation
-	}
-	local fstr 		= (fare > 0) and (not psy) and psk(fare_string, tokens) or ""
-	fstr 			= (fstr == "") and (not cmenu) and gts("st_fft_costfree") or fstr
-	local dstr		= show_dist_and_dur and psk(distdur_string, tokens) or ""
-	tokens.farestr	= fstr 		-- 	$farestr: 	fare_string, parsed and shown only if cost > 0
-	tokens.distdur	= dstr 		-- 	$distdur: 	distdur_string, parsed and shown only if enabled
-	--local text 		= parse_colors(psk(parse_string, tokens), color_support)
-	local text 		= parse_tokens(parse_string, tokens, color_support)
-	return text
-end
-
-function set_menu_option(menu_text, travel_type, valid)
-	if not (menu_text and travel_type) then return end
-	menu_options[menu_text] 		= {}
-	menu_options[menu_text].tt 		= travel_type
-	menu_options[menu_text].valid 	= valid
-end
-
-function generate_mapspot_text(id, level_name, travel_type, parse_string)
-	vl("generate_mapspot_text | id %s | map %s | tt %s | st: %s", id, level_name, travel_type, parse_string)
-	local se_obj = id and (id > 0) and alife_object(id)
-	if not (se_obj) then return	end
-
-	parse_string 		= parse_string or context_string
-	local mapspot_text 	= ""
-	local dest 			= se_obj
-	local dest_pos 		= se_obj.position
-	local name 			= gts(se_obj:name())
-	local paw 			= tasks_placeable_waypoints
-	local quick_pin 	= paw and paw.valid_travel_target(id) or false
-	if quick_pin then
-		name 			= paw.pins[id].text
-	elseif se_obj:clsid() == clsid.zone_campfire then
-		name 			= gts("st_fft_campfire") .. " " .. get_spot_desc(se_obj)
-	end
-	local tt 			= "ft"
-	if all_travel_types[travel_type] then
-		tt 				= travel_type
-	end
-	local using_guide	= (tt == "gt")
-	local diff_map 		= (level_name ~= level.name())
-	local maploc 		= "loc"
-	if diff_map then
-		maploc 			= "map"
-	end
-
-	-- Calculate distance
-	local israndom 		= td[tt][maploc].israndom
-	local time_coef		= td[tt][maploc].time_coef
-	local distcalc 		= calc_distance_for(dest_pos, level_name, using_guide, use_vanilla_calcs)
-	local ftdist 		= distcalc and distcalc.dist or 0
-	if ftdist < 0  then
-		set_menu_option(distcalc.erst, tt, false)
-		return gts(distcalc.erst)
-	end
-
-	-- Calculate cost, if applicable
-	local cost_txt = ""
-	local text_end = ""
-	if travel_cost_coef(tt) > 0 then
-		local map_coef 	= get_map_hazard_coef(level.name(), level_name) or 1
-		local ftcost 	= cost_to_travel(ftdist, tt, false, map_coef)
-
-		if ftcost > 0 then
-			text_end 	= ": "..tostring(ftcost).." "..gts(st_rubles)
-			vl("Paid travel enabled, ftdist is now %s - cost will be %s\n \nText: "..cost_txt,ftdist,ftcost)
-		else
-			vl("Paid travel enabled but fare came out to zero, hiding fare text")
-		end
-	end
-	-- Calculate estimated duration from final distance and generate its text
-	local dur 		= distance_to_duration(tt,maploc,ftdist)
-	local dist 		= generate_distance_text(ftdist)
-	local is_bp 	= se_obj:name():find("^inv_backpack") or se_obj:name():find("^inv_actor_backpack") and true or false
-	local tdata = {
-		id 			= id,
-		tt 			= tt,
-		cfg 		= dup_table(td[tt]),
-		dist 		= ftdist,
-		destname 	= name,
-		cost 		= ftcost,
-		durt 		= dur.t,
-		durh 		= dur.h,
-		durm 		= dur.m,
-		level 		= level_name,
-		is_bp 		= is_bp,
-	}
-	
-	-- Generate final mapspot text from all elements based on travel type
-	mapspot_text = parse_trip_tokens(context_string, tdata)..text_end
-	dl("generated mapspot_text: ",mapspot_text)
-	set_menu_option(mapspot_text, tt, true)
-	return mapspot_text
-end
-
-
-function map_spot_menu_add_property(property_ui, id, level_name)
-	empty_table(menu_options)
-	local se_obj = id and (id > 0) and alife_object(id)
-	if not (se_obj) then return	end
-	local target_name 	= se_obj:name()
-	local cls 			= se_obj:clsid()
-	vl("map_spot_menu_add_property on map %s: %s (%s) clsid %s", level_name, target_name, id, cls)
-
-	if scorcher_blocks_travel(level.name(), level_name) then
-		local psyblock 	= gts("st_fft_travel_psyblocked")
-		set_menu_option(psyblock, tt, false)
-		property_ui:AddItem(psyblock)
-		ui_pda_encyclopedia_tab.unlock_article("encyclopedia_addons_fair_fast_travel_psyblocked")
-		return
-	end
-
-	local ft_state 		= basecfg["ft"].state
-	local ft_enabled  	= td["ft"]["cfg"].enabled
-	local bp_enabled  	= basecfg["bp"].enabled
-	local gt_enabled  	= basecfg["gt"].enabled
-	local is_campfire 	= is_lit_campfire(se_obj)
-	local is_backpack 	= target_name:find("^inv_backpack") or 
-						target_name:find("^inv_actor_backpack") and true or false
-	local is_smart 		= se_obj:clsid() == clsid.smart_terrain
-	local valid_smart 	= (DEV_DEBUG and allow_debug_travel) or
-			((ft_state > 0) and is_smart and tsmarts[target_name]) or
-			((ft_state > 1) and is_smart) or false
-	local paw 			= tasks_placeable_waypoints
-	local quick_pin 	= paw and paw.valid_travel_target(id) or false
-
-	for tt,tname in spairs(all_travel_types) do
-		local condition 	= false
-		if tt == "ft" then
-			condition 	= ft_enabled and (
-							(not is_backpack) and
-							valid_smart or
-							(quick_pin and pin_travel_allowed(tt)) or
-							(is_campfire and is_travel_allowed_to_campfire(tt, se_obj))
-						)
-		elseif tt == "bp" then
-			condition 	= bp_enabled and is_backpack
-		elseif tt == "gt" then
-			condition 	= gt_enabled and (
-					is_smart or 
-					(quick_pin and pin_travel_allowed(tt)) or
-					(is_campfire and is_travel_allowed_to_campfire(tt, se_obj))
-				)
-		end
-		vl("Conditions for travel option check to %s:\n* ft_state %s | ft_enabled %s | bp_enabled %s | gt_enabled %s\n* is_smart %s | valid_smart %s | is_backpack %s | quick_pin %s | is_campfire %s",target_name,ft_state,ft_enabled,bp_enabled,gt_enabled,is_smart,valid_smart,is_backpack,quick_pin,is_campfire)
-
-		if condition then
-			vl("Travel type %s condition test: %s",tt,condition)
-			local mode 	= td[tt]["cfg"].zone_mode or 0
-			if (mode ~= 0) and not actor_in_travel_zone(tt) then
-				local st_mode 	= tostring(mode)
-				local st_tt 	= string.lower(gts("ui_mcm_menu_"..tt.."cfg"))
-				local blockmsg	= sformat(gts("st_fft_travel_zoneblocked_"..st_mode),st_tt)
-				set_menu_option(blockmsg, tt, false)
-				property_ui:AddItem(blockmsg)
-			elseif travel_cooldown_enabled(tt) and travel_on_cooldown(tt) then
-				local secsleft 	= math.floor(travel_cooldown_remaining(tt)/6)
-				local minsleft 	= math.floor(secsleft / 60)
-				local hrsleft 	= math.floor(minsleft / 60)
-				secsleft 		= secsleft % 60
-
-				local h_and_m 	= (hrsleft > 0) and (minsleft > 0)
-				local m_and_s 	= (hrsleft == 0) and (minsleft > 0) and (secsleft > 0)
-				local showsecs 	= (hrsleft == 0) and (minsleft < 5) and (secsleft > 0)
-
-				local secst 	= " "..(((secsleft > 1) and gts("st_fft_seconds") or false) or gts("st_fft_second"))
-				local minst 	= " "..(((minsleft > 1) and gts("st_fft_minutes") or false) or gts("st_fft_minute"))
-				local hrst 		= " "..(((hrsleft > 1) and gts("st_fft_hours") or false) or gts("st_fft_hour"))
-
-				local hleft 	= (hrsleft > 0) and (tostring(hrsleft)..hrst) or ""
-				local mleft 	= (minsleft > 0) and (tostring(minsleft)..minst) or ""
-				local sleft 	= showsecs and (tostring(secsleft)..secst) or ""
-				local tleft 	= hleft..(h_and_m and ", " or "")..mleft..(showsecs and m_and_s and ", " or "")..sleft
-				local ttname 	= gts("ui_mcm_menu_"..tt.."cfg")
-				local notyet 	= sformat(gts("st_fftd_notyet"),ttname,tleft)
-				
-				set_menu_option(notyet, tt, false)
-				property_ui:AddItem(notyet)
-			else
-				local mapspot = generate_mapspot_text(id,level_name,tt)
-				--vl("generated mapspot %s",mapspot)
-				property_ui:AddItem(mapspot)
-			end
-		end
-	end
-	if is_backpack and allow_open_bp then
-		if (level.object_by_id(id)) then
-			property_ui:AddItem(gts("bp_open"))
-		end
-	end
-end
-
-
-function nearest_smart(levelid,target)
-	local smid_nearest,dist_nearest,name_nearest,pos_nearest,result
-	for name,smid in pairs(SIMBOARD.smarts_by_names) do
-		if levelid == gg():vertex(smid.m_game_vertex_id):level_id() then
-			local dist = smid.position:distance_to(target)
-			if (SIMBOARD.smarts[smid.id]) and (not smid_nearest or (dist < dist_nearest)) then
-				smid_nearest 	= smid
-				dist_nearest 	= dist
-				name_nearest 	= name
-				pos_nearest		= smid.position
-			end
-		end
-	end
-	result = {
-		smid 	= smid_nearest 	or 0,
-		dist 	= dist_nearest 	or 0,
-		name 	= name_nearest 	or "",
-		pos 	= pos_nearest 	or VEC_ZERO
-	}
-	vl("nearest_smart: %s at %s | %s, %s, %s",result.name,result.dist,result.pos.x,result.pos.y,result.pos.z)
-	return result
-end
-
-
-function global_distance_between(obj_or_pos1,lvid1,obj_or_pos2,lvid2)
-	return math.pow(
-		warfare.distance_to_xz_sqr(
-			global_position.from(obj_or_pos1,lvid1),
-			global_position.from(obj_or_pos2,lvid2)),
-		0.5)
-end
-
-
-function print_pos(pos)
-	if pos and (pos.x and pos.y and pos.z) then
-		return sformat("%s, %s, %s",pos.x,pos.y,pos.z)
-	end
-end
-
-
-function calc_distance_for(obj_or_pos, dest_level, using_guide, useoldcalcs)
-	local is_pos = print_pos(pos)
-	vl("calc_distance_for %s on %s",is_pos and "pos: "..is_pos or "obj",dest_level)
-	local dest,dest_pos,dest_lvl
-	local result = {
-			smid = nil,
-			dist = -1,
-			name = "",
-			erst = nil,
-	}
-	local actor_pos 	= db.actor:position()
-	local actor_lvl		= alife():level_id()
-	local level_name 	= level.name()
-	local using_guide 	= using_guide or false
-	local function se_obj_level_id(o)
-		return o and game_graph():vertex(o.m_game_vertex_id):level_id()
-	end
-	if obj_or_pos.position then
-		dest 		= obj_or_pos
-		dest_pos 	= obj_or_pos.position
-		dest_lvl 	= se_obj_level_id(obj_or_pos)
-	else
-		dest_pos 	= obj_or_pos
-		dest_lvl 	= level_id_for_name(dest_level)
-	end
-	
-	result.dist = actor_pos:distance_to(dest_pos)
-
-	if using_guide or not useoldcalcs then
-		local get_nearest = nearest_smart(actor_lvl,actor_pos)
-		result.dist = global_distance_between(actor_pos,actor_lvl,dest_pos,dest_lvl)
-	end
-	
-	return result
-end
-
-
-function distance_to_duration(tt,maploc,dist)
-	dl("distance_to_duration: tt %s | maploc %s | dist %s",tt,maploc,dist)
-	local ftdist 			= dist or 10
-	local ftdur				= 60
-	local fthours 			= 1
-	local ftmins 			= 0
-	local time_coef 		= td[tt][maploc].mpm or 10
-	--local pause_survival	= td[tt][maploc].pause_stats or false
-	local israndom 			= td[tt][maploc].rnd_enabled or false
-	local minrnd_m 			= td[tt][maploc].rnd_minutes_min or 0
-	local maxrnd_m 			= td[tt][maploc].rnd_minutes_max or 59
-	local minrnd_h 			= td[tt][maploc].rnd_hours_min or 0
-	local maxrnd_h 			= td[tt][maploc].rnd_hours_max or 1
-	ftdur = math.floor(ftdist / 100 * time_coef * skillspeed_coef)
-	fthours = math.floor(ftdur / 60)
-	ftmins = ftdur - (fthours * 60)
-
-	if israndom then
-		if maxrnd_m > minrnd_m then
-			ftmins = ftmins+math.random(minrnd_m,maxrnd_m)
-		end
-		if maxrnd_h > minrnd_h then
-			if ftmins > 60 then
-				fthours = fthours+math.random(minrnd_h,maxrnd_h)+1
-				ftmins = ftmins-60
-			else
-				fthours = fthours+math.random(minrnd_h,maxrnd_h)
-			end
-		end
-	end
-	local result =	{
-		t 	= ftdur,
-		h 	= fthours,
-		m 	= ftmins,
-	}
-	return result
-end
-
--- ======================================================================
--- Travel logic helper functions
--- ======================================================================
-
-function cancel_travel_message(error_string)
-	vl("Trip canceled, clearing trip in progress flag")
-	reset_trip_data()
-	actor_menu.set_msg(1, error_string,4)
-end
-
-function set_disguise_timer(on_or_off)
-	if ui_options.get("gameplay/disguise/state") and use_disguise_fix then
-		local after = on_or_off or false
-		if after then
-			gameplay_disguise.delet_memory()
-		end
-		local disguise_time = ui_options.get("gameplay/disguise/stay_time")
-		if disguise_time then
-			axr_main.config:w_value("options", "gameplay/disguise/stay_time", onoff)
-			gameplay_disguise.update_settings()
-		end
-	end
-end
-
-
-function damage_gear_condition(dist,gear_dmg_fac,debug_only)
-	if disable_gear_damage or (cond_damage_mode < 0) then return end
-	if ((dist or 0) <= 0) or ((gear_dmg_fac or 0) <= 0) then return end
-	local function adj_dmg(dmg,coef,min,max)
-		return clamp(math.floor(dmg * coef  * 100) / 1000,min or 0,max or 0.95)
-	end
-	local dist_coef		= dist / 10000
-	local base_dmg 		= math.sqrt(1 - math.pow(dist_coef - 1, 2)) / 2
-	local enc_dmg 		= base_dmg * enc_damage_mult
-	local enc_diff 		= db.actor:get_total_weight() - db.actor:get_actor_max_walk_weight() - (suit and suit:get_additional_max_weight() or 0) - bbp_extra_weight()
-	local pre_adj_dmg 	= base_dmg
-	if enc_diff > 0 then
-		vl("enc_diff is %s, actor is overburdened - adding %s to cond dmg",enc_diff,enc_dmg)
-		pre_adj_dmg 	= base_dmg + enc_dmg	
-	end
-	local cond_dmg 		= adj_dmg(pre_adj_dmg,gear_dmg_fac,0.001,0.95)
-	local slots_to_dmg = {
-		-- In case it's ever necessary to adjust damage on a per-slot basis
-		[1] 	= 1,
-		[2] 	= 1,
-		[3] 	= 1,
-		[7] 	= 1,
-		[12]	= 1,
-	}
-	if cond_damage_mode > 2 then
-		slots_to_dmg[7] = nil
-		slots_to_dmg[12] = nil
-	elseif cond_damage_mode > 1 then
-		slots_to_dmg[1] = nil
-		slots_to_dmg[2] = nil
-		slots_to_dmg[3] = nil
-	elseif cond_damage_mode > 0 then
-		empty_table(slots_to_dmg)
-		local r = math.floor(math.random(1,5))
-		if r == 4 then r = 7 end
-		if r == 5 then r = 12 end
-		slots_to_dmg[r] = 1
-	end
-	dl("Calculating gear condition damage: dist %s -> coef %s | gear_dmg_fac %s | base_dmg %s | enc_dmg %s | pre_adj %s | cond_dmg %s",dist,dist_coef,gear_dmg_fac,base_dmg,enc_dmg,pre_adj_dmg,cond_dmg)
-	if debug_only then return cond_dmg end
-
-	for s,slot_coef in pairs(slots_to_dmg) do
-		local itm = db.actor:item_in_slot(s)
-		if itm then
-			local itm_cond = itm:condition()
-			local cond_dmg_final = cond_dmg * slot_coef
-			local sec = itm:section()
-			itm:set_condition(itm_cond - cond_dmg_final)
-			vl("Item %s in slot %s condition: %s (%s - %s)",sec,s,itm:condition(),itm_cond,cond_dmg_final)
-		end
-	end
-	return cond_dmg_final
-end
-
-local satdiff = 0
-function pause_survival_stats(disable)
-	dl("pause_survival_stats called")
-	if disable == nil then
-		-- This should only be nil if pause_survival_stats is called by timeevent
-		UnregisterScriptCallback("actor_on_first_update", unpause_survival_stats)
-		survival_paused = false
-	end
-	local cond = db.actor:cast_Actor():conditions()
-	dl("pause_survival_stats: feature is %s, disable is %s",pause_survival,disable)
-	if disable then
-		survival_paused = true
-		stored_satiety = cond:GetSatiety()
-		dl("pause_survival_stats: storing current player satiety: %s",stored_satiety)
-	else
-		dl("pause_survival_stats: restoring cached player satiety loss")
-		local curr = cond:GetSatiety()
-		satdiff = stored_satiety - curr
-		dl("pause_survival_stats: current satiety is %s (stored %s, satdiff %s)",curr,stored_satiety,satdiff)
-		dl("pause_survival_stats: executing change")
-		db.actor.satiety = stored_satiety
-		dl("current satiety is now %s (stored %s)",cond:GetSatiety(),stored_satiety)
-		survival_paused = false
-		if db.actor and actor_status.HUD then actor_status.HUD:Update(true) end
-	end
-	return true
-end
-
-
-function get_trip_distance(dest_or_pos,level_name,using_guide,oldcalcs)
-	vl("get_trip_distance | dest_or_pos %s | level %s | guide %s | oldcalcs %s",dest_or_pos,level_name,using_guide,oldcalcs)
-	local distcalc = calc_distance_for(dest_or_pos,level_name,using_guide,oldcalcs)
-	vl("distance: %s",distcalc and distcalc.dist)
-	return distcalc
-end
-
-function advance_trip_time(tt,dist,mapchange,pause_survival)
-	dl("advance_trip_time called: tt = %s | dist %s | newmap %s | pause_stats %s",tt,dist,mapchange,pause_survival)
-	local maploc 	= mapchange and "map" or "loc"
-	local ftdur 	= distance_to_duration(tt,maploc,dist)
-	vl("Trip duration for %sm: %s mins",dist,ftdur.t)
-	if pause_survival == nil then
-		pause_survival = td[tt][maploc].pause_stats
-	end
-	if pause_survival then
-		pause_survival_stats(true)
-	end
-	
-	set_disguise_timer(false)
-	db.actor:set_can_be_harmed(false)
-	level.change_game_time(0,ftdur.h,ftdur.m)
-	db.actor:set_can_be_harmed(true)
-	set_disguise_timer(true)
-
-	if pause_survival and mapchange then
-		dl("Setting callback for level change to restore stats")
-		RegisterScriptCallback("actor_on_first_update",unpause_survival_stats)
-	elseif pause_survival then
-		dl("Creating timeevent to restore stats")
-		CreateTimeEvent("fast_travel_resync","fast_travel_resync",0,game_fast_travel.pause_survival_stats)
-	end
-
-	surge_manager.get_surge_manager().time_forwarded = true
-	psi_storm_manager.get_psi_storm_manager().time_forwarded = true
-	level_weathers.get_weather_manager():forced_weather_change()
-
-	return ftdur
-end
-
-function validate_dest_position(dest)
-	if not dest then return end
-	local pos = dest.position
-	if dest:clsid() == clsid.zone_campfire then
-		for k,v in pairs(campfire_dest_adj) do
-			pos[k] = pos[k] + v
-		end
-	end
-	return pos
-end
-
-function companions_travel_with_actor()
-	trip = trip or reset_trip_data()
-	local squad = squad_local_travel
-	if trip.nosquad ~= nil then
-		vl("squad_local_travel overridden by trip data: %s", trip.nosquad)
-		squad = not strbool(trip.nosquad)
-	end
-	vl("companions_travel_with_actor: %s", squad)
-	return squad
-end
-
-function bring_companions_to_actor(forced)
-	if not (forced or companions_travel_with_actor()) then return end
-	vl("bring_companions_to_actor (setting: %s)", companions_travel_with_actor())
-	local lvid_pos = level.vertex_position(db.actor:level_vertex_id())
-	for id,squad in pairs(axr_companions.companion_squads) do 
-		if squad.online == false then
-			squad:force_change_position(lvid_pos)
-		end
-
-		local npc
-		for k in squad:squad_members() do
-			if k.id then
-				npc = db.storage[k.id] and db.storage[k.id].object
-				local se_obj = alife_object(k.id)
-				local hostage = tp_ignores_hostages and se_obj and (se_load_var(se_obj.id, se_obj:name(), "companion_cannot_teleport"))
-				local following = tp_respects_waitfollow and npc and npc:dont_has_info("npcx_beh_wait") and true or false
-				if following and not hostage then 
-					if not (db.offline_objects[k.id]) then
-						db.offline_objects[k.id] = {}
-					end
-					db.offline_objects[k.id].level_vertex_id = level.vertex_id(lvid_pos)
-					if npc then
-						sim_squad_scripted.reset_animation(npc)
-						npc:set_npc_position(lvid_pos)
-					else
-						k.object.position = lvid_pos
-					end
-				end
-			end
-		end
-	end
-	return true
-end
-
--- ======================================================================
--- 	TRAVEL LOGIC HANDLING - BEGINS WITH MENU SELECTION
--- ======================================================================
-function map_spot_menu_property_clicked(property_ui,id,level_name,prop)
-	-- ============================================================
-	--	Initial sanity checks
-	-- ============================================================
-	local se_obj = id and (id > 0) and alife_object(id)
-	if not se_obj then return end
-	
-	if allow_open_bp and (prop == gts("bp_open")) then
-		dl("allow_open_bp is %s",allow_open_bp)
-		local b = level.object_by_id(id)
-		if (b) then
-			hide_hud_inventory()
-			b:use(db.actor)
-		end
-		return
-	end
-	if not (menu_options and menu_options[prop] and menu_options[prop].valid) then return end
-	dl("map_spot_menu_property_clicked: %s",prop)
-
-	-- ============================================================
-	--	Set up trip data, send/check on_try_fast_travel callback
-	-- ============================================================
-	reset_trip_data()
-	local tt 	= menu_options[prop].tt
-	trip.tt 	= tt
-	trip.id 	= id
-	trip.level 	= level_name
-	trip.text 	= prop
-	trip.cfg 	= dup_table(td[tt])
-
-	SendScriptCallback("on_try_fast_travel",trip)
-	if not trip.ret_value then
-		-- Another script wants to abort or handle this trip entirely
-		reset_trip_data()
-	return end
-
-	-- ============================================================
-	--	Core travel logic begins
-	-- ============================================================
-	if not trip.tt then return end
-	if tt ~= trip.tt then
-		-- Refresh trip config if travel type was changed
-		tt = trip.tt
-		trip.cfg 	= dup_table(td[trip.tt])
-	end
-
-	dl("Matched, checking preconditions")
-	
-	if not (
-			actor_in_travel_zone(trip.tt) and
-	 		combat_travel_ok(trip.tt) and
-			weight_travel_ok(trip.tt) and
-			damage_travel_ok(trip.tt) and
-			storm_travel_ok(trip.tt) and
-			guide_travel_ok(trip.tt)
-	) then return end
-
-	-- ============================================================
-	--	Determine distance, time, and cost
-	-- ============================================================
-	vl("Starting trip calculations")
-
-	
-	trip.started 	= true
-	trip.dest 		= se_obj
-	trip.dpos		= validate_dest_position(trip.dest or nil)
-	trip.apos 		= db.actor:position()
-	trip.dist 	 	= db.actor:position():distance_to(trip.dpos) -- default vanilla calc
-	trip.maploc 	= "loc"
-	trip.map_coef 	= get_map_hazard_coef(level.name(), trip.level) or 1
-	using_guide 	= trip.tt == "gt"
-	trip.faretxt 	= "st_fftd_farepaid_noguide"
-	local payfare 	= false
-	local mapchange = (level_name ~= level.name())
-	if mapchange then
-		trip.maploc = "map"
-	end
-	local distcalc	= get_trip_distance(trip.dpos,level_name,using_guide,trip.cfg[trip.maploc].useoldcalcs)
-	trip.dist 		= distcalc.dist	
-	vl("dist %s | tt %s | maploc %s | using_guide %s",trip.dist,trip.tt,trip.maploc,using_guide)
-
-	if using_guide then
-		if (trip.dist < 0) then
-			hide_hud_pda()
-			cancel_travel_message(distcalc.erst)
-			return
-		end
-		trip.faretxt = "st_fftd_farepaid_guide"
-	end
-	if travel_cost_coef(trip.tt) > 0 then
-		trip.cost = cost_to_travel(trip.dist, trip.tt, false, trip.map_coef) or 100
-		dl("clicked: dist: %s cost: %s",trip.dist,trip.cost)
-		if (db.actor:money() < trip.cost) then
-			hide_hud_pda()
-			cancel_travel_message(gts(err_toopoor))
-			return
-		else
-			payfare = true
-		end
-	end
-
-	-- ============================================================
-	--	Time and location change
-	-- ============================================================
-	SendScriptCallback("on_before_fast_travel", trip)
-	if not trip.ret_value then
-		dl("Another script set ret_value to false during on_before_fast_travel, aborting")
-		reset_trip_data()
-	return end	
-
-	if payfare and not trip.paid then
-		charge_for_travel(trip.cost)
-	end
-	-- forward time when traveling
-	trip.notime = trip.notime or basecfg[trip.tt].notime
-	if not trip.notime then
-		dl("game_fast_travel - notime is false, begin calculating trip duration")
-		local pause_survival = trip.cfg[trip.maploc].pause_stats and true or false
-		advance_trip_time(trip.tt,trip.dist,mapchange,pause_survival)
-	end
-
-	if travel_cooldown_enabled(trip.tt) then update_travel_cooldown(trip.tt) end
-	local gdf = trip.cfg[trip.maploc].gear_dmg or 0
-	damage_gear_condition(trip.dist,gdf)
-	--debug_dump_trip_data()
-
-	hide_pda()
-	if (trip.dest.online) then
-		db.actor:set_actor_position(trip.dpos)
-		CreateTimeEvent("fast_travel", "local_companion_travel", 0, game_fast_travel.bring_companions_to_actor)
-	else
-		ChangeLevel(trip.dpos, trip.dest.m_level_vertex_id, trip.dest.m_game_vertex_id, VEC_Z, true)
-	end
-	dl("Trip complete, clearing trip in progress flag")
-	reset_trip_data()
-	return true
-end
-
--- ======================================================================
--- Callbacks and misc system functions
--- ======================================================================
-
-function update_mcm()
-	if not ui_mcm then return end
-	
-	printf("[FFT] Loading settings from MCM - warnings about invalid paths are harmless and expected, ignore")
-	-- Nil values occur because I'm looping through all_travel_types to 
-	-- pull all the MCM settings, but not all settings exist for all
-	-- travel types - this is 100% harmless
-	progressive_cost 	= get_mcm("fftd/gen/progressive_cost", progressive_cost)
-	prog_coef_max 		= tonumber(get_mcm("fftd/gen/prog_coef_max", prog_coef_max))
-	prog_rank_cap 		= tonumber(get_mcm("fftd/gen/prog_rank_cap", prog_rank_cap))
-	nice_round_numbers  = get_mcm("fftd/gen/nice_round_numbers", nice_round_numbers)
-	show_dist_and_dur  	= get_mcm("fftd/gen/show_distdur", show_dist_and_dur)
-	gate_northern_travel= get_mcm("fftd/gen/northgate", gate_northern_travel)
-	force_vanilla_fares = get_mcm("fftd/gen/force_vanilla_fares", force_vanilla_fares)
-	skillsystem_enabled = get_mcm("fftd/gen/skillsystem_enabled", skillsystem_enabled)
-	shared_ft_cooldown 	= get_mcm("fftd/gen/shared_cooldown", shared_ft_cooldown)
-	npc_combat_dist 	= tonumber(get_mcm("fftd/gen/combat_dist", npc_combat_dist))
-	npc_combat_timeout 	= tonumber(get_mcm("fftd/gen/combat_timeout", npc_combat_timeout))
-	allow_debug_travel 	= get_mcm("fftd/gen/allow_debug_travel", allow_debug_travel)
-	allow_open_bp 		= get_mcm("fftd/gen/allow_open_bp", allow_open_bp)
-	use_warfare_fix 	= get_mcm("fftd/gen/use_warfare_fix", use_warfare_fix)
-	use_disguise_fix 	= get_mcm("fftd/gen/use_disguise_fix", use_disguise_fix)
-	use_vanilla_calcs 	= get_mcm("fftd/gen/use_vanilla_calcs", use_vanilla_calcs)
-	zones_use_disguises = get_mcm("fftd/gen/zones_use_disguises", zones_use_disguises)
-	squad_local_travel 	= get_mcm("fftd/gen/squad_local_travel", squad_local_travel)
-	squad_tp_bind  		= get_mcm("fftd/gen/squad_tp_bind", squad_tp_bind)
-	squad_tp_mod  		= get_mcm("fftd/gen/squad_tp_mod", squad_tp_mod)
-	psyblock_mapspots  	= get_mcm("fftd/gen/psyblock_mapspots", psyblock_mapspots)
-	use_map_hazard_coef = get_mcm("fftd/gen/use_map_hazard_coef", use_map_hazard_coef)
-	local ti 			= ui_mcm.get("fftd/gen/tick_interval")
-	if ti and (type(ti) == "number") and ti > 0 then
-		tick_int 		= ti
-	end
-	cond_damage_mode	= tonumber(get_mcm("fftd/gen/cond_dmg_mode", cond_damage_mode))
-	minimum_health 		= clamp(tonumber(get_mcm("fftd/gen/minimum_health", minimum_health)), 0, 1)
-	minimum_satiety		= clamp(tonumber(get_mcm("fftd/gen/minimum_satiety", minimum_satiety)), 0, 1)
-	debuglogs 			= get_mcm("fftd/gen/debuglogs_enabled", debuglogs)
-	verbose 			= get_mcm("fftd/gen/verbose_enabled", verbose)
-	if game_guide_travel then
-		game_guide_travel.debuglogs = debuglogs
-		game_guide_travel.verbose = verbose
-	end
-
-	for tt,en in pairs(all_travel_types) do
-		if en then
-			for maploc,defs in pairs(td[tt]) do
-				vl("maploc %s | defs %s | tt %s",maploc,defs,tt)
-				if type(defs) == "table" then
-					for var,_ in pairs(defs) do
-						local mcmpath = ""
-						if maploc == "cfg" then
-							mcmpath = "fftd/"..tt.."cfg/"..var
-						else
-							mcmpath = "fftd/"..tt.."cfg/"..maploc..var
-						end
-						local val = ui_mcm.get(mcmpath)
-						vl("Setting td["..tt.."]["..maploc.."]."..var.." to "..mcmpath..": %s",val)
-						td[tt][maploc][var] = val
-					end
-				end
-			end
-		end
-	end
-	basecfg["ft"].enabled 	= td["ft"]["cfg"].enabled
-	local gtcfg 			= td["gt"]["cfg"]
-	basecfg["gt"].enabled 	= gtcfg.enabled
-	
-	basecfg["gt"].damage 	= gtcfg.ignore_status
-	basecfg["gt"].weight 	= gtcfg.ignore_status
-	guide_npc_cost_coef		= ui_mcm.get("fftd/gtcfg/npc_cost_coef") or guide_npc_cost_coef
-
-	if use_skillsystem() then
-		skillspeed_coef = dec2(1 / haru_skills.skills_stats["endurance"].speed_modifier)
-		dl("skillsystem Skill System found, travel time modifier: %s",skillspeed_coef)
-	else
-		dl("skillsystem Skill System not used, travel time modifier defaulting to %s",skillspeed_coef)
-	end
-	td = travel_data
-	ui_mcm.set("fftd/version",script_version)
-end
-
-function actor_on_interaction(typ, obj, name)
--- Used for Visit_Only mode, catches the player near the marker and updates things.
--- Largely inherited from the vanilla fast travel script, with modifications
-	if 	(basecfg["ft"].state ~= 1) or 
-		(use_warfare_fix and IsWarfare()) or
-		(typ ~= "smarts") or
-		(not (tsmarts[name])) then
-		return
-	end
-
-	if (level.map_has_object_spot(obj.id, "fast_travel") == 0) then
-		local hint = gts(name)
-		local prefix = ""
-		local mid = longnames and ":" or ""
-		if longnames then
-			local smart = alife():object(obj.id)
-			local level_name = alife():level_name(smart and gg():vertex(smart.m_game_vertex_id):level_id())
-			prefix = gts(level_name)
-			hint = " "..hint
-		end
-		level.map_add_object_spot(obj.id, "fast_travel", prefix..hint)
-		if markermessage then
-			actor_menu.set_msg(1, prefix..mid..hint.." "..gts("st_fast_travel_discovered"), 4)
-			locations_found = (locations_found or 0) + 1
-			vl("New fast travel location %s found, total known: %s", name, locations_found)
-			SendScriptCallback("on_new_fast_travel_point", obj.id, hint)
-		end
-	end
-end
-
-function set_disguise_timer(on_or_off)
-	if ui_options.get("gameplay/disguise/state") and use_disguise_fix then
-		local after = on_or_off or false
-		if after then
-			gameplay_disguise.delet_memory()
-		end
-		local disguise_time = ui_options.get("gameplay/disguise/stay_time")
-		if disguise_time then
-			axr_main.config:w_value("options", "gameplay/disguise/stay_time", onoff)
-			gameplay_disguise.update_settings()
-		end
-	end
-end
-
-function set_travel_point_mapspot(id, mapspot, hint)
-	if not id then return end
-	if mapspot and has_mapspot(id, mapspot) then
-		remove_mapspot(id, mapspot)
-	end
-	if has_mapspot(id, travel_mapspot) then
-		remove_mapspot(id, travel_mapspot)
-	end
-    if not mapspot then return end
-	add_mapspot(id, mapspot, hint or "")
-end
-
-function get_travel_spot_name(smart)
-	local prefix = ""
-	local smartname = smart and gts(smart:name()) or ""
-	if smart and longnames then
-		local level_name = alife():level_name(gg():vertex(smart.m_game_vertex_id):level_id())
-		prefix = gts(level_name) .. " "
-	end
-	return prefix .. smartname
-end
-
-function update_travel_markers()
-	if not db.actor then return end
-	
+			level.map_add_object_spot(obj.id, "fast_travel", game.translate_string(name))
+			if (markermessage) then
+				actor_menu.set_msg(1, game.translate_string(name).." "..game.translate_string("st_fast_travel_discovered"), 4)
+			end
+		end
+	end
+end
+
+local st_list_1 = game.translate_string("ui_mm_travel_list_1")
+function update_settings()
+	enabled = ui_options.get("gameplay/fast_travel/state")
+	combattravel = ui_options.get("gameplay/fast_travel/on_combat")
+	weighttravel = ui_options.get("gameplay/fast_travel/on_overweight")
+	damagetravel = ui_options.get("gameplay/fast_travel/on_damage")
+	stormtravel = ui_options.get("gameplay/fast_travel/on_emission")
+	longnames = ui_options.get("gameplay/fast_travel/long_names")
+	markermessage = ui_options.get("gameplay/fast_travel/visit_message")
+	notime = ui_options.get("gameplay/fast_travel/time")
+
 	local faction = character_community(db.actor):sub(7)
 	local pini = ini_file("plugins\\faction_quick_travel.ltx")
 	tsmarts = utils_data.collect_section(pini,faction,true)
-	locations_found = 0
+
 	if not (is_empty(tsmarts)) then
-		xml:ParseFile("fft_ui_elements.xml")
 		local level_name
-		local curr_lvl = level.name()
-		local not_warfare = not (use_warfare_fix and IsWarfare())
-		for id = 1,65534 do
-			local smart = alife():object(id)
-			local smartname = smart and smart:name()
-			if not_warfare and (smart and smart:clsid() == clsid.smart_terrain and smartname and tsmarts[smartname]) then
-				set_travel_point_mapspot(id)
-				local level_name = alife():level_name(gg():vertex(smart.m_game_vertex_id):level_id())
-				local ftstate = basecfg["ft"].state
-				local visited = (game_statistics.has_actor_visited_smart(smartname) == true)
-				if (ftstate == 2) or (visited and (ftstate == 1)) then
-					local hint = get_travel_spot_name(smart)
-					set_travel_point_mapspot(id, travel_mapspot, hint)
-					if psyblock_mapspots and scorcher_blocks_travel(curr_lvl, level_name) then
-						change_mapspot_texture(id, travel_mapspot, mapspot_texture_psy, color_dimmed, nil, 15, 20)
+		local sim,gg = alife(),game_graph()
+		for i=1,65534 do
+			local smart = sim:object(i)
+			if (smart and smart:clsid() == clsid.smart_terrain and tsmarts[smart:name()]) then
+				if (level.map_has_object_spot(i, "fast_travel")) then
+					level.map_remove_object_spot(i, "fast_travel")
+				end
+				if not IsWarfare() then
+					if (enabled == 1) then
+						if (game_statistics.has_actor_visited_smart(smart:name()) == true) then
+							if (longnames) then
+								level_name = sim:level_name(smart and gg:vertex(smart.m_game_vertex_id):level_id())
+								level.map_add_object_spot(i, "fast_travel", game.translate_string(level_name).." "..game.translate_string(smart:name()))
+							else
+								level.map_add_object_spot(i, "fast_travel", game.translate_string(smart:name()))
+							end
+						end
+					elseif (enabled == 2) then
+						if (longnames) then
+							level_name = sim:level_name(smart and gg:vertex(smart.m_game_vertex_id):level_id())
+							level.map_add_object_spot(i, "fast_travel", game.translate_string(level_name).." "..game.translate_string(smart:name()))
+						else
+							level.map_add_object_spot(i, "fast_travel", game.translate_string(smart:name()))
+						end
 					end
-					locations_found = locations_found + 1
-					vl("Added travel point mapspot %s for: %s (%s) | %s | total known: %s", travel_mapspot, smartname, id, hint, locations_found)
 				end
 			end
 		end
 	end
-end
-
-function update_settings()
-	basecfg["ft"].state 	= ui_options.get("gameplay/fast_travel/state")
-	basecfg["ft"].combat 	= ui_options.get("gameplay/fast_travel/on_combat")
-	basecfg["ft"].weight 	= ui_options.get("gameplay/fast_travel/on_overweight")
-	basecfg["ft"].damage 	= ui_options.get("gameplay/fast_travel/on_damage")
-	basecfg["ft"].storm 	= ui_options.get("gameplay/fast_travel/on_emission")
-	basecfg["ft"].notime 	= ui_options.get("gameplay/fast_travel/time")
-	basecfg["bp"].enabled 	= ui_options.get("gameplay/backpack_travel/state")
-	basecfg["bp"].combat 	= ui_options.get("gameplay/backpack_travel/on_combat")
-	basecfg["bp"].weight 	= ui_options.get("gameplay/backpack_travel/on_overweight")
-	basecfg["bp"].damage 	= ui_options.get("gameplay/backpack_travel/on_damage")
-	basecfg["bp"].storm 	= ui_options.get("gameplay/backpack_travel/on_emission")
-	basecfg["bp"].notime 	= ui_options.get("gameplay/backpack_travel/time")
-	basecfg["gt"].combat 	= ui_options.get("gameplay/fast_travel/on_combat")
-	basecfg["gt"].storm 	= ui_options.get("gameplay/fast_travel/on_emission")
-	basecfg["gt"].notime 	= ui_options.get("gameplay/fast_travel/time")
-	longnames 				= ui_options.get("gameplay/fast_travel/long_names")
-	markermessage 			= ui_options.get("gameplay/fast_travel/visit_message")
-	-- Override defaults with config values from MCM, if applicable
-	update_mcm()
-	update_travel_markers()
 	return true
-end
-
-
-function unpause_survival_stats()
-	dl("Unregistering callback and restoring survival stats")
-	pause_survival_stats(false)
-end
-
-
-function load_file_data()
-	local filepath = "game.ltx"
-	dl("Loading game level data")
-	local game_ini = ini_file_ex(filepath)
-	local lvl_secs = game_ini:collect_section("levels")
-	for k,_ in pairs(lvl_secs) do
-		local lid = game_ini:collect_section(k)
-		level_ids[lid.name] = tonumber(lid.id)
-		--vl("level_id for %s: %s", lid.name, level_ids[lid.name])
-	end
-
-	dl("Loading fast travel configuration")
-	filepath = "scripts\\fast_travel\\travel_settings.ltx"
-	local ftcfg_ini = ini_file_ex(filepath)
-	assert(ftcfg_ini,
-	    string.format("\n! ERROR: Could not load %s!\n", filepath)
-	)
-	all_travel_types = ftcfg_ini:collect_section("travel_types")
-	local function get_cfg_data(sec)
-		local ltx = ftcfg_ini:collect_section(sec)
-		for k,v in pairs(ltx) do
-			local ltd = tonumber(v)
-			if ltd then
-				ltx[k] = ltd
-			else
-				ltx[k] = strbool(v)
-			end
-		end
-		return ltx
-	end
-	if not travel_data then travel_data = {} end
-	for k,_ in pairs(all_travel_types) do
-		if not travel_data[k] then travel_data[k] = {} end
-		travel_data[k]["cfg"] = get_cfg_data(k .. "cfg")
-		travel_data[k]["loc"] = get_cfg_data(k .. "loc")
-		travel_data[k]["map"] = get_cfg_data(k .. "map")
-	end
-	td = travel_data
-
-	local cfg_tbl = get_cfg_data("feature_flags")
-	for k,v in pairs(cfg_tbl) do
-		this[k] = v
-	end
-
-	cfg_tbl = ftcfg_ini:collect_section("string_defs")
-	for k,v in pairs(cfg_tbl) do
-		this[k] = v
-	end
-	travel_zone_section = using_modded_exes and travel_zone_section or "space_restrictor"
-
-	dl("Loading destination data")
-	filepath = "scripts\\fast_travel\\travel_destinations.ltx"
-	local dest_ini = ini_file_ex(filepath)
-	assert(dest_ini,
-	    string.format("\n! ERROR: Could not load %s!\n", filepath)
-	)
-	if game_guide_travel then
-		game_guide_travel.levels_by_guidespot_name = dest_ini:collect_section("levels_by_guidespot")
-	end
-	
-	dl("Loading northern maps")
-	northern_maps = dest_ini:collect_section("northern_maps") or {}
-	for k,v in pairs(northern_maps) do
-		v = strbool(v) and true or false
-		if v then vl(k) end
-	end
-
-	dl("Loading guide ignored levels")
-	local ignored_lvls = dest_ini:collect_section("guide_ignored_levels")
-	if not guide_ignored_levels then guide_ignored_levels = {} end
-	for k,_ in pairs(ignored_lvls) do
-		guide_ignored_levels[k] = true
-	end
-
-	dl("Loading map hazard coefs")
-	local map_hazards = dest_ini:collect_section("map_hazard_coefs")
-	if not map_hazard_coefs then map_hazard_coefs = {} end
-	for k,v in pairs(map_hazards) do
-		map_hazard_coefs[k] = tonumber(v)
-	end	
-
-	dl("Loading travel zones")
-	filepath = "scripts\\fast_travel\\travel_zones.ltx"
-	local ftzones_ini = ini_file_ex(filepath)
-	assert(ftzones_ini,
-	    string.format("\n! ERROR: Could not load %s!\n", filepath)
-	)
-	local ftzones_ltx = ftzones_ini:get_sections(true)
-	for k,_ in pairs(ftzones_ltx) do
-		local ftz = ftzones_ini:collect_section(k)
-		fast_travel_restrictors[k] = {
-			default_owner = ftz.owner,
-			smart = ftz.smart,
-			zones = {}
-		}
-		local znum = ftz.zones or 1
-		for i = 1,znum do
-	        fast_travel_restrictors[k].zones[i] = str_explode(ftz["zone"..i],",")
-	        local zone = fast_travel_restrictors[k].zones[i]
-	        for z = 1,#zone do
-	        	zone[z] = tonumber(zone[z])
-	        end
-        end
-    end
-end
-
-function spawn_fast_travel_zones(respawn)
-	if respawn and not is_empty(spawned_travel_zones) then
-		zone_spawn_version = nil
-		disable_info("fft_restrictors_spawned")
-		for k,v in pairs(spawned_travel_zones) do
-			alife_release_id(v.id)
-		end
-		spawned_travel_zones = {}
-	end
-
-    for k,v in pairs(fast_travel_restrictors) do
-        dl("Spawning Fast Travel restrictor zones for %s",k)
-        for i = 1, #v.zones do
-            local zone = v.zones[i]
-            local pos = vector():set(zone[1] or 0, zone[2] or 0, zone[3] or 0)
-            local se_obj = alife_create(travel_zone_section, pos, zone[4] or 0, zone[5] or 0)
-            if se_obj then
-            	if zone[9] then
-            		se_obj.angle = vector():set(0, zone[9], 0)
-            	end
-                local data = utils_stpk.get_space_restrictor_data(se_obj)
-                if data then
-		        	local size = {
-		            	x = zone[6] or 0,
-		            	y = zone[7] or 0,
-		            	z = zone[8] or 0,
-		        	}
-		            local off = {
-		            	x = zone[10] or 0,
-		            	y = zone[11] or 0,
-		            	z = zone[12] or 0,
-		        	}
-                    data.shapes = {}
-                    data.shapes[1] = {}
-                    data.shapes[1].shtype   = 1
-                    data.shapes[1].v1       = vector():set(size.x, 0, 0)
-                    data.shapes[1].v2       = vector():set(0, size.y, 0)
-                    data.shapes[1].v3       = vector():set(0, 0, size.z)
-                    data.shapes[1].offset   = vector():set(off.x, off.y, off.z)
-					data.owners 			= v.owners                    
-                    data.default_owner      = v.default_owner
-                    data.smart        = v.smart
-                end
-                utils_stpk.set_space_restrictor_data(data, se_obj)
-                local id = se_obj.id
-                local name = se_obj:name()
-                spawned_travel_zones[name] = {
-                	id 	= id,
-                	loc = k
-                }
-                vl("Spawned restrictor %s (%s) for %s at %s,%s,%s",name,id,k,zone[1],zone[2],zone[3])
-            else
-                dl("ERROR - failed to spawn %s %s for %s",travel_zone_section,i,k)
-            end
-        end
-    end
-    give_info("fft_restrictors_spawned")
-    zone_spawn_version = release_date
-end
-
-
-function actor_on_first_update()
-	update_settings()
-	local outdated = ((zone_spawn_version or 0) < release_date)
-	if outdated or not has_alife_info("fft_restrictors_spawned") then
-		spawn_fast_travel_zones(outdated)
-   	end
-   	if actor_status_travelzone then
-   		actor_status_travelzone.sync_travel_types()
-   	end
-end
-
-
-function actor_on_update()
-	local now = time_global()
-	if next_tick > now then return end
-	next_tick = now + tick_int
-	actor_in_recent_combat()
-	if skillsystem_started or
-		(not skillsystem_enabled) or
-		(not skillsystem_exists) then
-	return end
-
-	if skillsystem_exists and not skillsystem_started then
-		local sl = haru_skills and haru_skills.skills_levels
-		local sn = haruka_skill_name or "endurance"
-		local end_lvl = sl and sl[sn] and sl[sn].current_level
-		skillsystem_started = end_lvl ~= nil
-	end
-end
-
-
-function load_state(data)
-    if not data.fast_travel_system then return end
-    dl("load_state: Loading saved state")
-
-    local fts = data.fast_travel_system
-    if fts then
-    	vl("Saved data is from v%s (%s)", fts.last_version, fts.last_release)
-    	spawned_travel_zones = fts.spawned_travel_zones or spawned_travel_zones
-    	zone_spawn_version = fts.zone_spawn_version or zone_spawn_version
-    	survival_paused = fts.survival_paused
-    	locations_found = fts.locations_found
-    	for tt,_ in pairs(all_travel_types) do
-    		td[tt].next_travel = fts.cooldowns and fts.cooldowns[tt] or 0
-    	end
-    end
-    if survival_paused then
-    	dl("Fast travel to new map in progress, survival stats will be restored on load")
-    	stored_satiety = fts.stored_satiety
-    	RegisterScriptCallback("actor_on_first_update", unpause_survival_stats)
-    end
-end
-
-
-function save_state(data)
-    data.fast_travel_system = {}
-    local fts = data.fast_travel_system
-    fts.spawned_travel_zones = spawned_travel_zones
-    fts.zone_spawn_version = zone_spawn_version
-    fts.survival_paused = survival_paused and true or false
-    fts.last_version = script_version
-    fts.last_release = release_date
-    fts.stored_satiety = stored_satiety
-    fts.locations_found = locations_found
-    fts.cooldowns = {}
-    for tt,_ in pairs(all_travel_types) do
-    	fts.cooldowns[tt] = td[tt].next_travel or 0
-    end
-end
-
-
-function on_game_load()
-	load_file_data()
-end
-
-function actor_on_stash_create(stash)
-	if not stash then return end
-	set_stash_hint(stash.stash_id, stash.stash_name)
-end
-
-local function mod_key_pressed(key)
-    if ui_mcm then
-        return ui_mcm.get_mod_key(key)
-    end
-end
-
-function on_key_release(key)
-    if (key == squad_tp_bind) and ui_mcm.get_mod_key(squad_tp_mod) then
-    	bring_companions_to_actor(true)
-    end
 end
 
 function on_game_start()
 	RegisterScriptCallback("map_spot_menu_add_property",map_spot_menu_add_property)
 	RegisterScriptCallback("map_spot_menu_property_clicked",map_spot_menu_property_clicked)
-	RegisterScriptCallback("on_game_load",on_game_load)
-	RegisterScriptCallback("save_state",save_state)
-	RegisterScriptCallback("load_state",load_state)
+	RegisterScriptCallback("on_game_load",update_settings)
 	RegisterScriptCallback("on_option_change",update_settings)
 	RegisterScriptCallback("actor_on_interaction", actor_on_interaction)
-	RegisterScriptCallback("actor_on_first_update", actor_on_first_update)
-	RegisterScriptCallback("actor_on_update", actor_on_update)
-	RegisterScriptCallback("actor_on_stash_create",actor_on_stash_create)
-	RegisterScriptCallback("on_key_release", on_key_release)
-end
+end
```
### game_relations.script
```diff
--- /workspace/G.A.M.M.A.-Warfare-Fix-Rewrite/runtime files/gamedata/scripts/game_relations.script

+++ /workspace/G.A.M.M.A.-Warfare-Fix-Rewrite/old walo/gamedata/scripts/game_relations.script

@@ -5,8 +5,7 @@

 	DoctorX Dynamic Faction Relations 1.8
 
 	Modified by: DoctorX, av661194
-        Last revised: February 16, 2016
-        2025/07/25 - Codex Fixer - corrected Windows path escape sequences
+	Last revised: February 16, 2016
 
  ============================================================
 
@@ -27,34 +26,9 @@

 --]]
 
 
-function safe_ini_r_float(ini, section, key, fallback)
-        if ini and ini:section_exist(section) and ini:line_exist(section, key) then
-                return ini:r_float(section, key)
-        else
-                return fallback
-        end
-end
-
-function safe_ini_r_s32(ini, section, key, fallback)
-        if ini and ini:section_exist(section) and ini:line_exist(section, key) then
-                return ini:r_s32(section, key)
-        else
-                return fallback
-        end
-end
 --========================================< Controls >========================================--
-local ini_r
-if system_ini():section_exist("plugins\\dynamic_faction_relations") then -- added escape fix
-        ini_r = ini_file("plugins\\dynamic_faction_relations.ltx")
-else
-        printf("[game_relations.script] WARNING: Missing dynamic_faction_relations.ltx")
-end
-local ini_g
-if system_ini():section_exist("creatures\\game_relations") then -- added escape fix
-        ini_g = ini_file("creatures\\game_relations.ltx")
-else
-        printf("[game_relations.script] WARNING: Missing game_relations.ltx")
-end
+local ini_r = ini_file("plugins\\dynamic_faction_relations.ltx")
+local ini_g = ini_file("creatures\\game_relations.ltx")
 factions_table = {"stalker","bandit","csky","dolg","freedom","killer","army","ecolog","monolith","renegade","greh","isg"}
 factions_table_all = {"actor","bandit","dolg","ecolog","freedom","killer","army","monolith","monster","stalker","zombied","csky","renegade","greh","isg","trader","actor_stalker","actor_bandit","actor_dolg","actor_freedom","actor_csky","actor_ecolog","actor_killer","actor_army","actor_monolith","actor_renegade","actor_greh","actor_isg","actor_zombied","arena_enemy"}
 -- ATTENTION! (factions_table_all) table must follow the same order of [communities_relations] section in game_relations.ltx file
@@ -153,14 +127,13 @@

 		return false
 	end
 	
-       for i=1,#blacklist_pair do
-               local pair = blacklist_pair[i]
-                if (pair[1] == fac1) and (pair[2] == fac2) then
-                        return true
-                elseif (pair[2] == fac1) and (pair[1] == fac2) then
-                        return true
-                end
-        end
+	for i=1,#blacklist_pair do
+		if (blacklist_pair[i][1] == fac1) and (blacklist_pair[i][2] == fac2) then
+			return true
+		elseif (blacklist_pair[i][2] == fac1) and (blacklist_pair[i][1] == fac2) then
+			return true
+		end
+	end
 	return false
 end
 
@@ -189,14 +162,13 @@

 	end
 	
 	-- Check blacklisted pairs 
-       for i = 1, #blacklist_pair do
-               local pair = blacklist_pair[i]
-                if (pair[1] == faction_1) and (pair[2] == faction_2) then
-                        return false
-                elseif (pair[2] == faction_1) and (pair[1] == faction_2) then
-                        return false
-                end
-        end
+	for i = 1, #blacklist_pair do
+		if (blacklist_pair[i][1] == faction_1) and (blacklist_pair[i][2] == faction_2) then
+			return false
+		elseif (blacklist_pair[i][2] == faction_1) and (blacklist_pair[i][1] == faction_2) then
+			return false
+		end
+	end
 	
 	return true
 end
@@ -309,20 +281,17 @@

 
 function reset_all_relations()
 	local tbl = {}
-       for i=1, #factions_table_all do
-               local faction = factions_table_all[i]
-               local value = ini_g:r_string_ex("communities_relations" , faction)
-               tbl[faction] = str_explode(value,",")
-       end
-
-       for i=1,#factions_table_all do
-               local faction_i = factions_table_all[i]
-               for j=1,#factions_table_all do
-                       local faction_j = factions_table_all[j]
-                       set_factions_community_num( faction_i , faction_j , tonumber(tbl[faction_i][j]) )
-                       --printf("TRX - " .. faction_i .. " + " .. faction_j .. " = " .. tonumber(tbl[faction_i][j]))
-               end
-       end
+	for i=1, #factions_table_all do
+		local value = ini_g:r_string_ex("communities_relations" , factions_table_all[i])
+		tbl[factions_table_all[i]] = str_explode(value,",")
+	end
+	
+	for i=1,#factions_table_all do
+		for j=1,#factions_table_all do
+			set_factions_community_num( factions_table_all[i] , factions_table_all[j] , tonumber(tbl[factions_table_all[i]][j]) )
+			--printf("TRX - " .. factions_table_all[i] .. " + " .. factions_table_all[j] .. " = " .. tonumber(tbl[factions_table_all[i]][j]))
+		end
+	end
 end
 
 function calculate_relation_change( victim_tbl, killer_tbl)
@@ -360,19 +329,18 @@

 	local enemy_num = 0
 	local natural_num = 0
 	local friend_num = 0
-       for i=1,#factions_table do
-               local faction = factions_table[i]
-               if (victim_faction ~= faction) then
-                       local rel = get_factions_community( victim_faction , faction )
-                       if (rel <= -1000) then
-                               enemy_num = enemy_num + 1
-                       elseif (rel > -1000) and (rel < 1000) then
-                                natural_num = natural_num + 1
-                        elseif (rel >= 1000) then -- fixed logic irrationality
-                                friend_num = friend_num + 1
-                        end
-                end
-        end
+	for i=1,#factions_table do
+		if (victim_faction ~= factions_table[i]) then
+			local rel = get_factions_community( victim_faction , factions_table[i] )
+			if (rel <= -1000) then
+				enemy_num = enemy_num + 1
+			elseif (rel > -1000) and (rel < 1000) then
+				natural_num = natural_num + 1
+			elseif (rel > -1000) and (rel < 1000) then
+				friend_num = friend_num + 1
+			end
+		end
+	end
 	
 	-- return if killer and victim are from the same faction
 	if (killer_faction == victim_faction) then
@@ -381,10 +349,9 @@

 
 	-- If killed NPC was enemy of faction, raise relation toward killer faction:
 	if ( math.random( 100 ) > 50 ) then
-               for i = 1, #factions_table do
-                       local faction = factions_table[i]
-                       if ( faction ~= killer_faction ) then
-                                if ( is_factions_enemies( faction, victim_faction ) ) then
+		for i = 1, #factions_table do
+			if ( factions_table[i] ~= killer_faction ) then
+				if ( is_factions_enemies( factions_table[i], victim_faction ) ) then
 					if ( math.random( 100 ) > 50 ) then -- random faction picker
 						
 						-- Relation calculation:
@@ -403,8 +370,8 @@

 						
 						local value = math.floor( death_value * ( v_rank + ( k_rank / 5 ) ) * ( v_rep_bad + ( k_rep_good / 10 ) ) )
 						
-                                                if is_relation_allowed( faction , killer_faction ) and ( natural_num + friend_num > friend_count_limit ) then
-                                                        change_faction_relations( faction, killer_faction, value )
+						if is_relation_allowed( factions_table[i] , killer_faction ) and ( natural_num + friend_num > friend_count_limit ) then
+							change_faction_relations( factions_table[i], killer_faction, value )
 							--printf("- Relations: Relations positive change | " .. factions_table[i] .. " <-> " .. killer_faction .. " relation change = " .. value)
 						else
 							--printf("% Relations: Relations change | " .. factions_table[i] .. " <-> " .. killer_faction .. " relation can't be changed!")
@@ -421,10 +388,9 @@

 
 	-- If killed NPC was friend or neutral to faction, lower relation toward killer faction:
 	else
-               for i = 1, #factions_table do
-                       local faction = factions_table[i]
-                       if ( faction ~= killer_faction ) then
-                                if ( not is_factions_enemies( faction, victim_faction ) ) then
+		for i = 1, #factions_table do
+			if ( factions_table[i] ~= killer_faction ) then
+				if ( not is_factions_enemies( factions_table[i], victim_faction ) ) then
 					if ( math.random( 100 ) > 50 ) then -- random faction picker
 					
 						-- Relation calculation:
@@ -443,8 +409,8 @@

 						
 						local value = math.floor( death_value * ( v_rank + ( k_rank / 5 ) ) * ( v_rep_good + ( k_rep_bad / 10 ) ) )
 
-                                                if is_relation_allowed( faction , killer_faction ) and ( enemy_num > enemy_count_limit ) then
-                                                        change_faction_relations( faction, killer_faction, -(value) )
+						if is_relation_allowed( factions_table[i] , killer_faction ) and ( enemy_num > enemy_count_limit ) then
+							change_faction_relations( factions_table[i], killer_faction, -(value) )
 							--printf("- Relations: Relations negative change | " .. factions_table[i] .. " <-> " .. killer_faction .. " relation change = " .. -(value))
 						else
 							--printf("% Relations: Relations change | " .. factions_table[i] .. " <-> " .. killer_faction .. " relation can't be changed!")
@@ -463,26 +429,24 @@

 
 local rnd_enemy = {}
 function get_random_enemy_faction(comm)
-       empty_table(rnd_enemy)
-       for i = 1, #factions_table do
-               local faction = factions_table[i]
-               if (comm ~= faction) and is_factions_enemies(faction, comm) and is_relation_allowed(faction , comm) then
-                       rnd_enemy[#rnd_enemy + 1] = faction
-               end
-       end
-       return (#rnd_enemy > 0) and rnd_enemy[math.random(#rnd_enemy)] or nil
+	empty_table(rnd_enemy)
+	for i = 1, #factions_table do
+		if (comm ~= factions_table[i]) and is_factions_enemies(factions_table[i], comm) and is_relation_allowed(factions_table[i] , comm) then
+			rnd_enemy[#rnd_enemy + 1] = factions_table[i]
+		end
+	end
+	return (#rnd_enemy > 0) and rnd_enemy[math.random(#rnd_enemy)] or nil
 end
 
 local rnd_natural = {}
 function get_random_natural_faction(comm)
-       empty_table(rnd_natural)
-       for i = 1, #factions_table do
-               local faction = factions_table[i]
-               if (comm ~= faction) and (not is_factions_enemies(faction, comm)) and is_relation_allowed(faction , comm) then
-                       rnd_natural[#rnd_natural + 1] = faction
-               end
-       end
-       return (#rnd_natural > 0) and rnd_natural[math.random(#rnd_natural)] or nil
+	empty_table(rnd_natural)
+	for i = 1, #factions_table do
+		if (comm ~= factions_table[i]) and (not is_factions_enemies(factions_table[i], comm)) and is_relation_allowed(factions_table[i] , comm) then
+			rnd_natural[#rnd_natural + 1] = factions_table[i]
+		end
+	end
+	return (#rnd_natural > 0) and rnd_natural[math.random(#rnd_natural)] or nil
 end
 
 
@@ -569,16 +533,16 @@

 	if (USE_MARSHAL) then
 		if 	(alife_storage_manager.get_state().new_game_relations) then
 			-- Restore relations for each faction:
-                       for i = 1, #factions_table do
-                               local faction_1 = factions_table[i]
-                               for j = (i + 1), #factions_table do
-                                       local faction_2 = factions_table[j]
+			for i = 1, #factions_table do
+				for j = (i + 1), #factions_table do
+					local faction_1 = factions_table[i]
+					local faction_2 = factions_table[j]
 					
 					load_relation ( faction_1 , faction_2 ) -- load and set overall faction relations:
 					load_relation ( "actor_" .. faction_1 , faction_2 ) -- load and set actor faction 1 / faction 2 relations:
-                                       load_relation ( faction_1 , "actor_" .. faction_2 ) -- load and set actor faction 2 / faction 1 relations:
-                               end
-                       end
+					load_relation ( faction_1 , "actor_" .. faction_2 ) -- load and set actor faction 2 / faction 1 relations:
+				end
+			end
 		else
 			reset_all_relations()
 			alife_storage_manager.get_state().new_game_relations = true
@@ -934,16 +898,15 @@

 	if (not rank_relation) then
 		rank_relation = {}
 		
-               local rn = utils_obj.get_rank_list()
-               for i=1,#rn do
-                       local rank = rn[i]
-                       rank_relation[rank] = {}
-                       local t = parse_list(ini_sys,"rank_relations",rank)
-                       for j,num in ipairs(t) do
-                               rank_relation[rank][rn[j]] = tonumber(num)
-                                --printf("-rank [%s][%s] = %s", rn[i], rn[j], tonumber(num))
-                       end
-               end
+		local rn = utils_obj.get_rank_list()
+		for i=1,#rn do
+			rank_relation[rn[i]] = {}
+			local t = parse_list(ini_sys,"rank_relations",rn[i])
+			for j,num in ipairs(t) do
+				rank_relation[rn[i]][rn[j]] = tonumber(num)
+				--printf("-rank [%s][%s] = %s", rn[i], rn[j], tonumber(num))
+			end
+		end
 	end
 	
 	local rank_1 = ranks.get_obj_rank_name(obj_1)
@@ -957,16 +920,15 @@

 	if (not reputation_relation) then
 		reputation_relation = {}
 		
-               local rn = utils_obj.get_reputation_list()
-               for i=1,#rn do
-                       local rep = rn[i]
-                       reputation_relation[rep] = {}
-                       local t = parse_list(ini_sys,"reputation_relations",rep)
-                       for j,num in ipairs(t) do
-                               reputation_relation[rep][rn[j]] = tonumber(num)
-                               --printf("-rep [%s][%s] = %s", rn[i], rn[j], tonumber(num))
-                       end
-               end
+		local rn = utils_obj.get_reputation_list()
+		for i=1,#rn do
+			reputation_relation[rn[i]] = {}
+			local t = parse_list(ini_sys,"reputation_relations",rn[i])
+			for j,num in ipairs(t) do
+				reputation_relation[rn[i]][rn[j]] = tonumber(num)
+				--printf("-rep [%s][%s] = %s", rn[i], rn[j], tonumber(num))
+			end
+		end
 	end
 	
 	local rep_1 = utils_obj.get_reputation_name(obj_1:character_reputation())
```
### sim_offline_combat.script
```diff
--- /workspace/G.A.M.M.A.-Warfare-Fix-Rewrite/runtime files/gamedata/scripts/sim_offline_combat.script

+++ /workspace/G.A.M.M.A.-Warfare-Fix-Rewrite/old walo/gamedata/scripts/sim_offline_combat.script

@@ -10,8 +10,7 @@

 	2021/02/04 - Vintar - removed Hybrid mode, re-enabled slider support for offline combat distance, changed ignore_list handling
 	2021/02/13 - Vintar - fixed warfare exclusions and missing monster factions related to call of pripyat allspawn mutants
 	2022/05/01 - Vintar - remove exemptions for `task_squads` and `task_giver_squads` to eliminate exempt squad buildup over time
-        2022/05/21 - Vintar - remove squad cap limitation, which wasn't correctly implemented for Warfare anyway
-        2025/07/24 - d0pe - hardened offline combat loops
+	2022/05/21 - Vintar - remove squad cap limitation, which wasn't correctly implemented for Warfare anyway
 
 	Offline Combat Simulator
 	Full simulation: When 2 enemy squads get close to each other, a battle will be simulated
@@ -105,23 +104,24 @@

 -------------------------------
 local function smart_terrain_on_update(smart)
 
-        empty_table(tbl_smart)
-
-       for id,_ in pairs(SIMBOARD.smarts[smart.id].squads) do
-               tbl_smart[#tbl_smart+1] = id
-       end
+	empty_table(tbl_smart)
+	
+	for id,_ in pairs(SIMBOARD.smarts[smart.id].squads) do
+		tbl_smart[#tbl_smart+1] = id
+	end
 	
 	if (#tbl_smart == 0) then
 		return
 	end
 	
-        shuffle_table(tbl_smart)
-
-        local sim = alife()
-
-        for _,id_1 in ipairs(tbl_smart) do
-                local squad_1 = sim:object(id_1)
-                local section = squad_1 and squad_1:section_name()
+	shuffle_table(tbl_smart)
+	
+	local sim = alife()
+	local lid_1
+	
+	for i,id_1 in pairs(tbl_smart) do
+		local squad_1 = sim:object(id_1)
+		local section = squad_1 and squad_1:section_name()
 		
 		if squad_1 and (not squad_1.online) and SIMBOARD.squads[squad_1.id] and (squad_1:npc_count() > 0)
 		then
@@ -130,8 +130,8 @@

 				return
 			end
 	
-                        local lid_1 = game_graph():vertex(squad_1.m_game_vertex_id):level_id()
-                        if lid_1 and squads_by_level[lid_1] then
+			lid_1 = lid_1 or game_graph():vertex(squad_1.m_game_vertex_id):level_id()
+			if lid_1 and squads_by_level[lid_1] then 
 				
 --				if (not task_squads[id_1]) and (not task_giver_squads[id_1]) then
 					-- disable offline combat for ignore list when Warfare is active
@@ -150,9 +150,9 @@

 							end
 						end
 				
-                                                -- Otherwise, scan for squads in the same map
-                                                for _,id_2 in ipairs(tbl_smart) do
-                                                        in_combat = validate_enemy(sim, lid_1, squad_1, id_1, id_2, community_1)
+						-- Otherwise, scan for squads in the same map
+						for j,id_2 in pairs(tbl_smart) do
+							in_combat = validate_enemy(sim, lid_1, squad_1, id_1, id_2, community_1)
 							if in_combat then
 								if enable_debug then
 									printf("% OCS | Battle in smart [%s]", smart:name())
@@ -241,11 +241,7 @@

 end
 
 local function coordinator()
-       ResetTimeEvent("cycle","ocs", UPDATE_TIME)
-
-       if not (SIMBOARD and SIMBOARD.smarts) then
-               return true -- wait until SIMBOARD initialized
-       end
+	ResetTimeEvent("cycle","ocs", UPDATE_TIME)
 	
 	-- Toggle feature
 	
```
### sim_squad_warfare.script
```diff
--- /workspace/G.A.M.M.A.-Warfare-Fix-Rewrite/runtime files/gamedata/scripts/sim_squad_warfare.script

+++ /workspace/G.A.M.M.A.-Warfare-Fix-Rewrite/old walo/gamedata/scripts/sim_squad_warfare.script

@@ -6,8 +6,7 @@

 	2020/09/22 - Vintar - loners no longer see other loner squads outside of fog of war (without PDA v2 or v3)
 	2021/02/13 - Vintar - added toggle capability for loner fog of war
 	2021/02/18 - Vintar - friendly random patrol squads are now labeled
-        2021/11/09 - Vintar - added goodwill on kill functionality
-        2025/07/24 - d0pe - synced with modular warfare system
+	2021/11/09 - Vintar - added goodwill on kill functionality
 
 	This file contains mostly retired functions, but still handles some squad-level stuff 
 	such as PDA squad spots and Warfare squad registration
```
### smart_terrain_warfare.script
```diff
--- /workspace/G.A.M.M.A.-Warfare-Fix-Rewrite/runtime files/gamedata/scripts/smart_terrain_warfare.script

+++ /workspace/G.A.M.M.A.-Warfare-Fix-Rewrite/old walo/gamedata/scripts/smart_terrain_warfare.script

@@ -26,8 +26,7 @@

 	2022/03/06 - Vintar - monster spawn numbers based on level lair capacity
 	2022/04/15 - Ace - Fix for crash when dead allied defenders try to send a message after invasion force is defeated
 	2022/04/22 - Vintar - Mutants from X8 and Pripyat Underpass can no longer transition out
-        2022/04/30 - Vintar - Main base attack prevention also applies to mutants
-        2025/07/24 - d0pe - added nil checks for target selection
+	2022/04/30 - Vintar - Main base attack prevention also applies to mutants
 	
 	This file handles the majority of warfare-related script tasks, such as squad behavior,
 	targeting, smart terrain updates, ownership checks, patrol behavior, etc.
@@ -1122,10 +1121,9 @@

 	if ((pda_actor.manual_control and smart.owning_faction ~= warfare.actor_faction) or (not pda_actor.manual_control)) then
 		local targets = find_targets(smart)
 			
-               if (#targets > 0) then
-                       for i=1,#targets do
-                               local target = targets[i]
-                               if not (smart.target_smarts[target[2]]) then
+		if (#targets > 0) then
+			for i=1,#targets do
+				if not (smart.target_smarts[targets[i][2]]) then
 					local target_delta = target_smart_count - invading_faction_props.min_smart_targets_per_base
 					if (target_delta < 0) then
 						local other = alife_object(targets[i][2])
@@ -4380,9 +4378,9 @@

 	local targets = {}
 	local mainbase_targets = {}  -- backup array if targets array is empty
 	
-       if (faction == "monster") then
-               return {}
-       end
+	if (faction == "monster") then
+		return
+	end
 	
 	for i=1,#smartCollection do
 		-- Do not even factor in which level this base is on. We want to have fluid borders at this point.
@@ -4602,9 +4600,9 @@

 		end
 	end
 
-       if (faction == "monster") then
-               return {}
-       end
+	if (faction == "monster") then
+		return
+	end
 
 	for i=1,#smartCollection do
 		local other = smartCollection[i] and alife_object(smartCollection[i])		
```
### tasks_assault.script
```diff
--- /workspace/G.A.M.M.A.-Warfare-Fix-Rewrite/runtime files/gamedata/scripts/tasks_assault.script

+++ /workspace/G.A.M.M.A.-Warfare-Fix-Rewrite/old walo/gamedata/scripts/tasks_assault.script

@@ -75,7 +75,6 @@

 
 
 ---------------------------< Utility >---------------------------
--- Verify squad section name is not a low-tier mutant used for tasks
 function is_legit_mutant_squad(squad)
 	local section = squad and squad:section_name()
 	return squad and (not sfind(section,"tushkano")) and (not sfind(section,"rat")) and true or false
@@ -140,15 +139,17 @@

 		and (squad.current_target_id and squad.current_target_id == smart.id and squad.current_action == 1) 
 		then
 			--printf("- %s | squad (%s) [%s] is targeting smart (%s)", task_id, squad.id, squad.player_id, smart.id)
-                       for i = 1, #cache_assault_func[task_id] do
-                               local fac = cache_assault_func[task_id][i]
-                               if (is_legit_mutant_squad(squad) and squad.player_id == fac) then
+			for i = 1, #cache_assault_func[task_id] do
+				local fac = cache_assault_func[task_id][i]
+				if (is_legit_mutant_squad(squad) and squad.player_id == fac) then
 					-- updating data
 					var.squad_id = squad.id
 					save_var( db.actor, task_id, var )
 					
 					-- reset gametime so they don't leave
-                                        squad.stay_time = game.get_game_time()
+					if not _G.WARFARE then
+						squad.stay_time = game.get_game_time() 
+					end
 					squad.force_online = true
 					--printf("- %s | squad (%s) [%s] is saved", task_id, squad.id, squad.player_id)
 					return true
@@ -199,7 +200,7 @@

 			news_ico = task_manager.task_ini:r_string_ex(task_id, "icon") or "ui_iconsTotal_mutant"
 		end
 
-		db.actor:give_talk_message2(news_caption, news_text, news_ico, "iconed_answer_item", task_id)
+		db.actor:give_talk_message2(news_caption, news_text, news_ico, "iconed_answer_item")
 	end
 	return true
 end
@@ -280,25 +281,22 @@

 	if (not cache_assault_func[task_id]) then
 		cache_assault_func[task_id] = {}
 		local params = parse_list(task_manager.task_ini,task_id,"status_functor_params")
-               if var.is_enemy then
-                       for i=1,#params do
-                               local param = params[i]
-                               if is_squad_monster[param] or factions_list[param] then
-                                       local idx = #cache_assault_func[task_id] + 1
-                                       cache_assault_func[task_id][idx] = param
-                                        printf("/ %s | Faction [%s] is re-added to cache_assault_func table", task_id, param)
-                                end
-                        end
+		if var.is_enemy then
+			for i=1,#params do
+				if is_squad_monster[params[i]] or factions_list[params[i]] then
+					cache_assault_func[task_id][i] = params[i]
+					printf("/ %s | Faction [%s] is re-added to cache_assault_func table", task_id, params[i])
+				end
+			end
 		elseif (not is_squad_monster[params[1]]) then
-                       for fac,_ in pairs(factions_list) do
-                               local cnt = 0
-                               local is_enemy_to_actor = true --game_relations.is_factions_enemies(fac, get_actor_true_community())
-                               for i=1,#params do
-                                       local param = params[i]
-                                       if (fac ~= param) and is_enemy_to_actor and game_relations.is_factions_enemies(fac, param) then
-                                               cnt = cnt + 1
-                                       end
-                                end
+			for fac,_ in pairs(factions_list) do
+				local cnt = 0
+				local is_enemy_to_actor = true --game_relations.is_factions_enemies(fac, get_actor_true_community())
+				for i=1,#params do
+					if (fac ~= params[i]) and is_enemy_to_actor and game_relations.is_factions_enemies(fac, params[i]) then
+						cnt = cnt + 1
+					end
+				end
 				if (cnt == #params) then
 					local idx = #cache_assault_func[task_id] + 1
 					cache_assault_func[task_id][idx] = fac
@@ -308,10 +306,6 @@

 		end
 		if (#cache_assault_func[task_id] == 0) then
 			printe("! %s | no enemy factions found",task_id)
---[[
-        SERIOUS NO NORTH TASKS BEFORE BS
-        AND THE NORTHERN JOB
---]]
 			return "fail"
 		end
 	end
@@ -407,25 +401,23 @@

 	
 	--// Collect enemy factions
 	if def.is_enemy then -- if faction parameters are enemies
-               for i=1,#p_status do
-                       local status = p_status[i]
-                       if is_squad_monster[status] or factions_list[status] then
-                               --printf("/ %s | Faction [%s] is added to enemy_faction_list table", task_id, status)
-                               enemy_faction_list[status] = true
-                       end
-               end
+		for i=1,#p_status do
+			if is_squad_monster[p_status[i]] or factions_list[p_status[i]] then
+				--printf("/ %s | Faction [%s] is added to enemy_faction_list table", task_id, p_status[i])
+				enemy_faction_list[p_status[i]] = true
+			end
+		end
 		
 	elseif (not is_squad_monster[p_status[1]]) then -- if faction parameters are matutal factions
 		for fac,_ in pairs(factions_list) do
 			local cnt = 0
 			local is_enemy_to_actor = true --game_relations.is_factions_enemies(fac, get_actor_true_community())
-               for i=1,#p_status do
-                       local status = p_status[i]
-                               if (fac ~= status) and is_enemy_to_actor and game_relations.is_factions_enemies(fac, status) then
-                                       cnt = cnt + 1
-                               end
-                       end
-                        if (cnt == #p_status) then
+			for i=1,#p_status do
+				if (fac ~= p_status[i]) and is_enemy_to_actor and game_relations.is_factions_enemies(fac, p_status[i]) then
+					cnt = cnt + 1
+				end
+			end
+			if (cnt == #p_status) then
 				enemy_faction_list[fac] = true
 				--printf("/ %s | Faction [%s] is added to enemy_faction_list table", task_id, fac)
 			end
@@ -434,27 +426,6 @@

 	
 	if is_empty(enemy_faction_list) then
 		printe("! %s | no enemy factions found", task_id)
---[[
-        SERIOUS NO NORTH TASKS BEFORE BS
-        AND THE NORTHERN JOB
---]]
-        local additionalBlacklist = {}
-        local mcm_scanMode = blacklist_helper.GetMcmDropdownValue()
-        local northernMaps = blacklist_helper.GetNorthernMaps()
-
-        if mcm_scanMode and mcm_scanMode > 0  then
-                def.scan = mcm_scanMode
-        end
-
-        if blacklist_helper.ShouldBlacklistNorth() then
-                additionalBlacklist = northernMaps
-        elseif northernMaps[level.name()] then -- Player is in the Northern region and rightfully so
-                additionalBlacklist = blacklist_helper.GetSouthernMaps()
-        end
---[[
-        SERIOUS NO NORTH TASKS BEFORE BS
-        AND THE NORTHERN JOB
---]]
 		return false
 	end
 	
```
### tasks_smart_control.script
```diff
--- /workspace/G.A.M.M.A.-Warfare-Fix-Rewrite/runtime files/gamedata/scripts/tasks_smart_control.script

+++ /workspace/G.A.M.M.A.-Warfare-Fix-Rewrite/old walo/gamedata/scripts/tasks_smart_control.script

@@ -52,7 +52,6 @@

 }
 
 ---------------------------< Utility >---------------------------
--- Check squad section name is valid for smart control tasks
 function is_legit_mutant_squad(squad)
 	local section = squad and squad:section_name()
 	return squad and (not sfind(section,"tushkano")) and (not sfind(section,"rat")) and true or false
```
### ui_options.script
```diff
--- /workspace/G.A.M.M.A.-Warfare-Fix-Rewrite/runtime files/gamedata/scripts/ui_options.script

+++ /workspace/G.A.M.M.A.-Warfare-Fix-Rewrite/old walo/gamedata/scripts/ui_options.script

@@ -26,8 +26,7 @@

 	2020/11/07 - Vintar - added resurgence chance as option
 	2021/02/13 - Vintar - added 'overflow overrides manual control' and 'extra loner fog of war' toggle, min smart targets per base
 	2021/11/09 - Vintar - added goodwill on kill options, added back "hide all smarts" option, added 'old autocapture' option
-        2022/02/26 - Vintar - added main base attack deprioritization option
-        2025/07/24 - d0pe - minor formatting cleanup
+	2022/02/26 - Vintar - added main base attack deprioritization option
 	
 --]]
 
@@ -101,7 +100,7 @@

 		{ id= "gamma"  		           ,type= "track"    ,val= 2	,cmd= "rs_c_gamma"					,min= 0.5  ,max= 1.5  ,step= 0.1 ,precondition= {for_renderer,"renderer_r1"}	},
 		{ id= "contrast"  	           ,type= "track"    ,val= 2	,cmd= "rs_c_contrast"				,min= 0.5  ,max= 1.5  ,step= 0.1 ,precondition= {for_renderer,"renderer_r1"}	},
 		{ id= "brightness"             ,type= "track"    ,val= 2	,cmd= "rs_c_brightness"				,min= 0.5  ,max= 1.5  ,step= 0.1 ,precondition= {for_renderer,"renderer_r1"}	},
-		{ id= "fov"  		           ,type= "track"    ,val= 2	,cmd= "fov"							,min= 5    ,max= 180  ,step= 1 },
+		{ id= "fov"  		           ,type= "track"    ,val= 2	,cmd= "fov"							,min= 5    ,max= 140  ,step= 1 },
 		{ id= "hud_fov"  	           ,type= "track"    ,val= 2	,cmd= "hud_fov"						,min= 0.1  ,max= 1    ,step= 0.01 },
 		{ id= "screen_mode"            ,type= "radio_h"  ,val= 2	,curr= {curr_screen_mode} 			,content= {{1,"fullscreen"} , {2,"borderless"} , {3,"windowed"}} 	,functor = {func_screen_mode}		},
 		{ id= "lighting"  		       ,type= "button"   ,functor_ui= {start_lighting_ui}  				,precondition= {level_present}		,precondition_1= {for_renderer,"renderer_r2a","renderer_r2","renderer_r2.5","renderer_r3","renderer_r4"}    },
@@ -125,7 +124,7 @@

 		{ id= "texture_lod"            ,type= "track"    ,val= 2	,cmd= "texture_lod"	                ,min= 0     ,max= 4     ,step= 1 	,no_str= true	  ,invert= true     ,vid= true	,restart= true	},
 		{ id= "geometry_lod"           ,type= "track"    ,val= 2	,cmd= "r__geometry_lod"	            ,min= 0.1   ,max= 1.5   ,step= 0.1 },
 		{ id= "mipbias"           	   ,type= "track"    ,val= 2	,cmd= "r__tf_mipbias"	            ,min= -0.5  ,max= 0.5   ,step= 0.1 	,no_str= true 	  ,invert= true },
-                { id= "tf_aniso"               ,type= "track"    ,val= 2       ,cmd= "r__tf_aniso"                      ,min= 1     ,max= 16    ,step= 4    ,vid= true  },
+		{ id= "tf_aniso"               ,type= "list"     ,val= 0	,cmd= "r__tf_aniso"	                ,content={ {"1","st_opt_off"},{"4","x4"},{"8","x8"},{"16","x16"} }    ,vid= true, no_str= true	},
 		{ id= "ssample"                ,type= "track"    ,val= 2	,cmd= "r__supersample"	            ,min= 1     ,max= 8     ,step= 1       ,vid= true      ,precondition= {for_renderer,"renderer_r1","renderer_r2a","renderer_r2","renderer_r2.5"} },
 		{ id= "ssample_list"           ,type= "list"     ,val= 0	,cmd= "r3_msaa"	                    ,content={ {"st_opt_off","st_opt_off"},{"2x","x2"},{"4x","x4"},{"8x","x8"} }	    ,vid= true          ,precondition= {for_renderer,"renderer_r3","renderer_r4"} , no_str= true  },
 		{ id= "smaa"           		   ,type= "list"     ,val= 0	,cmd= "r2_smaa"	                    ,content={ {"off","st_opt_off"},{"low","st_opt_low"},{"medium","st_opt_medium"},{"high","st_opt_high"},{"ultra","st_opt_ultra"} } ,precondition= {for_renderer,"renderer_r2a","renderer_r2","renderer_r2.5","renderer_r3","renderer_r4"}, no_str= true  },
@@ -362,6 +361,8 @@

 		{ id= "dispersion_factor"    	 ,type= "track"    ,val= 2	,curr= {curr_gameplay,"dispersion_factor"}	 ,functor= {func_gameplay_diff,"dispersion_factor"}	,min= 1       ,max= 5     ,step= 0.1  	    },
 		{ id= "power_loss_bias"    	     ,type= "track"    ,val= 2	,curr= {curr_gameplay,"power_loss_bias"}	 ,functor= {func_gameplay_diff,"power_loss_bias"}	,min= 0.0     ,max= 1     ,step= 0.05  		},
 		{ id= "weight"    	     		 ,type= "track"    ,val= 2	,curr= {curr_gameplay,"weight"}	     		 ,functor= {func_gameplay_diff,"weight"}	 		,min= 10      ,max= 50    ,step= 1  	    },
+		{ id= "thirst"    	     		 ,type= "check"    ,val= 1	,curr= {curr_gameplay,"thirst"}	         	 ,functor= {func_gameplay_diff,"thirst"}	                           	 						},
+		{ id= "sleep"    	     		 ,type= "check"    ,val= 1	,curr= {curr_gameplay,"sleep"}	         	 ,functor= {func_gameplay_diff,"sleep"}	                           	 							},
 		{ id= "radiation_day"    	     ,type= "check"    ,val= 1	,curr= {curr_gameplay,"radiation_day"}	     ,functor= {func_gameplay_diff,"radiation_day"}	     	                   	 					},
 		{ id= "notify_geiger"    	     ,type= "check"    ,val= 1	,curr= {curr_gameplay,"notify_geiger"}	     ,functor= {func_gameplay_diff,"notify_geiger"}	     	                   	 					},
 		{ id= "notify_anomaly"    	     ,type= "check"    ,val= 1	,curr= {curr_gameplay,"notify_anomaly"}	     ,functor= {func_gameplay_diff,"notify_anomaly"}	     	                   	 				},
@@ -430,8 +431,8 @@

 	{ id= "general"      	,sh=true ,gr={
 		{ id= "slide_alife"		,type= "slide"	  ,link= "ui_options_slider_alife"	 ,text= "ui_mm_title_alife"		,size= {512,50}		},
 
-                { id= "alife_mutant_pop"                ,type= "list"    ,val= 2  ,def= 0.75     ,content= {{0.25} , {0.5} , {0.75} , {1}}              ,no_str= true  },
-                { id= "alife_stalker_pop"               ,type= "list"    ,val= 2  ,def= 0.5      ,content= {{0.25} , {0.5} , {0.75} , {1}}              ,no_str= true  },
+		{ id= "alife_mutant_pop"  		,type= "list"    ,val= 2  ,def= 1.5 	 ,content= {{0.25} , {0.5} , {0.75} , {1}, {1.5}, {2}, {3}}		,no_str= true  },
+		{ id= "alife_stalker_pop"  		,type= "list"    ,val= 2  ,def= 1 	 ,content= {{0.25} , {0.5} , {0.75} , {1}, {1.5}, {2}}		,no_str= true  },
 		{ id= "offline_combat"  		,type= "list"    ,val= 0  ,def= "full" 	 ,content= {{"full","full"}, {"on_smarts_only","on_smarts_only"}, {"off","off"}} },
 		{ id= "excl_dist"  				,type= "list"    ,val= 2  ,def= 75 	 	 ,content= {{0} , {25} , {50} , {75} , {100}}	,no_str= true  },
 		{ id= "dynamic_anomalies"        ,type= "check"    ,val= 1	,def= true	 },
@@ -1711,7 +1712,7 @@

 		return
 	end
 	
-	if (v.val == 1) then
+	if (v.val == 2) then
 		value = tonumber(value)
 		if (not value) then
 			ctrl:SetText( self:GetCurrentValue(path, opt, v) or self:GetDefaultValue(path, opt, v) )
```
### ui_pda_warfare_tab.script
```diff
--- /workspace/G.A.M.M.A.-Warfare-Fix-Rewrite/runtime files/gamedata/scripts/ui_pda_warfare_tab.script

+++ /workspace/G.A.M.M.A.-Warfare-Fix-Rewrite/old walo/gamedata/scripts/ui_pda_warfare_tab.script

@@ -3,8 +3,7 @@

 =======================================================================================
 	Original creator: Tronex
 	Edit log: 
-        2020/05/24 - Vintar
-        2025/07/24 - d0pe - clarified tab overview
+	2020/05/24 - Vintar
 
 	New PDA tab for Warfare mode: faction war
 	This file converts the 'contacts' tab into a faction ranking info tab. Faction squad
@@ -18,7 +17,6 @@

 local clr_w,clr_gr
 
 local SINGLETON = nil
-local node_system = require 'node_system'
 function get_ui()
 	SINGLETON = SINGLETON or pda_warfare_tab()
 	SINGLETON:Reset()
@@ -332,13 +330,5 @@

 		self.btn:TextControl():SetText(game.translate_string("pda_all_levels"))
 	end
 	
-        self:Reset()
-end
-
---- Placeholder callback to upgrade a selected node.
--- UI integration pending.
-function pda_warfare_tab:upgrade_selected_node(node_id)
-        printf("[PDA] request upgrade for %s", tostring(node_id))
-        -- actual upgrade logic handled in node_system
-        node_system.upgrade_node(node_id)
-end
+	self:Reset()
+end
```
### warfare.script
```diff
--- /workspace/G.A.M.M.A.-Warfare-Fix-Rewrite/runtime files/gamedata/scripts/warfare.script

+++ /workspace/G.A.M.M.A.-Warfare-Fix-Rewrite/old walo/gamedata/scripts/warfare.script

@@ -7,27 +7,13 @@

 	2020/10/22 - Vintar - fixed vanilla bug where random patrols were unmarked as random patrols upon game save/load
 	2021/02/16 - Vintar - allowed loner random patrols to be unmarked on game save, so that process_loners() can handle them, saved calculated distances between smart terrains
 	2021/02/22 - Vintar - added initial mutant spawns to non-random start. Random start mutants now spawn on lairs. Under attack status saved
-        2021/03/19 - Vintar - fix for lower population factor initial spawns
-        2025/07/24 - d0pe - added verbose logger and helper utilities
+	2021/03/19 - Vintar - fix for lower population factor initial spawns
 
 	This file deals with warfare's essential data, such as squad registration with warfare,
 	and saving/loading important parameters like respawn timers, squad targets, faction info
 =======================================================================================
 
 --]]
-
--- Enable verbose debug tracing when requested
-if _G.verbose_logs == 1 then
-    -- Load logger from the same directory as this script so it works both
-    -- when installed under gamedata/ and when running from the repo.
-    local dir = debug.getinfo(1, "S").source
-    dir = dir and dir:gsub("@", ""):match("^(.*[\\/])") or ""
-    local path = dir .. "verbose_logger.script"
-    local ok, err = pcall(dofile, path)
-    if not ok then
-        printf("[VERBOSE] Failed to load logger: %s", tostring(err))
-    end
-end
 
 --_G.DEACTIVATE_SIM_ON_NON_LINKED_LEVELS = false
 --_G.ProcessEventQueueState = function() return end
@@ -492,7 +478,6 @@

 
 FACTION_TERRITORY_RADIUS = 100
 
--- Fisher-Yates shuffle used for randomizing squad lists
 function shuffleTable( t )
     local rand = math.random 
     local iterations = #t
@@ -926,15 +911,7 @@

 end
 
 function on_game_start()
-        printd(0, "on_game_start")
-
-        -- added require path for .script modules
-        if not package.path:find('gamedata/scripts/%.script', 1, true) then
-                package.path = 'gamedata/scripts/?.script;' .. package.path
-        end
-        if not package.path:find('gamedata/scripts/%.lua', 1, true) then
-                package.path = 'gamedata/scripts/?.lua;' .. package.path
-        end
+	printd(0, "on_game_start")
 	--_G.WARFARE = false
 	warfare_options.update_settings()
 	
@@ -1001,7 +978,6 @@

 	end) return tbl
 end
 
--- 2D squared distance ignoring Y axis used by AI distance checks
 function distance_to_xz_sqr(a, b)
 	return math.pow(b.x - a.x, 2) + math.pow(b.z - a.z, 2)
 end
```
### warfare_factions.script
```diff
--- /workspace/G.A.M.M.A.-Warfare-Fix-Rewrite/runtime files/gamedata/scripts/warfare_factions.script

+++ /workspace/G.A.M.M.A.-Warfare-Fix-Rewrite/old walo/gamedata/scripts/warfare_factions.script

@@ -6,8 +6,7 @@

 	2020/11/07 - Vintar - Resurgence chance added to resurgence calculation
 	2021/02/19 - Vintar - stronger resurgence attempts, now uses fetch_smart_distance(), debug messages
 	2021/03/27 - Vintar - loners exempt from random patrol targeting. Random patrols no longer spawn too close to actor.
-        2021/11/22 - Vintar - slight change to resurgence base count
-        2025/07/24 - d0pe - added nil checks for faction lists
+	2021/11/22 - Vintar - slight change to resurgence base count
 
 	This file handles faction-level warfare stuff like random patrols, resurgences, etc.
 =======================================================================================
@@ -56,7 +55,7 @@

 faction_timers = {}
 
 for i=1,#factions do
-       factions_p[factions[i]] = true
+	factions_p[factions[i]] = true
 end
 
 --[[
@@ -83,7 +82,6 @@

 	end
 end
 
--- Update timers and patrol logic for a single faction
 function update_faction(faction)
 	if (not faction or faction == "none") then
 		return
```
### warfare_options.script
```diff
--- /workspace/G.A.M.M.A.-Warfare-Fix-Rewrite/runtime files/gamedata/scripts/warfare_options.script

+++ /workspace/G.A.M.M.A.-Warfare-Fix-Rewrite/old walo/gamedata/scripts/warfare_options.script

@@ -8,8 +8,7 @@

 	2021/02/13 - Vintar - reads in overflow override, loner fog of war
 	2021/02/16 - Vintar - added min smart targets per base
 	2021/11/09 - Vintar - added goodwill on kill options, added back "hide all smarts" option, added 'old autocapture' option
-        2022/02/26 - Vintar - added main base attack deprioritization option
-        2025/07/24 - d0pe - added random start helper
+	2022/02/26 - Vintar - added main base attack deprioritization option
 
 	This file reads the main menu options for warfare so that script functions can access them.
 =======================================================================================
@@ -229,7 +228,6 @@

 	sim_squad_scripted.sim_squad_scripted.specific_update = function(self, script_target_id) end
 end
 
--- Pick a random start location from faction lists
 function get_random_start_location()
 	warfare.printd(0, "get_random_start_location")
 
```
### xr_logic.script
```diff
--- /workspace/G.A.M.M.A.-Warfare-Fix-Rewrite/runtime files/gamedata/scripts/xr_logic.script

+++ /workspace/G.A.M.M.A.-Warfare-Fix-Rewrite/old walo/gamedata/scripts/xr_logic.script

@@ -36,7 +36,6 @@

 	end
 end
 
--- Spawn configured items into an NPCs inventory during initialization
 function spawn_items(npc, st)
 	--utils_data.debug_write("spawner:spawn_items")
 	if not (st.ini and st.section_logic) then 
```
## Differences for gammas_patch
### faction_expansions.script
```diff
--- /workspace/G.A.M.M.A.-Warfare-Fix-Rewrite/runtime files/gamedata/scripts/faction_expansions.script

+++ /workspace/G.A.M.M.A.-Warfare-Fix-Rewrite/gammas patch/gamedata/scripts/faction_expansions.script

@@ -7,8 +7,7 @@

 	2020/05/25 - Vintar
 	2020/05/31 - Vintar - lowered loner veteran chance
 	2021/02/27 - Vintar - lowered loner advanced/veteran chance again, removed rats from spawn
-        2021/03/02 - Vintar - removed black smoke poltergeist
-        2025/07/24 - d0pe - documented spawn chance formulas
+	2021/03/02 - Vintar - removed black smoke poltergeist
 
 	This file provides the chance for advanced/veteran squads to spawn instead of novice
 	squads, or picks a normal/rare mutant spawn section.
@@ -133,13 +132,11 @@

 
 -- old functions were overly complicated and had a weird minimum at 80% resource ownership where your squads would be worse on average
 -- new functions are monotonically increasing so that each point of resource is always a sizeable benefit
--- Chance percentage for an advanced squad spawn given owned resources
 function get_advanced_chance(resource)
 --	return -1 * (100 * (1 / math.pow(warfare.resource_count / 2, 2))) * math.pow((resource - (warfare.resource_count / 2)), 2) + 100
 	return 150 * (math.pow((resource / warfare.resource_count), 0.8))
 end
 
--- Chance percentage for a veteran squad spawn given owned resources
 function get_veteran_chance(resource)
 --	return -100 + (100 / (warfare.resource_count / 2)) * resource
 	return 100 * (math.pow((resource / warfare.resource_count), 2))
```
### sim_squad_scripted.script
```diff
--- /workspace/G.A.M.M.A.-Warfare-Fix-Rewrite/runtime files/gamedata/scripts/sim_squad_scripted.script

+++ /workspace/G.A.M.M.A.-Warfare-Fix-Rewrite/gammas patch/gamedata/scripts/sim_squad_scripted.script

@@ -136,7 +136,7 @@

 	
 	local new_id = tonumber(new_target)
 	local se_target = new_id and alife_object(new_id)
-	if se_target and (se_target:clsid() == clsid.online_offline_group_s or se_target:clsid() == clsid.smart_terrain) then
+	if se_target and (obj:clsid() == clsid.online_offline_group_s or obj:clsid() == clsid.smart_terrain) then
 		return new_id
 	end
 end
```
### ui_options.script
```diff
--- /workspace/G.A.M.M.A.-Warfare-Fix-Rewrite/runtime files/gamedata/scripts/ui_options.script

+++ /workspace/G.A.M.M.A.-Warfare-Fix-Rewrite/gammas patch/gamedata/scripts/ui_options.script

@@ -26,8 +26,7 @@

 	2020/11/07 - Vintar - added resurgence chance as option
 	2021/02/13 - Vintar - added 'overflow overrides manual control' and 'extra loner fog of war' toggle, min smart targets per base
 	2021/11/09 - Vintar - added goodwill on kill options, added back "hide all smarts" option, added 'old autocapture' option
-        2022/02/26 - Vintar - added main base attack deprioritization option
-        2025/07/24 - d0pe - minor formatting cleanup
+	2022/02/26 - Vintar - added main base attack deprioritization option
 	
 --]]
 
@@ -125,7 +124,7 @@

 		{ id= "texture_lod"            ,type= "track"    ,val= 2	,cmd= "texture_lod"	                ,min= 0     ,max= 4     ,step= 1 	,no_str= true	  ,invert= true     ,vid= true	,restart= true	},
 		{ id= "geometry_lod"           ,type= "track"    ,val= 2	,cmd= "r__geometry_lod"	            ,min= 0.1   ,max= 1.5   ,step= 0.1 },
 		{ id= "mipbias"           	   ,type= "track"    ,val= 2	,cmd= "r__tf_mipbias"	            ,min= -0.5  ,max= 0.5   ,step= 0.1 	,no_str= true 	  ,invert= true },
-                { id= "tf_aniso"               ,type= "track"    ,val= 2       ,cmd= "r__tf_aniso"                      ,min= 1     ,max= 16    ,step= 4    ,vid= true  },
+		{ id= "tf_aniso"               ,type= "track"    ,val= 2	,cmd= "r__tf_aniso"	                ,min= 1     ,max= 16    ,step= 4    ,vid= true	},
 		{ id= "ssample"                ,type= "track"    ,val= 2	,cmd= "r__supersample"	            ,min= 1     ,max= 8     ,step= 1       ,vid= true      ,precondition= {for_renderer,"renderer_r1","renderer_r2a","renderer_r2","renderer_r2.5"} },
 		{ id= "ssample_list"           ,type= "list"     ,val= 0	,cmd= "r3_msaa"	                    ,content={ {"st_opt_off","st_opt_off"},{"2x","x2"},{"4x","x4"},{"8x","x8"} }	    ,vid= true          ,precondition= {for_renderer,"renderer_r3","renderer_r4"} , no_str= true  },
 		{ id= "smaa"           		   ,type= "list"     ,val= 0	,cmd= "r2_smaa"	                    ,content={ {"off","st_opt_off"},{"low","st_opt_low"},{"medium","st_opt_medium"},{"high","st_opt_high"},{"ultra","st_opt_ultra"} } ,precondition= {for_renderer,"renderer_r2a","renderer_r2","renderer_r2.5","renderer_r3","renderer_r4"}, no_str= true  },
@@ -430,9 +429,9 @@

 	{ id= "general"      	,sh=true ,gr={
 		{ id= "slide_alife"		,type= "slide"	  ,link= "ui_options_slider_alife"	 ,text= "ui_mm_title_alife"		,size= {512,50}		},
 
-                { id= "alife_mutant_pop"                ,type= "list"    ,val= 2  ,def= 0.75     ,content= {{0.25} , {0.5} , {0.75} , {1}}              ,no_str= true  },
-                { id= "alife_stalker_pop"               ,type= "list"    ,val= 2  ,def= 0.5      ,content= {{0.25} , {0.5} , {0.75} , {1}}              ,no_str= true  },
-		{ id= "offline_combat"  		,type= "list"    ,val= 0  ,def= "full" 	 ,content= {{"full","full"}, {"on_smarts_only","on_smarts_only"}, {"off","off"}} },
+		{ id= "alife_mutant_pop"  		,type= "list"    ,val= 2  ,def= 0.75 	 ,content= {{0.25} , {0.5} , {0.75} , {1}}		,no_str= true  },
+		{ id= "alife_stalker_pop"  		,type= "list"    ,val= 2  ,def= 0.5 	 ,content= {{0.25} , {0.5} , {0.75} , {1}}		,no_str= true  },
+		{ id= "offline_combat"  		,type= "list"    ,val= 0  ,def= "full" 	 ,content= {{"full","full"} , {"on_smarts_only","on_smarts_only"}, {"off","off"}} },
 		{ id= "excl_dist"  				,type= "list"    ,val= 2  ,def= 75 	 	 ,content= {{0} , {25} , {50} , {75} , {100}}	,no_str= true  },
 		{ id= "dynamic_anomalies"        ,type= "check"    ,val= 1	,def= true	 },
 		{ id= "dynamic_relations"        ,type= "check"    ,val= 1	,def= false	 },
```