# **Agent Profiles for the G.A.M.M.A. Warfare Overhaul**

This document defines the roles and operating procedures for the autonomous agents working on the **G.A.M.M.A. Warfare Overhaul**.  
Agents must implement features, integrate systems, and maintain compatibility with STALKER Anomaly’s GAMMA runtime at all times.  

Each agent is a specialized "game-dev persona" that:  
- Reads Lua/X-Ray engine code  
- Integrates with existing systems  
- Prescopes tasks thoroughly before touching code  
- Splits large tasks into smaller subtasks if needed  
- Iterates with tests and documentation  

---

## **Task Selection Workflow (Priority + Recursive Splitting)**

### **Step 1: Scan `agent_tasks.md`**
1. Look for any `[a]` (blocked) task.  
   - If **none exist**, pick a `[ ]` (not started) task with the **highest weight** and start from there.  
   - If **one exists**, this is a blocking task → jump into `agent_prio.md`.

### **Step 2: Scan `agent_prio.md` (only if a `[a]` task exists in agent_tasks.md)**
1. Find the corresponding `[a]` parent task from `agent_tasks.md`.  
2. Take its **direct child subtasks** that are `[ ]` (not started).  
3. Pick the child task with the **highest weight**.

### **Step 3: If the selected task in `agent_prio.md` is also `[a]`**
1. Look at its direct children subtasks.  
2. Pick one `[ ]` subtask with the highest weight.  
3. Repeat this process recursively until you reach a `[ ]` task that can be executed.  

### **Step 4: If a task explodes in scope**
1. Mark the current task `[a]` (blocked).  
   - This applies also to child tasks in `agent_prio.md`.  
   - Should a child task be too complex, also mark it `[a]` and add new `[ ]` subtasks directly below it.  
2. Split it into **multiple `[ ]` subtasks directly below it** in the same file (`agent_prio.md`).  
3. Assign each subtask a weight and document the dependencies.  
4. STOP. Future runs will pick the new subtasks.  

---

### ⚠️ **Step 5: When finishing a child task**
1. Note its completion in:
   - `DevDiary.md` (with a short description)
   - `CHANGELOG.md` (with a one-line summary)
   - Any relevant docs in `/docs/`
2. **Remove the completed child task from `agent_prio.md`.**

> **Why?**  
> This keeps `agent_prio.md` clean and prevents agents from re-running already completed subtasks.

---

### **Weighting System**
- **Weight 1–1000:** Represents importance and complexity.
  - **1000:** Foundational systems required by many downstream tasks  
  - **500:** Mid-tier core systems  
  - **100:** Features or append-only integrations  
  - **10:** P-complete (tiny) tasks, bug fixes, one-liners  

> **Agents always pick the highest-weight `[ ]` task available at their current level.**

---

## **General Guidelines**

### **Language & framework**
- All work is in **Lua** (X-Ray engine).  
- Integrate with engine hooks via `level.*`, `relation_registry.*`, etc.  
- Maintain strict compatibility with GAMMA’s baseline runtime.

### **Prescoping**
- **Always follow `prescope_workflow.md` before touching code.**
- If you can’t prescope, STOP and mark the task `[a]`.  

### **Documentation & Testing**
- Every function must be commented (purpose, params, return, side-effects).  
- Maintain Busted specs for all modules.  
- Update `DevDiary.md`, `CHANGELOG.md` and `/docs` for every task.  

### **Crashes**
- If a crash occurs:  
  1. Save the log in `runtime_crashes/`  
  2. Mark the current task `[a]`  
  3. Create a “Fix crash” subtask in `agent_prio.md`  

---

## **Agents**

### **1. DiffAnalysisAgent**
- **Role:** Compare `runtime files/`, `old_walo/` and `gammas_patch/` to identify conflicts.  
- **Outputs:** `docs/runtime_vs_gamma_walo.md`, `docs/api_map.md` and new subtasks in `agent_prio.md` if conflicts are found.

### **2. ResourceInfrastructureAgent**
- **Role:** Implement `resource_system.script` (nodes, bases, HQ).  
- **Dependencies:** Must hook into territory capture & simulation events.  
- **Outputs:** Core resource APIs, tests, and `docs/resource_system.md`.

### **3. LogisticsAgent**
- **Role:** Implement `logistics_system.script` (transport squads, ambushes, rerouting).  
- **Dependencies:** Requires stockpile APIs from `ResourceInfrastructureAgent`.  

### **4. SquadProgressionAgent**
- **Role:** Implement `squad_progression.script` (XP, promotions, legendary squads).  

### **5. DiplomacyAgent**
- **Role:** Implement `diplomacy_system.script` (alliances, wars, tribute, player faction).  

### **6. FactionPhilosophyAgent**
- **Role:** Implement `faction_philosophy.script` and `.ltx` configs for AI behavior biases.  

### **7. UIAgent**
- **Role:** Extend PDA and menus with new actions and displays.  

### **8. TestingAgent**
- **Role:** Run Busted specs and block all agents if tests fail.  

### **9. DocumentationAgent**
- **Role:** Update all documentation, changelogs, and dev diaries.  

---

### **Example: Priority Cascade**

**agent_tasks.md**
```
[a] Implement Logistics System
```

**agent_prio.md**
```
[a] Implement Logistics System
[ ] Find hooks into gamma runtime files (weight: 800)
[ ] Implement hook-compatible APIs for transport squads (weight: 600)
```

**agent_prio.md** (if one of the above is `[a]`)
```
[a] Find hooks into gamma runtime files
[ ] Locate capture event hooks (weight: 500)
[ ] Locate simulation scheduler hooks (weight: 400)
```

**Workflow:**  
1. Agents first see `[a] Implement Logistics System` in `agent_tasks.md`.  
2. They jump into `agent_prio.md` and pick the highest-weight child (`Find hooks`).  
3. If that child is `[a]`, they go deeper and pick the highest-weight subchild (`Locate capture event hooks`).  
4. If a task explodes in scope, it is split further.  

**After finishing `Locate capture event hooks`:**
- It is **removed** from `agent_prio.md`.  
- A note is added to `DevDiary.md` and `CHANGELOG.md`.

**agent_prio.md (after cleanup)**
```
[a] Find hooks into gamma runtime files
[ ] Locate simulation scheduler hooks (weight: 400)
```

---

**This ensures:**  
- Agents never skip blockers.  
- Large tasks are split automatically.  
- Completed child tasks don’t pollute `agent_prio.md`.  
- We always work from the most foundational (highest-weight) tasks downward.  
