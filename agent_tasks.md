# Agent Task Checklist

This checklist breaks down the implementation of the **G.A.M.M.A. Warfare Overhaul** into discrete, verifiable steps.  
Each task should be assigned to an agent defined in `agents.md`. When a task is complete and its tests pass, mark the checkbox and append a note in `DevDiary.md`.

---

## **1. Setup & Diff Analysis**

- [ ] **Clone baseline** – Create the `gamma_walo` directory by copying the baseline files from `runtime files` *(old walo will tell you which files are used rn to build warfare mode)*.
- [ ] **Run Analyzer profile** – Execute the Analyzer script to generate `docs/runtime_vs_gamma_walo.md` comparing `runtime files`, `old_walo` and `gammas patch`.  
  - If the Analyzer script is missing, implement a diff script in Python or Lua.
- [ ] **Generate API map** – Scan all scripts under `runtime files/gamedata/scripts` and produce `docs/api_map.md` listing functions and the modules that call them.  
  - Pay attention to engine hooks such as `level.map_add_object_spot` and `spawn_item`.
- [ ] **Identify conflicts** – For every file in `old_walo` and `gammas patch` that differs from the runtime baseline, summarise the changes and note possible merge strategies *(replace vs merge functions)*. Add corresponding subtasks under the relevant system below.
- [ ] **Update agent tasks** – Add any missing tasks discovered during the diff (e.g. bug fixes, missing features) to the appropriate section.

---

## **2. Integration of Existing Mods**

Use these tasks to port changes from `old_walo` and `gammas patch` into `gamma_walo` without breaking compatibility:

- [ ] **WALO port** – For each script in `old_walo`, examine differences from `runtime files` and create a plan to integrate beneficial features. Apply modern code style and ensure compatibility with new systems.
- [ ] **Gamma patch port** – For each script in `gammas patch`, identify fixes or features that should be preserved. Integrate them into `gamma_walo`, ensuring they do not conflict with WALO changes.
- [ ] **Modernise code** – While porting, update outdated Lua idioms *(e.g. replace global variables with module tables, use local references, avoid `tonumber` misuses)* as long as the behaviour remains unchanged downstream.

---

## **3. Resource Infrastructure System**

Implement the resource and base infrastructure described in the design spec:

- [ ] **Create module** – Add `gamma_walo/gamedata/scripts/resource_system.script`. Define classes:
  - `ResourceNode`
  - `BaseNode`
  - `HQNode`
  - with fields for owner, stockpile, level and type.
- [ ] **Territory hook** – Modify or wrap the territory capture logic in `sim_board.script` to call:
  - `resource_system.on_capture(terrain_id, faction)`
  - `resource_system.on_loss(...)`
- [ ] **Daily generation** – Implement a timer using `level.add_call` (or equivalent) to trigger daily resource generation. Resource yield should depend on node type, upgrade level and faction philosophy.
- [ ] **Conversion & specialisation** – Expose functions to convert neutral nodes into resource or base nodes, and to specialise bases *(militia, research or trader)*. Check resource cost before allowing conversion.
- [ ] **Resource bias** – Incorporate faction philosophy biases into resource allocation *(e.g. Duty prioritises weapons/medicine, Freedom values artifacts and herbs)*.
- [ ] **Edge cases** – Handle node depletion, looting by other factions, contested status and upgrades. Ensure nodes are removed from the global table when lost.
- [ ] **Config files** – Create `.ltx` files describing default yields, upgrade costs and specialisation modifiers. Load them on system initialisation.
- [ ] **Write tests** – Write a Busted spec that mocks territory capture events, generates resources for multiple days and verifies stockpile changes and depletion behaviour.
- [ ] **Document** – Write `docs/resource_system.md` summarising the API, and update `CHANGELOG.md` and `DevDiary.md`.

---

## **4. Logistics System**

Build the transport and supply simulation to move resources from nodes to bases:

- [ ] **Create module** – Add `gamma_walo/gamedata/scripts/logistics_system.script`.  
  Define class `TransportSquad` with fields for cargo, route and timers.
- [ ] **Spawn transport squads** – When a node stockpile exceeds a threshold, schedule a transport squad.  
  Use `spawn_item` or `spawn_phantom` to spawn in‑game squads and assign them routes.
- [ ] **Pathfinding** – Determine safe routes using graph functions available in `simulation_objects.script` and the engine’s vertex APIs. Avoid territories controlled by hostile factions.
- [ ] **Ambush & fallback** – Implement logic to drop cargo on squad death and allow other squads to pick it up. If a route is blocked, reroute via HQ orders.
- [ ] **HQ rerouting hook** – Expose a function for HQ nodes to override transport routes when necessary.
- [ ] **Write tests** – Simulate transports in tests, verifying cargo delivery, drop/pick‑up behaviour and rerouting.
- [ ] **Document** – Write `docs/logistics_system.md` and update changelogs and `DevDiary.md`.

---

## **5. Squad Progression**

Implement squad XP, ranking and legendary promotions:

- [ ] **Create module** – Add `gamma_walo/gamedata/scripts/squad_progression.script`.  
  Extend squad objects with fields for xp and rank.
