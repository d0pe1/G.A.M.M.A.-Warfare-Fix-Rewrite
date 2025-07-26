Agent Profiles for the G.A.M.M.A. Warfare Overhaul
This document defines the scope, responsibilities and working practices for the
autonomous agents that will implement the G.A.M.M.A. Warfare Overhaul for
STALKER Anomaly. The overhaul introduces new systems (resource
infrastructure, squad logistics, progression, diplomacy and faction
philosophies) and aims to integrate and modernise code from multiple sources
(old_walo, gammas patch and the existing runtime scripts) without
breaking compatibility. Each agent is modelled as a game‑developer
specialist that writes Lua scripts, integrates with the X‑Ray engine API,
updates documentation and tests, and iteratively improves the codebase.

General guidelines
Language & framework – Implementation is in Lua and runs inside
the X‑Ray engine. Agents should use functions exposed by the engine
through the level namespace and related modules (e.g. level.map_add_object_spot,
level.map_change_spot_hint, spawn_item etc. as documented in
X‑Ray’s Lua help file
github.com
).

Data flow awareness – Systems interact with each other. For example,
resource nodes feed logistics, which enable squad spawns and affect
diplomacy. Agents must expose clear interfaces and avoid hidden
dependencies.

Documentation & testing – Every function must be documented with a
header comment (purpose, parameters, return value, side effects). For each
module there must be a corresponding Busted test file; tests should
articulate expected behaviour and write out pass/fail logs. When a file
changes, update the central CHANGELOG.md and append a detailed entry to
DevDiary.md.

Iteration – Agents operate incrementally. They should write a plan for
their task, execute it, run tests, inspect crash logs, and repeat until
behaviour matches expectations. After finishing, they tick the
corresponding task in agent_tasks.md and proceed to the next.

Error handling – If runtime crash logs are present in the
runtime crashes folder, the agent must prioritise analysing those logs
and fix the offending code before continuing.

Agents
1. DiffAnalysisAgent
Role: Identify differences between the three source trees (the
runtime reference, old_walo and gammas patch) and generate
machine‑readable reports. Establish which functions have been changed or
added and annotate potential conflicts.

Skills: Lua syntax familiarity, file diffing, reading .script and
.ltx files, writing Markdown. Awareness of Anomaly’s script loading
order.

Inputs:

runtime files/ – baseline scripts and configs representing the
current state of the GAMMA modpack.

old_walo/ – Vintar’s Warfare A‑Life overhaul scripts.

gammas patch/ – GAMMA team’s patch scripts.

Outputs:

docs/runtime_vs_gamma_walo.md – a diff report listing every file
changed or missing between runtime files and gamma_walo once
integration begins.

docs/api_map.md – a table mapping existing runtime functions to the
modules that call them, useful for understanding cross‑system hooks.

Updates to agent_tasks.md with discovered conflicts or missing
implementations.

Procedures:

Run the Analyzer profile (a diff script in the repository) against the
three directories. If the profile isn’t available, implement a Lua or
Python diff routine that produces unified diffs.

For each file in old_walo and gammas patch, compare it to its
counterpart in runtime files. Note lines that were changed, functions
added or removed, and behavioural differences.

Create a section in docs/runtime_vs_gamma_walo.md summarising
conflicts and listing candidate functions to port into gamma_walo.

Build docs/api_map.md by scanning runtime files/gamedata/scripts
and extracting function names and their modules. Note where engine
functions are called (e.g. level.map_add_object_spot
github.com
) to
guide later hooking.

Add any new tasks or required clarifications to
agent_tasks.md under the Analysis section.

2. ResourceInfrastructureAgent
Role: Implement the Resource Infrastructure System described in the
design document. This system introduces resource and base nodes that
produce resources and enable faction capabilities
GitHub
.

Skills: Object‑oriented Lua, data modelling, hooking into territory
capture events, managing timers for daily resource output, and ensuring
compatibility with simulation_objects.script.

