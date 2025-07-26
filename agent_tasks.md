# **Agent Task Checklist (Weight-Aware)**

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

---

## **Task Weighting System**

Each task now has a **weight** in parentheses:  
- Small task = `50–100`  
- Medium task = `200–400`  
- Large or complex task = `500–1000`  

> Agents must:
> 1. Always prioritise `[a]` tasks from `agent_prio.md` first.  
> 2. Then, pick the highest-weight remaining task.  
> 3. If a task has weight ≥ `500`, **break it into subtasks** in `agent_prio.md` before working.  

Agents should calculate **weighted progress** for every PR:  
Progress: 37% complete (weight done / total weight)

---

## **0. Agent Workflow Rules (ALL AGENTS MUST FOLLOW)**  

(unchanged from your original – same context, pre-scoping and self-checking rules)

---

## **1. Setup & Diff Analysis**

- [x] **Clone baseline** *(weight=50)* – Create the `gamma_walo` directory by copying the baseline files from `runtime files`.
- [x] **Run Analyzer profile** *(weight=100)* – Generate `docs/runtime_vs_gamma_walo.md` comparing `runtime files`, `old_walo` and `gammas patch`.
- [x] **Generate API map** *(weight=50)* – Scan baseline scripts and generate `docs/api_map.md`.
- [x] **Identify conflicts** *(weight=300)* – Summarise changes for every `old_walo` and `gammas patch` file vs baseline and plan merge strategies.
- [ ] **Update agent tasks** *(weight=100)* – Add missing tasks discovered during diff analysis.

---

## **2. Integration of Existing Mods**

- [a] **WALO port** *(weight=800)* – Integrate beneficial features from `old_walo` into `gamma_walo`.
- [a] **Gamma patch port** *(weight=700)* – Integrate fixes/features from `gammas patch` into `gamma_walo`.
- [ ] **Modernise code** *(weight=150)* – Update outdated Lua idioms where safe.
- [ ] **Merge important_docs table** *(weight=100)* – Integrate document reward table from `dialogs.script`.
- [ ] **Apply spawn chance formulas** *(weight=100)* – Port revised `get_advanced_chance` and `get_veteran_chance`.
- [ ] **Integrate dynamic relations** *(weight=150)* – Add blacklist checks from `game_relations.script`.
- [ ] **Fix scripted squad targets** *(weight=50)* – Apply `sim_squad_scripted.script` fixes.
- [ ] **Add smart_terrain update helper** *(weight=100)* – Merge `sim_offline_combat.script` helper function.

---

## **3. Resource Infrastructure System**

- [ ] **Create module** *(weight=600)* – Implement `resource_system.script` and classes `ResourceNode`, `BaseNode`, `HQNode`.
- [ ] **Territory hook** *(weight=300)* – Hook into territory capture logic.
- [ ] **Daily generation** *(weight=200)* – Add daily resource generation using timers.
- [ ] **Conversion & specialisation** *(weight=200)* – Support converting/specialising nodes with cost checks.
- [ ] **Resource bias** *(weight=100)* – Apply faction philosophy resource priorities.
- [ ] **Edge cases** *(weight=150)* – Handle depletion, contested nodes and upgrades.
- [ ] **Config files** *(weight=100)* – Create `.ltx` configs for yields, costs and upgrades.
- [ ] **Write tests** *(weight=150)* – Add Busted specs for all scenarios.
- [ ] **Document** *(weight=50)* – Write `docs/resource_system.md` and update logs.

---

## **4. Logistics System**

- [ ] **Create module** *(weight=500)* – Implement `logistics_system.script` with `TransportSquad` class.
- [ ] **Spawn transport squads** *(weight=200)* – Trigger squads from stockpile thresholds.
- [ ] **Pathfinding** *(weight=250)* – Implement safe routing logic.
- [ ] **Ambush & fallback** *(weight=150)* – Handle cargo drop/pick-up and rerouting.
- [ ] **HQ rerouting hook** *(weight=100)* – Allow HQ nodes to override routes.
- [ ] **Write tests** *(weight=150)* – Simulate transports in tests.
- [ ] **Document** *(weight=50)* – Write `docs/logistics_system.md`.

