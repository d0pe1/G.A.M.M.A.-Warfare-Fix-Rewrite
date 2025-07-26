**Agent Profiles for the G.A.M.M.A. Warfare Overhaul**

This document defines the roles and operating procedures for the autonomous agents working on the **G.A.M.M.A. Warfare Overhaul**.  
Agents must implement features, integrate systems, and maintain compatibility with STALKER Anomaly’s GAMMA runtime at all times.  

Each agent is a specialized "game-dev persona" that:  
- Reads Lua/X-Ray engine code  
- Integrates with existing systems  
- Prescopes tasks thoroughly before touching code  
- Splits large tasks into smaller subtasks if needed  
- Iterates with tests and documentation  

---

## **Task Selection Workflow (Priority + Recursive Splitting + Indentation)**

### **Step 1: Scan `agent_tasks.md`**
1. Look for any `[a]` (blocked) task.  
   - If **none exist**, pick a `[ ]` (not started) task with the **highest weight** and start from there.  
   - If **one exists**, this is a blocking task → jump into `agent_prio.md`.

---

### **Step 2: Scan `agent_prio.md` (only if a `[a]` task exists in agent_tasks.md)**

1. Find the corresponding `[a]` parent task from `agent_tasks.md`.  
2. Sort all tasks **by indentation depth (deepest first)**:
   - Tasks with more indentation are children → **process these before shallower ones**.  
3. If any child task is `[x]`, investigate:
   - If work is complete and notes exist in `DevDiary.md`/`CHANGELOG.md`, **remove it from `agent_prio.md`**.
   - If work is incomplete, revert it to `[ ]`.  
4. From remaining tasks at the deepest indentation level:
   - Pick the `[ ]` task with the **highest weight**.

---

### **Step 3: If the selected task in `agent_prio.md` is also `[a]`**
1. Look at its direct children (one indentation level deeper).  
2. Pick one `[ ]` subtask with the highest weight.  
3. Repeat this process recursively until you reach a `[ ]` task that can be executed.  

---

### **Step 4: If a task explodes in scope**
1. Mark the current task `[a]` (blocked).  
   - This applies also to child tasks in `agent_prio.md`.  
2. Split it into **multiple `[ ]` subtasks** directly below it:  
   - **Indent each subtask one level deeper (two spaces)** than the parent.  
3. Assign each subtask a weight and document dependencies.  
4. STOP. Future runs will pick the new subtasks.

---

### **Step 5: When finishing a child task**
1. Note its completion in:
   - `DevDiary.md` (short description)  
   - `CHANGELOG.md` (one-line summary)  
   - Any relevant `/docs` files  
2. **Remove the completed child task from `agent_prio.md`.**
3. If a parent [a] task has no children left, flip it to [ ] and continue execution as usual, if, for any reason -  this is not expected behavior - a child task left in agent_prio.md has '[x]' Status, investigate if either:
    -task has actually been solved and can be removed (check DevDiary.md and Changelog.md and compare against Intent of subtask)
    -task needs further development => write down tasks as children subtasks into agent_prio.md so we don't loose tasks and scope.
4. When unblocking a Parent Task, by completing it's last child, note in DevDiary.md and Changelog.md that it happened

> **Why:**  
> This keeps `agent_prio.md` clean and enforces proper inheritance between parent/child tasks.

---

### **Weighting + Indentation Rules**
- **Weight 1–1000:** Represents importance and complexity.
  - **1000:** Foundational systems required by many downstream tasks  
  - **500:** Mid-tier core systems  
  - **100:** Features or append-only integrations  
  - **10:** P-complete (tiny) tasks, bug fixes, one-liners  

- **Indentation:**  
  - 0 spaces = top-level task from `agent_tasks.md`  
  - 2 spaces = child subtask  
  - 4 spaces = sub-subtask, and so on  

> **Agents always:**  
> - Process **deepest** (most-indented) tasks first.  
> - Pick the highest-weight `[ ]` task at that depth.  
> - Clean up `[x]` tasks immediately.

---

## **General Guidelines**

### **Language & framework**
- All work is in **Lua** (X-Ray engine).  
- Integrate with engine hooks via `level.*`, `relation_registry.*`, etc.  
- Maintain strict compatibility with GAMMA’s baseline runtime.

---

### **Task IDs & Cross-Linking**
- Each task gets a unique Task ID `<TASKSET>-<NUMBER>`:
  - `<TASKSET>` = the parent task label (e.g., WALO, LOG, DIPLO)
  - `<NUMBER>` = incrementing number for that set.
- Agents must:
  1. Insert the Task ID at the start of every task/subtask line in `agent_tasks.md` and `agent_prio.md`.
  2. When marking a task `[x]`, copy the line to `DevDiary.md`:
     - Preserve indentation hierarchy from `agent_prio.md`.
     - Add date and summary of what was done.
  3. Add a one-line entry to `CHANGELOG.md` referencing the Task ID.

---

### **Prescoping**
- **Always follow `prescope_workflow.md` before touching code.**
- If you can’t prescope, STOP and mark the task `[a]`.  

---

### **Documentation & Testing**
- Every function must be commented (purpose, params, return, side-effects).  
- Maintain Busted specs for all modules.  
- Update `DevDiary.md`, `CHANGELOG.md` and `/docs` for every task completed or when splitting tasks into smaller tasks.  

---

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

### **Example: Priority Cascade with Indentation**

**agent_tasks.md**
[a] Implement Logistics System

**agent_prio.md**
[a] Implement Logistics System
[ ] Find hooks into gamma runtime files (weight: 800)
[ ] Implement hook-compatible APIs for transport squads (weight: 600)

**agent_prio.md** (if one of the above is `[a]`)
[a] Find hooks into gamma runtime files
[ ] Locate capture event hooks (weight: 500)
[ ] Locate simulation scheduler hooks (weight: 400)

**Workflow:**  
- Agents first see `[a] Implement Logistics System` in `agent_tasks.md`.  
- They jump into `agent_prio.md` and pick the deepest, highest-weight task:  
  `Locate capture event hooks (weight: 500)`.  
- After finishing it:  
  - Remove it from `agent_prio.md`.  
  - If no siblings remain, revert the parent `[a]` to `[ ]`.

---

**This ensures:**  
- Agents always process deepest → shallowest tasks.  
- Parent tasks revert when all children are done.  
- `agent_prio.md` is always sorted and clean.  
- Large tasks are split automatically and tracked visually with indentation.
"""
