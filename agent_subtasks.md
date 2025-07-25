# 🧠 G.A.M.M.A. Warfare: Agent Subtasks for Codex

This document defines specific, scoped tasks for Codex agents to implement in order to bring the Warfare Overhaul closer to feature completion. Each task below is a **standalone objective** but must be treated as part of the **GAMMA modpack integration**.  

## 📜 Task Execution Rules  
- All tasks must **integrate with the existing GAMMA modpack and Anomaly engine systems**.  
- Never build standalone systems: every feature must hook into existing engine callbacks, task systems, or data flows (as referencable under "Runtime Files")
- Prioritize **compatibility and stability** over abstraction or refactors.  
- If a change risks breaking GAMMA baseline scripts or MO2 overrides, **flag and document it**.
- always leave a modification Note in the header comment in each file you change
- Once a subtask is complete, the agent must:  
  1. Document what was added (with links to modified files).  
  2. Mark the checkbox as done ([x]) in this file.  
  3. Create a **Pull Request for review**.  

---

## 🀄 Overall Stability and Integration Checks (Static Analysis – 5-Pass Method)

**Goal:** Statically verify that all modifications in `gamma_walo` are compatible with the original files in `runtime files`. Ensure no regressions or invalid behavior changes were introduced without justification. **No runtime execution is required.**  

### ✅ Task Outline (5-Pass Static Validation)
 - [x] **Pass 1: Baseline Diff Mapping**
  - For each file in `gamma_walo`, locate the corresponding file in `runtime files`.  
  - Produce a side-by-side diff summary (function additions, deletions, modifications).  
  - Output: `diff_summary.json` or Markdown list.  

 - [x] **Pass 2: Signature & Callsite Audit**
  - For each modified function: extract parameters, return structure, and globals used.  
  - Grep all other scripts for references to this function.  
  - Validate that all callsites remain compatible.  
  - Output: `function_compat_report.md`.  

- [ ] **Pass 3: Nil Defense Elimination & Root Tracing**  
  - Identify functions where nil checks were added/altered.  
  - Trace the source of the nil state and fix upstream rather than band-aiding.  
  - Output: `root_cause_fixes.md`.  

- [ ] **Pass 4: Behavior Consistency Review**  
  - Compare logic and outputs of changed functions to their originals.  
  - Identify intentional vs unintentional changes.  
  - Output: `behavior_change_log.md`.  

- [ ] **Pass 5: Final Verification + Structured Report**  
  - Rerun diff, callsite, and consistency checks after fixes.  
  - Output: `final_integration_report.md` and list of confirmed compatible modules.  

**Constraints:**  
- 🚫 **No runtime execution** – purely static analysis.  
- 🧠 **Behavioral parity is mandatory** unless explicitly justified.  
- 🧽 No "just hide nil" fixes – always address the root cause.  
- 🔗 **Integration-first:** Ensure all changes hook into existing GAMMA engine systems.

---

## ✅ Resource Infrastructure System

- [x] **Implement Resource Node Upgrades**  
  - Add `.ltx` config values to define upgrade levels.  
  - Update `resource_system.script` to adjust daily output based on level.  
  - Add PDA interaction stub (UI to upgrade node).  

- [x] **Enhance HQ Logistics Commands**  
  - Allow HQ to prioritize base upgrades based on stockpile delta.  
  - Integrate upgrade decisions in `hq_coordinator.script`.  

---

## 🚚 Squad Logistics Simulation

- [ ] **Implement Squad Loot Recovery**  
  - When a transport squad dies, dropped items should be lootable.  
  - Patrol squads that pass the body should collect dropped resources.  
  - 🔗 Must tie into **existing death and loot callbacks** in GAMMA.  

- [ ] **Add Dynamic Rerouting Logic**  
  - Reroute transports on death or danger.  
  - Integrate reroute logic into `squad_transport.script`.  
  - Ensure reroutes respect GAMMA faction and AI task systems.  

- [ ] **Implement Multi-resource Payloads**  
  - Allow HQ to bundle multiple needed resources into a single transport.  
  - Maintain compatibility with existing HQ request flow.

---

## 🎖️ Squad Progression & Legendary System

- [ ] **Link Legendary Squads to Morale System**  
  - Increase morale when legendary squads succeed.  
  - Drop morale if they die.  
  - Ensure morale changes integrate with GAMMA’s faction morale state.  

- [ ] **Display Legendary Squads on PDA**  
  - Add visual highlight or badge.  
  - Display custom squad names in UI.  

---

## 🤝 Diplomacy & Player Faction

- [ ] **Build Full Diplomacy UI**  
  - Add action buttons for declare war, offer tribute, form alliance.  
  - Connect UI to functions in `diplomacy_core.script`.  
  - Use existing PDA hooks, don’t create standalone menus.  

- [ ] **Implement AI Acceptance Logic**  
  - Trade offers accepted/rejected based on faction state.  
  - Use `faction_philosophy.script` weights and stockpiles.  

- [ ] **Player Faction Creation Tool**  
  - Let user define faction name, philosophy, and starting allies.  
  - Store config in save state or startup file.  

---

## 🧠 Faction Philosophy System

- [ ] **Move Philosophy to Config Files**  
  - Use `.ltx` files to externalize weights for aggression, resource preferences, etc.  
  - Update `faction_philosophy.script` to read from config.  

- [ ] **Integrate Philosophy into AI Decisions**  
  - Use preferences during:  
    - Node specialization  
    - Diplomacy decisions  
    - Expansion targeting  

---

## 🔧 Testing, Debugging & Docs

- [ ] **Complete Placeholder Test Files**  
  - Add real tests to `*_spec.lua` files.  
  - Use example node and squad objects to simulate logic paths.  

- [ ] **Expand UI Documentation**  
  - Document all PDA interactions.  
  - Describe available diplomacy and squad options.  

---

## 🌍 World Design + Events

- [ ] **Trigger Conflict Events**  
  - Add dynamic raid, ambush, or escort tasks using `meta_overlord.script`.  
  - Ensure events hook into existing task and reward systems.  

- [ ] **Display Resource Levels on PDA**  
  - Create overlay that shows stockpile state per node.  
  - Tie into `pda_context_menu.script`.  

---

### Completion Rules  
When each subtask is complete, Codex should:  
1. Document code changes.  
2. Mark the checkbox as done `[x]`.  
3. Create PR titled: `Subtask: <name>` and link any related documentation.  
