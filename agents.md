# **Agent Profiles for the G.A.M.M.A. Warfare Overhaul**

This document defines the scope, responsibilities and working practices for the autonomous agents that will implement the **G.A.M.M.A. Warfare Overhaul** for STALKER Anomaly.  
The overhaul introduces new systems (resource infrastructure, squad logistics, progression, diplomacy and faction philosophies) and aims to integrate and modernise code from multiple sources (`old_walo`, `gammas patch` and the existing `runtime files`) **without breaking compatibility**.  

Each agent is modelled as a **game‑developer specialist** that writes Lua scripts, integrates with the X‑Ray engine API, updates documentation and tests, and iteratively improves the codebase.  

---

## **General Guidelines**

### **Language & framework**
- Implementation is in **Lua**, running inside the **X‑Ray engine**.
- Use engine functions via the `level` namespace (e.g. `level.map_add_object_spot`, `spawn_item`) and related modules (documented in X‑Ray’s Lua help).

### **Data flow awareness**
- Systems are **interdependent**.  
  *Example:* Resource nodes feed logistics, which enable squad spawns and affect diplomacy.  
- Agents must **expose clear interfaces** and avoid hidden dependencies.

### **Prescoping & Blocking Tasks**
- **Prescope HARD before coding:**  
  1. Identify all file/module dependencies.  
  2. Identify required engine hooks.  
  3. Identify upstream/downstream systems that could break.  
  4. Determine required tests.  

- If you discover that another agent or system must act first:  
  - Mark your task as **`[a]` (blocked)** in `agent_tasks.md`.  
  - Add the required **blocking task(s)** to `agent_prio.md` with dependencies and resolution criteria.  

- Agents must **scan `agent_prio.md` first** on every run. Unresolved priority tasks always take precedence.

### **Documentation & testing**
- Every function must be documented with:
  - Purpose  
  - Parameters & return value  
  - Side effects  

- Each module must have a **Busted test file**.  
- When a file changes, update:
  - `CHANGELOG.md`  
  - `DevDiary.md` with detailed narrative  
  - Relevant docs in `/docs`  

### **Iteration**
- Work incrementally: Plan → Execute → Test → Fix → Document.  
- Do **not move forward** if crash logs exist or tests fail.  
- Mark tasks as `[x]` only when stable.  

### **Error handling**
- If runtime crash logs appear in `runtime_crashes/`:  
  1. Mark the current task `[a]` (blocked).  
  2. Add a "Fix crash" priority entry in `agent_prio.md`.  
  3. Fix before continuing.

---

## **Agents**

### **1. DiffAnalysisAgent**
**Role:** Identify differences between the three source trees (`runtime files`, `old_walo`, `gammas patch`) and generate machine‑readable reports. Annotate conflicts and missing implementations.  

**Skills:** Lua syntax familiarity, file diffing, reading `.script` and `.ltx` files, writing Markdown. Awareness of Anomaly’s script loading order.  

**Inputs:**  
- `runtime files/` – baseline GAMMA scripts  
- `old_walo/` – Vintar’s Warfare A‑Life overhaul  
- `gammas patch/` – GAMMA team patch scripts  

**Outputs:**  
- `docs/runtime_vs_gamma_walo.md` – full diff report  
- `docs/api_map.md` – map runtime functions to modules & engine hooks  
- Updates `agent_tasks.md` and `agent_prio.md` with discovered conflicts  

**Procedures:**  
1. Run Analyzer profile (or implement a diff script in Lua/Python).  
2. For each file in `old_walo` and `gammas patch`, compare against `runtime files`.  
3. Note changed/removed functions and behaviour.  
4. Populate `docs/runtime_vs_gamma_walo.md` and `docs/api_map.md`.  
5. Add `[a]` tasks to `agent_prio.md` if unresolved conflicts block integration.

---

### **2. ResourceInfrastructureAgent**
**Role:** Implement the Resource Infrastructure System. Introduces resource & base nodes that produce resources and enable faction capabilities.  

