# **Agent Task Checklist**

This checklist breaks down the implementation of the **G.A.M.M.A. Warfare Overhaul** into discrete, verifiable steps.  
Each task should be assigned to an agent defined in `agents.md`.  

## **Task Status Symbols**

- `[ ]` = Not started  
- `[~]` = In progress / Awaiting live test / User review needed  
- `[x]` = Completed, stable, tests pass  
- `[a]` = Blocked until **priority tasks** in `agent_prio.md` are resolved  

> **Rule:**  
> If a task is marked `[~]`, append an entry to `usertodo.md` describing what needs to be tested or confirmed manually.  
> If a task is marked `[a]`, create or update `agent_prio.md` to describe the blocking task(s) in detail (including dependencies and required outcomes).  

When a task is complete, update the checkbox and remove its entry from `usertodo.md` and/or `agent_prio.md`.  

---

## **0. Agent Workflow Rules (ALL AGENTS MUST FOLLOW)**  

Every agent must follow this **pre-scoping, compatibility-aware, self-checking workflow** before touching any code:  

### **Read context first**  
1. `README.md` → understand the purpose and architecture.  
2. `agents.md` → understand your role.  
3. `agent_tasks.md` → locate your assigned task(s).  
4. `docs/` (SystemsDesign.md, WorldDesign.md, api_map.md) → study the design and engine hooks.  
5. Inspect related code in `gamma_walo/`, `runtime files/`, `old_walo/`, and `gammas_patch/`.  

### **Pre-scope your task (write in `DevDiary.md` before you code)**  
- Identify dependencies: which files, modules, and functions will be touched.  
- Identify engine hooks: confirm which calls into the Anomaly engine (e.g. `level.map_add_object_spot`, `spawn_item`).  
- Identify side effects: what downstream systems could break if you change this?  
- Identify tests: what automated tests will confirm the feature works?  

> **Blocking tasks:**  
> If your pre-scope identifies that a **different agent or system** must complete work first, **mark your task `[a]`** and add a corresponding entry to `agent_prio.md`.  

### **Check compatibility**  
- Use `runtime_vs_gamma_walo.md` to check for differences vs. baseline.  
- If you detect a conflict, create a new subtask and mark `[a]` if you are blocked by its completion.  

### **Implement iteratively**  
- Modify only files in `gamma_walo/`.  
- Comment every function, modernize Lua style when safe.  
- Integrate with other systems: no "islands of logic."  

### **Self-check your work**  
- Write or update Busted specs (`*.spec.script`) for every new or modified module.  
- Run tests in a mocked engine environment.  
- If the game crashes, log it in `runtime_crashes/` and create a new "Fix crash" subtask marked `[a]` if others must resolve it.  

### **Update the repo**  
- Mark the task `[x]` when tests pass and no crashes occur.  
- Update headers in modified source files.  
- Update `CHANGELOG.md` and append detailed notes to `DevDiary.md`.  

---

## **How `[a]` Priority System Works**

1. If you **cannot complete a task** due to missing work or dependencies:  
   - Change its status to `[a]`.  
   - Create or update an entry in `agent_prio.md` describing:  
     - What blocking task(s) must be done.  
     - Which agent/system should handle it.  
     - Any test conditions to confirm it is resolved.  

2. Once the blocking tasks in `agent_prio.md` are complete:  
   - Update the status of the original `[a]` task back to `[ ]` or `[~]` and continue work.  

3. Agents must **always scan `agent_prio.md` first** and pick **unresolved priority tasks** before taking new work from `agent_tasks.md`.  

---

## **1–10. Task Sections**

The rest of the task sections (Setup & Diff Analysis → Documentation & Logging) remain as in your original checklist, but now every task can be:  

- `[ ]` → Not started  
- `[~]` → In progress  
- `[x]` → Complete  
- `[a]` → Blocked by a priority task  

---

### **Example**  

[~] Implement daily resource generation in resource_system.script
↳ Test timers in mocked environment
[a] Cannot continue: requires Logistics System (section 4) event hooks to be available
↳ Added blocking task: agent_prio.md#logistics_hooks
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