Inputs:

Output from DiffAnalysisAgent describing existing node code (if any).

runtime files/gamedata/scripts/sim_board.script and
simulation_objects.script – for understanding how smart terrains and
squads are registered and updated.

Design spec (SystemsDesign.md) describing resource nodes and base roles
GitHub
.

Outputs:

gamma_walo/gamedata/scripts/resource_system.script – new module
implementing resource nodes and base nodes.

Updated simulation_objects.script or wrapper to call resource system
hooks on capture/lose territory events.

Configuration files (e.g. .ltx) defining default resource yields,
base specialisations and upgrade costs.

Busted tests verifying that resources accumulate over days, that
depletion and looting work, and that faction bias influences resource
choice.

Documentation for the new API in docs/resource_system.md and
changelog entries.

Procedures:

Define Lua classes (tables with metatables) for ResourceNode,
BaseNode and HQNode. Each should track owner faction, stockpile
amounts and upgrade level.

Hook into the event triggered when a smart terrain is captured or lost.
Use functions from sim_board.script and simulation_objects.script to
detect territory capture. When a capture occurs, create a new
ResourceNode entry in a global resource_system table.

Implement a timer that triggers daily resource generation. Use
level.add_call or equivalent engine function
github.com

to schedule periodic updates without blocking the main thread.

Write functions for players (via UI) to convert a neutral territory into
a resource or base node and to specialise bases (militia, research or
trader). These should check faction stockpiles and deduct resources
accordingly.

Expose APIs: resource_system.get_node(id),
resource_system.generate_resources(), etc., for other modules.

Write tests to simulate capturing a territory, generating resources for
several days, and verifying stockpile changes. Tests should also cover
contested nodes being looted and depletion mechanics.

Update documentation and changelog.

3. LogisticsAgent
Role: Implement the Squad Logistics Simulation described in the
design doc. Transport squads will ferry resources from nodes to base
nodes, and AI behaviour will react to ambushes and bottlenecks
GitHub
.

Skills: Pathfinding with smart terrains, AI state machines, hooking into
spawn routines, and interacting with the X‑Ray level API for spawning
items and squads
github.com
. Must handle concurrency
and call scheduling.

Inputs:

Resource stockpiles and node positions from ResourceInfrastructureAgent.

simulation_objects.script – to understand how squads and objects are
registered and updated
GitHub
.

Current spawn logic in runtime files/gamedata/scripts/sim_board.script.

Outputs:

gamma_walo/gamedata/scripts/logistics_system.script – module that
manages creation and movement of transport squads.

Adjusted spawn logic (either patched into existing spawn functions or
through wrappers) that uses resources to determine when squads can be
spawned and what equipment they carry.

Tests verifying that transport squads pick up the correct amount of
resources, pathfind to base nodes, drop resources when killed and that
fallback behaviour works (e.g. patrol squads pick up dropped cargo).

Documentation of the logistics API.

Procedures:

Define a TransportSquad class that holds a queue of resources to
carry, a route (list of smart terrains) and a timer for travel.

Hook into resource generation: when a node stockpile exceeds a
threshold, create a transport squad and schedule it to travel to the
appropriate base node. Use spawn_item or spawn_phantom to spawn
actual in‑game entities
github.com
.

Use pathfinding functions from simulation_objects.script or the
engine (e.g. level.vertex_position, game_graph) to choose safe
routes. Factor in faction control and known ambushes.

Implement ambush handling: if a transport squad is killed, call
functions from level to drop loot on the ground; update stockpiles
accordingly. Enable nearby patrol squads to pick up dropped goods.

Provide a mechanism for HQ nodes (see FactionHQAgent) to reroute
squads dynamically based on global state.

Write tests simulating resource transport and verifying that squads
deliver the correct resources and that stockpiles in base nodes update.

Document the system and update the changelog.

4. SquadProgressionAgent
Role: Handle the progression of squads, XP gain and promotion to
legendary status
GitHub
.