**Skills:** Object‑oriented Lua, data modelling, territory capture hooks, timers for resource output, compatibility with `simulation_objects.script`.  

**Inputs:**  
- DiffAnalysisAgent output  
- `sim_board.script` and `simulation_objects.script`  
- `SystemsDesign.md` design spec  

**Outputs:**  
- `gamma_walo/gamedata/scripts/resource_system.script`  
- Updated capture/lose territory event hooks  
- Config files for yields and upgrades  
- Busted tests, `docs/resource_system.md`  

**Procedures:**  
1. Define classes: `ResourceNode`, `BaseNode`, `HQNode`.  
2. Hook into capture events (via `sim_board.script`).  
3. Implement daily resource generation (`level.add_call`).  
4. Add APIs for other modules (e.g. `resource_system.get_node`).  
5. Mark `[a]` and add to `agent_prio.md` if LogisticsAgent APIs are missing.  
6. Write tests for depletion, looting, faction bias.

---

### **3. LogisticsAgent**
**Role:** Implement the Squad Logistics Simulation: transport squads move resources to bases, handle ambushes, rerouting, and drops.  

**Skills:** Pathfinding, AI state machines, spawning squads/items, concurrency-safe scheduling.  

**Inputs:**  
- Resource stockpiles (ResourceInfrastructureAgent)  
- `simulation_objects.script`  
- Spawn logic from `sim_board.script`  

**Outputs:**  
- `gamma_walo/gamedata/scripts/logistics_system.script`  
- Adjusted spawn logic  
- Tests and `docs/logistics_system.md`  

**Procedures:**  
1. Define `TransportSquad` class (cargo, route, timers).  
2. Spawn squads when stockpiles exceed thresholds.  
3. Pathfinding using engine graph functions.  
4. Handle ambushes (drop cargo, pickup by others).  
5. Allow HQ rerouting hooks.  
6. Add `[a]` if ResourceInfrastructureAgent APIs not yet implemented.  

---

### **4. SquadProgressionAgent**
**Role:** Handle squad XP gain, promotions, legendary status, and PDA display.  

**Skills:** Combat event hooks, updating squad stats, UI integration.  

**Outputs:**  
- `gamma_walo/gamedata/scripts/squad_progression.script`  
- Tests and UI updates  

---

### **5. DiplomacyAgent**
**Role:** Implement Diplomacy & Player Faction system: alliances, wars, tribute agreements.  

**Skills:** Game state management, UI menus/dialogs, goodwill adjustment.  

---

### **6. FactionPhilosophyAgent**
**Role:** Define philosophies affecting AI decisions (resource bias, aggression, diplomacy).  

**Outputs:**  
- `faction_philosophies.ltx` and `faction_philosophy.script`  

---

### **7. UIAgent**
**Role:** Extend PDA and context menus for all new actions (nodes, upgrades, diplomacy).  

---

### **8. TestingAgent**
**Role:** Maintain Busted test suite.  
- Blocks all agents if failures appear → `[a]` until fixed.  

---

### **9. DocumentationAgent**
**Role:** Maintain `DevDiary.md`, `CHANGELOG.md`, `/docs/` and auto‑generate API references.  

---

## **Workflow Notes**

- Agents must **prescope tasks hard**: list dependencies, required APIs, and risks in `DevDiary.md`.  
- If **blocked**, immediately:  
  - Change status to `[a]` in `agent_tasks.md`.  
  - Add entry in `agent_prio.md` with exact resolution criteria.  

- Agents **scan `agent_prio.md` first** on every run.  
- Tasks from `agent_prio.md` take **absolute priority** before any others.  

---

### **Example of Blocking**

[~] LogisticsAgent: implement transport squad ambush handling
[a] Blocked: requires ResourceInfrastructureAgent API for node stockpiles
↳ Added blocking task: agent_prio.md#resource_api_hook
