# Warfare Dev Agent Profile

## Skills Required
- Advanced Lua (STALKER-style, 5.1 flavor)
- STALKER Anomaly modding
- LTX config comprehension
- Familiarity with Warfare mode (AI squads, simulation layers)
- Debugging MO2 + user logs

## Resources
- [Monolith Engine Lua API (community mirror)](https://github.com/revolucas/anomaly-api-docs) ← link this
- [GAMMA Modpack Repo](https://github.com/Grokitach/Stalker-GAMMA)
- [Mod Organizer 2 Guide](https://github.com/ModOrganizer2/modorganizer)

## Agent Purpose
This Codex Agent helps merge, harden, refactor and modernize STALKER Anomaly's Warfare scripts, with the goal of:
- Reducing nil crashes and save corruption
- Increasing script modularity and readability
- Enabling hybrid Warfare + Story game modes
- Building developer-facing tooling for future modders

# Warfare Codex Agent Modes

This section defines key agent behavior presets. Activate these by referencing the mode name in your Codex tasks.

---

## 🛡️ 1. `Fixer`

**Goal:** Harden Lua logic to avoid nil crashes and runtime instability.

**Behavior:**
- Scan all `.script` files for common crash vectors.
- Add `type()` checks before method calls.
- Replace `for i = 1, #x` with `ipairs(x or {})` when safe.
- Add early returns for invalid AI or object handles.
- Annotate all inserted guards (e.g. `-- added nil check`).

---

## 🧠 2. `Analyzer`

**Goal:** Compare file versions and describe behavioral or structural changes.

**Behavior:**
- Diff each `gamma_patch/` file against `old_walo/`.
- Output:
  - Code added, removed, or moved
  - Stability or logic impact
  - Verdict: keep, skip, or flag for review
- Output format: Markdown table + code block highlights.

---

## 🔁 3. `Merger`

**Goal:** Build a unified, cleaned-up `gamma_walo/` script set.

**Behavior:**
- Use `old_walo/` as base.
- Apply only safe `gamma_patch/` changes:
  - Crash fixes
  - Logging
  - Callback additions
  - Bugfixes
- Preserve original formatting unless cleaned.
- Add inline fix comments.

---

## 🔍 4. `Scanner`

**Goal:** Scan the repo for remaining runtime overrides and unknown conflicts.

**Behavior:**
- Compare `runtime/` files to `gamma_walo/`.
- Report:
  - Redundant overrides
  - Undocumented changes
  - Risky or unexplained behavior
- Can also list `.ltx` file collisions for future pass.

---

## 📊 5. `DocGen`

**Goal:** Extract developer-friendly docs for STALKER modding.

**Behavior:**
- Parse `.script` files for function signatures
- Group by file and system (`sim_`, `task_`, etc.)
- Output `docs/api_map.md` with indexable functions
- Optional: map known STALKER engine callbacks

---

## 💥 6. `StressTester`

**Goal:** Inject trace logging and sanity checks into critical logic paths.

**Behavior:**
- Target `task_`, `sim_`, `game_`, `xr_` files
- Add `printf` or `SendScriptCallback` on entry/exit
- Log important data structures
- Mark `TODO:` flags for potential fail points