Skills: Tracking combat outcomes, updating squad properties, interfacing
with UI to show squad status on the PDA, and adjusting spawn rates based on
squad strength. Must coordinate with logistics and resource systems.

Inputs:

Events from combat or task completion (likely exposed via
simulation_objects.script or smart_terrain.script).

Existing squad objects and classes from simulation_objects.script.

Outputs:

gamma_walo/gamedata/scripts/squad_progression.script – module to track
squad experience, promotions and special names.

Adjusted spawn logic that gives better equipment to high‑rank squads.

Busted tests ensuring XP accumulates correctly and that promotions
trigger UI updates.

UI updates: hooking into the PDA script to display legendary squads.

Procedures:

Extend squad objects with XP counters. On mission success or kill
events, increment XP. Determine thresholds for promotion to
legendary status.

When a squad becomes legendary, assign it a unique name and update its
entry in the global registry. Modify spawn logic so legendary squads
receive enhanced stats or gear.

Update the PDA UI to display legendary squads; hook into
ui_pda_diplomacy.script or create a new window.

Write tests for XP accumulation and promotion logic.

Document the module and update the changelog.

5. DiplomacyAgent
Role: Implement the Diplomacy & Player Faction system. This includes
player‑defined factions, declarations of war, tributes and alliances
GitHub
.

Skills: Game state management, UI design, negotiation algorithms and
interaction with faction reputation (goodwill) functions in the engine.

Inputs:

Faction philosophy configurations from the FactionPhilosophyAgent.

Goodwill and relation functions exposed by the engine
(relation_registry.set_community_relation, etc.).

Outputs:

gamma_walo/gamedata/scripts/diplomacy_system.script – module that
manages alliances, wars and tribute contracts.

UI elements in the PDA (dialogue windows and right‑click menus) for
diplomacy actions.

Tests verifying that diplomacy actions succeed only when resource
contracts are valid and that AI factions respond according to their
philosophies.

Procedures:

Define a Faction class with a philosophy, current allies, enemies,
pending offers and accepted tributes.

Implement functions for the player to create a custom faction by
selecting traits and philosophies. Use UI dialogs for selection.

Provide functions to send offers to AI factions: declare_war,
offer_tribute, request_assistance, etc. Use engine functions
from relation_registry and game to adjust goodwill
github.com
.

Implement AI negotiation logic: factions evaluate offers based on their
philosophies and current resource surplus.

Hook these actions into the right‑click menu on the PDA map; only
enable options for player‑owned territories
GitHub
.

Write tests simulating diplomacy scenarios and verifying state changes.

Document the system and update the changelog.

6. FactionPhilosophyAgent
Role: Define and load faction philosophies that influence AI
behaviour
GitHub
. Philosophies determine strategic
preferences and affect decisions across resource allocation, logistics,
squad composition and diplomacy.

Skills: Designing data‑driven configurations, writing influence
functions, interfacing with other systems.

Inputs:

Default philosophy descriptions from the design doc (Duty values
territory, weapons and medicine; Freedom prefers artifacts and herbs;
Monolith prioritises aggression and anomalies
GitHub
).

Faction lists from the base game (via db.faction_table or similar).

Outputs:

gamma_walo/gamedata/configs/faction_philosophies.ltx – LTX
configuration file defining philosophy weights (e.g. resource
priorities, aggression levels).

gamma_walo/gamedata/scripts/faction_philosophy.script – module that
loads the config and exposes functions to query philosophy values.

Tests ensuring philosophies load correctly and influence other systems.

Procedures:

Design a data schema for philosophies (e.g. each philosophy defines
weights for resource preference, aggression, diplomacy tolerance,
technology focus). Document this schema in the LTX file.

Write a loader function that reads the LTX file and stores values in
tables keyed by faction name.

Expose accessors: get_resource_priority(faction, resource),
get_aggression(faction), etc. These functions will be used by
logistics and diplomacy systems to modulate behaviour.

