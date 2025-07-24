🧠 G.A.M.M.A. Warfare: Agent Subtasks for Codex

This document defines specific, scoped tasks for Codex agents to implement in order to bring the Warfare Overhaul closer to feature completion. Each task below can be executed as a standalone objective. Once complete, the agent should:

Document what was added

Mark the subtask as done (in-code or in a tracking file)

Create a Pull Request for review

✅ Resource Infrastructure System

[x] Implement Resource Node Upgrades

Add .ltx config values to define upgrade levels

Update resource_system.script to adjust daily output based on level

Add PDA interaction stub (UI to upgrade node)

[x] Enhance HQ Logistics Commands

Allow HQ to prioritize base upgrades based on stockpile delta

Integrate upgrade decisions in hq_coordinator.script

🚚 Squad Logistics Simulation

[ ] Implement Squad Loot Recovery

When a transport squad dies, dropped items should be lootable

Patrol squads that pass the body should collect dropped resources

[ ] Add Dynamic Rerouting Logic

Reroute transports on death or danger

Integrate reroute logic into squad_transport.script

[ ] Implement Multi-resource Payloads

Allow HQ to bundle multiple needed resources into a single transport

🎖️ Squad Progression & Legendary System

[ ] Link Legendary Squads to Morale System

Increase morale when legendary squads succeed

Drop morale if they die

[ ] Display Legendary Squads on PDA

Add visual highlight or badge

Display custom squad names

🤝 Diplomacy & Player Faction

[ ] Build Full Diplomacy UI

Add action buttons for declare war, offer tribute, form alliance

Connect UI to functions in diplomacy_core.script

[ ] Implement AI Acceptance Logic

Trade offers should be accepted or rejected based on faction state

Use faction_philosophy.script weights and stockpiles

[ ] Player Faction Creation Tool

Let user define faction name, philosophy, and starting allies

Store config in save state or startup file

🧠 Faction Philosophy System

[ ] Move Philosophy to Config Files

Use .ltx files to externalize weights for aggression, resource preferences, etc.

Update faction_philosophy.script to read from config

[ ] Integrate Philosophy into AI Decisions

Use preferences during:

Node specialization

Diplomacy decisions

Expansion targeting

🔧 Testing, Debugging & Docs

[ ] Complete Placeholder Test Files

Add real tests to *_spec.lua files

Use example node and squad objects to simulate logic paths

[ ] Expand UI Documentation

Document all PDA interactions

Describe available diplomacy and squad options

🌍 World Design + Events

[ ] Trigger Conflict Events

Add dynamic raid, ambush, or escort tasks using meta_overlord.script

[ ] Display Resource Levels on PDA

Create overlay that shows stockpile state per node

Tie into pda_context_menu.script

When each subtask is complete, Codex should:

Document code changes

Mark the checkbox as done ([x])

Create PR titled: Subtask: <Name>

Link changes to documentation if applicable
