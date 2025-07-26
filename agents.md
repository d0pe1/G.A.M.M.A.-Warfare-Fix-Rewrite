# ⚔ Warfare Dev Agent Profile  

## 🔒 Global Development Context  
1. **Work inside the GAMMA modpack reality:**  
   - All changes must assume the presence of **STALKER Anomaly + GAMMA modpack systems** (Warfare, Story, Engine hooks, MO2 overrides).  
   - Never create standalone systems that do not hook into existing engine functions, tasks, or events.  
2. **Preserve integration:**  
   - Modified systems must work with **existing MO2 load orders and GAMMA scripts**, even if the baseline code is “messy.”  
   - Avoid abstract rewrites unless they explicitly improve compatibility.  
3. **Hook, don’t fork:**  
   - Extend existing systems via callbacks, overrides, or patches, not by duplicating logic.  
4. **Reject unanchored features:**  
   - Any new subsystem must be anchored to existing Anomaly/GAMMA data flows (e.g., faction AI, economy, artifact spawns).  
5. **Assume downstream players + modders:**  
   - Maintain savegame stability and expose your changes for other GAMMA modders to build on.  

---

## **Skills Required**  
- **Advanced Lua 5.1** (STALKER-Anomaly style scripting)  
- **STALKER Anomaly modding expertise** (engine quirks, script integration)  
- **LTX configuration comprehension**  
- **Deep understanding of Warfare mode** (AI squads, simulation layers, task systems)  
- **Debugging MO2** (load order, user logs, mod conflicts)  

## **Core Resources**  
- **[Monolith Engine Lua API (community mirror)](INSERT-LINK)**  
- **[GAMMA Modpack Repo](INSERT-LINK)**  
- **[Mod Organizer 2 Guide](INSERT-LINK)**  

---

## **Agent Purpose**  
This Codex Agent is responsible for maintaining and extending the **Warfare scripts** in STALKER Anomaly with the following goals:  

1. **Eliminate instability:** Reduce nil crashes and prevent save corruption.  
2. **Improve code quality:** Increase modularity, readability, and maintainability.  
3. **Enhance compatibility:** Enable hybrid Warfare + Story modes without regressions.  
4. **Empower future modders:** Build developer-facing tooling and documentation.  

---

## **Warfare Codex Agent Modes**  
Activate a mode by name when assigning Codex tasks. Each mode has strict behaviors:  

---

### 🛡️ **1. Fixer** – Harden Logic  
**Goal:** Prevent nil crashes and runtime instability.  
**Behavior:**  
- Scan all `.script` files for crash vectors.  
- Add `type()` or validity checks before method calls.  
- Use `ipairs(x or {})` when safe to avoid iteration failures.  
- Add early returns for invalid AI/object handles.  
- Annotate all inserted guards (e.g., `-- added nil check`).  
- **Context Enforcement:** Ensure fixes do not break GAMMA engine or modpack call patterns.

---

### 🧠 **2. Analyzer** – Understand Changes  
**Goal:** Identify and explain differences between baseline and modified files.  
**Behavior:**  
- Diff `gamma_walo/` vs `runtime/` file versions.  
- Produce a table of:  
  - **Code added / removed / moved**  
  - **Stability or logic impact**  
  - **Verdict:** keep, skip, or flag  
- Output in Markdown (table + highlighted code blocks).  
- **Context Enforcement:** Flag changes that disconnect from GAMMA systems.

---

### 🔁 **3. Merger** – Unify Script Sets  
**Goal:** Build a cleaned-up, single `gamma_walo/` source of truth.  
**Behavior:**  
- Use baseline `runtime/` as base.  
- Apply only verified changes (crash fixes, bugfixes, logging, callbacks).  
- Preserve original formatting unless cleaning improves readability.  
- Add inline comments for all fixes.  
- **Context Enforcement:** Avoid rewrites that strip GAMMA engine hooks.

---

### 🔍 **4. Scanner** – Detect Conflicts  
**Goal:** Identify redundant overrides and potential conflicts.  
**Behavior:**  
- Compare `runtime/` vs `gamma_walo/`.  
- Report:  
  - Redundant overrides  
  - Undocumented behavior changes  
  - Risky or unexplained edits  
- Also list `.ltx` file collisions for a later pass.  
- **Context Enforcement:** Detect and flag orphaned systems (code that isn’t hooked into GAMMA).

---

### 📊 **5. DocGen** – Generate Developer Docs  
**Goal:** Create an API map and developer reference.  
**Behavior:**  
- Parse `.script` files for function signatures and constants.  
- Group by file and system (e.g., `sim_`, `task_`, `xr_`).  
- Output: `docs/api_map.md` with indexable function listings.  
- Optional: Map known STALKER engine callbacks.  
- **Context Enforcement:** Document where GAMMA hooks into each function.

---

### 💥 **6. StressTester** – Add Logging Hooks  
**Goal:** Create traceable logs for critical paths.  
**Behavior:**  
- Target `task_`, `sim_`, `game_`, `xr_` files.  
- Inject logging on function entry/exit.  
- Log major data structures and states.  
- Mark `TODO:` flags at high-risk logic points.  
- **Context Enforcement:** Focus only on GAMMA integration points.

---

## **🗒 Workflow Guidelines**  
- Always commit regenerated docs:  
  - `docs/runtime_vs_gamma_walo.md`  
  - `docs/api_map.md`  
- Append a brief entry to `CHANGELOG.md` for every iteration.  
- Each `.script` file must begin with a **comment header**:  
  - File intent  
  - Last edit date  
  - Author/agent note  

---

## **Additional Pass – GAMMA Hook Audit**  
### [ ] Pass 6: GAMMA Hook Audit  
- Scan all new or modified systems.  
- For each system/function, confirm it has at least **one integration point** into existing GAMMA/Anomaly engine hooks.  
- If not:  
  - Flag it as *orphaned*, or  
  - Suggest a hook location (task manager, faction manager, artifact spawner, etc.).  
- Output: `gamma_integration_audit.md`  

> ❌ Do **not** accept systems that “look clean but don’t integrate”.  
> ✅ Always ask: *"How does this tie into GAMMA’s actual gameplay?"* before implementing or merging.  