Provide a mechanism for mod authors to register new philosophies in
gamma_walo. Validate inputs to prevent missing keys.

Write tests verifying that philosophies are correctly parsed and returned.

Document the module and update the changelog.

7. UIAgent
Role: Extend the in‑game PDA and other interfaces to support new
actions. The UI must allow players to convert territories into resource or
base nodes, specialise bases, upgrade nodes, and perform diplomacy
interactions
GitHub
.

Skills: Modifying Anomaly’s XML and Lua‑based UI definitions,
triggering engine functions (e.g. map spot modifications), and ensuring a
polished user experience.

Inputs:

Existing UI scripts (runtime files/gamedata/scripts/ui_pda_diplomacy.script,
ui_pda_map.script, etc.) to serve as templates.

Resource, logistics and diplomacy system APIs.

Outputs:

Updated UI scripts in gamma_walo/gamedata/scripts and new XML
layouts under gamma_walo/gamedata/ui/ if necessary.

Right‑click context menu that calls the appropriate functions in other
modules.

Tests that simulate UI actions via script calls and verify state
changes (may rely on stubbed engine functions).

Procedures:

Audit existing PDA scripts to understand how to add context menu
entries and handle callbacks. Identify where level.map_add_object_spot
and related functions are used
github.com
.

Extend the map’s right‑click menu to include new entries: Establish Node, Specialize Node, Upgrade Node, Diplomacy…. These should
call into the resource, base and diplomacy agents.

Provide UI for custom faction creation and negotiation windows. Use
existing dialogues as templates.

Ensure that UI updates are only available for player‑owned nodes and
that options are greyed out when prerequisites are not met (e.g.
insufficient resources).

Write tests or simulation scripts that trigger UI events programmatically
and validate responses.

Document changes and update the changelog.

8. TestingAgent
Role: Maintain the automated test suite. Write Busted specs
(*.spec.script) for each module and orchestrate test execution. Validate
that behaviour matches expectations before tasks are marked complete
GitHub
.

Skills: Busted framework, mocking engine functions (since full
simulation may not be possible in tests), and asserting complex state.

Inputs:

Test specs written by each implementation agent.

Stubs or mocks for engine functions as necessary.

Outputs:

Execution of tests after each integration step with reports in
test_reports/.

Updates to agent_tasks.md indicating pass/fail status.

Suggestions for additional test coverage when bugs or crashes occur.

Procedures:

Provide a harness that loads Lua modules in isolation and supplies
dummy implementations of engine calls (e.g. level.add_call returns
immediately).

Run Busted tests after each commit or after a task is marked complete.

Record failures and route them back to the responsible agent for
debugging.

Generate coverage reports and identify untested code paths.

9. DocumentationAgent
Role: Ensure that all changes are properly documented. Generate
Markdown files summarising APIs, update CHANGELOG.md, and maintain
DevDiary.md with detailed logs of each agent’s work. This agent also
implements the DocGen profile mentioned in the README.

Skills: Technical writing, Markdown formatting, diffing, summarising
technical changes.

Inputs:

Output from DiffAnalysisAgent.

Change summaries and code comments from implementation agents.

Outputs:

Updated docs/runtime_vs_gamma_walo.md, docs/api_map.md, and other
system‑specific docs.

Appendices in CHANGELOG.md summarising each iteration.

DevDiary.md entries with chronological logs.

Procedures:

After each task is completed and tests pass, collect the commit
message, code diff and test results.

Update the central changelog with a concise summary and reference
impacted modules.

Expand the system documentation with new functions, parameters and
usage examples.

Maintain DevDiary.md as a narrative log, including rationales for
design decisions and notes on issues encountered.

These agents work together to implement a cohesive overhaul. The
agent_tasks.md document enumerates the exact steps each agent must follow.
Agents should always consult this profile before executing tasks and update
both the checklist and the documentation as they work. By adhering to
these profiles the project will maintain structure and long‑term
maintainability.