- [ ] **XP accumulation** – Listen to combat or mission success events and increment XP accordingly.  
  Determine thresholds for rank ups and legendary status.
- [ ] **Promotion effects** – When promoted, assign unique names and increase stats or equipment tiers. Update the global squad registry.
- [ ] **PDA integration** – Modify the PDA UI to display legendary squads, possibly via a new tab or overlay.
- [ ] **Write tests** – Simulate multiple combat events and ensure XP and promotions behave as expected.
- [ ] **Document** – Write `docs/squad_progression.md` and update changelog and dev diary.

---

## **6. Diplomacy & Player Factions**

Create systems for alliances, wars and tribute agreements:

- [ ] **Create module** – Add `gamma_walo/gamedata/scripts/diplomacy_system.script`.  
  Define a `Faction` class with properties for allies, enemies, philosophy, resources and current contracts.
- [ ] **Custom faction creation** – Provide UI to select starting traits, allies/enemies and philosophy. Create appropriate config files.
- [ ] **Actions implementation** – Implement functions `declare_war`, `offer_tribute`, `request_assistance`, etc.  
  Adjust goodwill using engine functions:  
  `relation_registry.change_community_goodwill`.
- [ ] **AI negotiation** – Add evaluation logic so AI factions accept or reject offers based on their philosophy and current needs.
- [ ] **PDA integration** – Add a diplomacy context menu and negotiation dialogs to the PDA. Only enable options when the player owns the node.
- [ ] **Write tests** – Simulate diplomacy offers and validate state changes and goodwill adjustments.
- [ ] **Document** – Write `docs/diplomacy_system.md` and update changelog and dev diary.

---

## **7. Faction Philosophy**

Define data‑driven philosophies that influence AI decisions:

- [ ] **Create config** – Write `gamma_walo/gamedata/configs/faction_philosophies.ltx` defining weightings for resource priorities, aggression and diplomacy for each faction.  
  Include the default philosophies for Duty, Freedom and Monolith.
- [ ] **Create loader** – Add `gamma_walo/gamedata/scripts/faction_philosophy.script` to read the LTX and provide accessors.
- [ ] **Register philosophies** – Provide a function to register new philosophies dynamically (for future mods) and validate input.
- [ ] **Integrate with other systems** – Ensure logistics, resource and diplomacy systems query the philosophy module for guidance.
- [ ] **Write tests** – Verify that philosophies load correctly and influence resource biases, logistic decisions and diplomacy.
- [ ] **Document** – Write `docs/faction_philosophy.md` and update changelog and dev diary.

---

## **8. User Interface Updates**

Modify the UI to support new actions:

- [ ] **Context menu entries** – Add *Establish Node*, *Specialize Node*, *Upgrade Node* and *Diplomacy…* to the map’s right‑click menu. Ensure they call the corresponding functions in the resource, base and diplomacy modules.
- [ ] **Custom faction creation UI** – Implement dialogs to choose traits and philosophy when the player forms a new faction.
- [ ] **Diplomacy dialogs** – Create windows for sending offers, viewing contracts and responding to AI proposals.
- [ ] **Legendary squad display** – Add a UI element to show legendary squads and their status.
- [ ] **Greyed‑out states** – Ensure UI disables actions when prerequisites (e.g. ownership, resources) are not met.
- [ ] **Write tests** – Simulate UI calls where possible using stubbed functions to validate that actions are triggered and state changes occur.
- [ ] **Document** – Write `docs/ui_updates.md` and update changelog and dev diary.

---

## **9. Testing & Debugging**

Ensure quality with automated tests and crash handling:

- [ ] **Set up test harness** – Create a harness that loads each module with mocked engine functions so tests can run outside the game.
- [ ] **Write Busted specs** – For every new module (`resource_system`, `logistics_system`, `squad_progression`, `diplomacy_system`, `faction_philosophy`), write corresponding `*.spec.script` files.
- [ ] **Run tests** – Execute tests after each feature is implemented. Record results and update `agent_tasks.md` with pass/fail status.
- [ ] **Monitor crash logs** – Watch the `runtime crashes` folder for new engine logs. When a crash occurs, open the log, identify the stack trace and assign a bug fix task to the responsible agent.
- [ ] **Add regression tests** – When bugs are fixed, add tests to prevent regressions.

---

## **10. Documentation & Logging**

Keep documentation and logs up to date:

- [ ] **Update docs** – After each feature is implemented and tests pass, update the relevant documentation in `docs/` (system API docs, runtime vs gamma diff, API map, UI docs etc.).
- [ ] **Append changelog** – Add a concise entry to `CHANGELOG.md` summarising the change and linking to the relevant module.
- [ ] **Write dev diary** – Append a detailed narrative of the change to `DevDiary.md`. Include the rationale, design decisions, test results and any challenges encountered.
- [ ] **Maintain consistency** – Ensure code comments and documentation match the final implementation. When interfaces change, update usage examples accordingly.

---

**Following this checklist will gradually build the full Warfare Overhaul.  
Agents should tick tasks as they complete them and add new subtasks when analysis uncovers additional work.**
