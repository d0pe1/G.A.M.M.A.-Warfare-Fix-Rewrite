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
- All agents must follow the **[Prescope Workflow](prescope_workflow.md)** before writing any code.  
- Prescoping must be recorded in `DevDiary.md` or `prescope_<task>.md`.  
- If a task is blocked by dependencies:
  - Mark it as `[a]` (blocked) in `agent_tasks.md`
  - Add a blocking entry with resolution criteria to `agent_prio.md`  

- Agents must **scan `agent_prio.md` first** on every run.  
  Unresolved priority tasks always take precedence.

### **Documentation & testing**
- Document every function:
  - Purpose  
  - Parameters & return value  
  - Side effects  
- Maintain corresponding **Busted test files**.  
- Update `CHANGELOG.md`, `DevDiary.md`, and `/docs` whenever code changes.  

### **Iteration**
- Workflow: **Plan → Prescope → Implement → Test → Fix → Document**  
- Do not mark tasks `[x]` until stable.  
- Never advance if crash logs or failing tests exist.

### **Error handling**
- If runtime crash logs appear in `runtime_crashes/`:
  - Mark the task `[a]`  
  - Create a "Fix crash" entry in `agent_prio.md`  
  - Fix before continuing  

---

## **Agents**

> **Every agent procedure begins with:**  
> `0. Complete prescoping first (see prescope_workflow.md)`

---

### **1. DiffAnalysisAgent**
**Role:** Identify differences between `runtime files`, `old_walo`, `gammas patch` and produce reports.  

**Outputs:**  
- `docs/runtime_vs_gamma_walo.md`  
- `docs/api_map.md`  
- Updates `agent_tasks.md` & `agent_prio.md`  

**Procedures:**  
0. Complete prescoping  
1. Run Analyzer or diff script  
2. Compare and document conflicts  
3. Populate reports and create `[a]` tasks if blockers exist  

---

### **2. ResourceInfrastructureAgent**
**Role:** Implement the Resource Infrastructure System.  

**Outputs:**  
- `gamma_walo/gamedata/scripts/resource_system.script`  
- Updated hooks, configs, tests, `docs/resource_system.md`  

**Procedures:**  
0. Complete prescoping  
1. Implement ResourceNode, BaseNode, HQNode  
2. Hook into capture events  
3. Implement daily resource generation  
4. Add APIs for dependent systems  
5. Write tests and docs  

---

### **3. LogisticsAgent**
**Role:** Implement Squad Logistics: transport squads, ambush handling, rerouting.  

**Procedures:**  
0. Complete prescoping  
1. Define TransportSquad class  
2. Spawn squads from stockpile thresholds  
3. Implement pathfinding and ambush handling  
4. Write tests and docs  

---

### **4. SquadProgressionAgent**
**Role:** Squad XP gain, promotions, legendary status, PDA updates.  

**Procedures:**  
0. Complete prescoping  

---

### **5. DiplomacyAgent**
**Role:** Diplomacy & Player Faction system.  

**Procedures:**  
0. Complete prescoping  

---

### **6. FactionPhilosophyAgent**
**Role:** Define philosophies affecting AI decisions.  

**Procedures:**  
0. Complete prescoping  

---

### **7. UIAgent**
**Role:** Extend PDA and context menus for nodes, upgrades, diplomacy.  

**Procedures:**  
0. Complete prescoping  

---

### **8. TestingAgent**
**Role:** Maintain test suite and block others if failures exist.  

**Procedures:**  
0. Complete prescoping  

---

### **9. DocumentationAgent**
**Role:** Maintain all docs and logs.  

**Procedures:**  
0. Complete prescoping  

---

## **Workflow Notes**

- Agents **must** prescope: see [prescope_workflow.md](prescope_workflow.md)  
- Blocked tasks = `[a]` → `agent_prio.md` entry required  
- Always clear `[a]` tasks before picking anything new  

---

### **Example of Blocking**

[~] LogisticsAgent: implement transport squad ambush handling
[a] Blocked: requires ResourceInfrastructureAgent API for node stockpiles
↳ Added blocking task: agent_prio.md#resource_api_hook