---

## **5. Squad Progression**

- [ ] **Create module** *(weight=400)* – Implement `squad_progression.script` with XP and rank system.
- [ ] **XP accumulation** *(weight=100)* – Hook into combat events.
- [ ] **Promotion effects** *(weight=100)* – Implement stat/equipment upgrades.
- [ ] **PDA integration** *(weight=100)* – Update UI to display legendary squads.
- [ ] **Write tests** *(weight=100)* – Add Busted specs for progression logic.
- [ ] **Document** *(weight=50)* – Write `docs/squad_progression.md`.

---

## **6. Diplomacy & Player Factions**

- [ ] **Create module** *(weight=500)* – Implement `diplomacy_system.script` and `Faction` class.
- [ ] **Custom faction creation** *(weight=200)* – Build player faction UI and configs.
- [ ] **Actions implementation** *(weight=150)* – Implement diplomacy actions (war, tribute, assist).
- [ ] **AI negotiation** *(weight=150)* – Add faction negotiation logic.
- [ ] **PDA integration** *(weight=100)* – Add diplomacy menus and dialogs to PDA.
- [ ] **Write tests** *(weight=100)* – Add diplomacy tests.
- [ ] **Document** *(weight=50)* – Write `docs/diplomacy_system.md`.

---

## **7. Faction Philosophy**

- [ ] **Create config** *(weight=150)* – Write `faction_philosophies.ltx`.
- [ ] **Create loader** *(weight=100)* – Implement `faction_philosophy.script`.
- [ ] **Register philosophies** *(weight=100)* – Support dynamic registration.
- [ ] **Integrate with other systems** *(weight=150)* – Ensure other systems query philosophies.
- [ ] **Write tests** *(weight=100)* – Verify correct influence on decisions.
- [ ] **Document** *(weight=50)* – Write `docs/faction_philosophy.md`.

---

## **8. User Interface Updates**

- [ ] **Context menu entries** *(weight=150)* – Add map menu entries for nodes and diplomacy.
- [ ] **Custom faction creation UI** *(weight=200)* – Implement UI dialogs for new faction creation.
- [ ] **Diplomacy dialogs** *(weight=150)* – Add negotiation windows.
- [ ] **Legendary squad display** *(weight=100)* – Show legendary squad info.
- [ ] **Greyed-out states** *(weight=50)* – Ensure invalid actions are disabled.
- [ ] **Write tests** *(weight=100)* – Add UI-related tests.
- [ ] **Document** *(weight=50)* – Write `docs/ui_updates.md`.

---

## **9. Testing & Debugging**

- [ ] **Set up test harness** *(weight=150)* – Mock engine for tests.
- [ ] **Write Busted specs** *(weight=200)* – Ensure all new modules have test coverage.
- [ ] **Run tests** *(weight=100)* – Execute after each feature is implemented.
- [ ] **Monitor crash logs** *(weight=50)* – Check for runtime crashes and create `[a]` tasks.
- [ ] **Add regression tests** *(weight=100)* – Extend coverage after bug fixes.

---

## **10. Documentation & Logging**

- [ ] **Update docs** *(weight=100)* – Ensure `/docs` matches implementation.
- [ ] **Append changelog** *(weight=50)* – Summarise each change.
- [ ] **Write dev diary** *(weight=50)* – Add detailed notes for each change.
- [ ] **Maintain consistency** *(weight=50)* – Ensure docs and code are in sync.

---

**Following this checklist will gradually build the full Warfare Overhaul.  
Agents should tick tasks as they complete them, add new subtasks when analysis uncovers additional work, and track weighted progress at all times.**
