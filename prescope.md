# Prescope Plan
## Task: Pass 1: Baseline Diff Mapping

### Objective
Generate a diff summary comparing files in `gamma_walo/gamedata/scripts` against `runtime files/gamedata/scripts`. Output results to `diff_summary.json` and update documentation via `gen_docs.py`.

### Steps
1. Run `python tools/generate_diff_summary.py` to regenerate `diff_summary.json`.
2. Run `python tools/gen_docs.py` to refresh `docs/runtime_vs_gamma_walo.md` and `docs/api_map.md`.
3. Run `busted` to execute Lua tests.
4. Commit updated docs and diff summary.

### Integration Points
- No code changes; purely analysis and documentation.

### Completion Criteria
- `diff_summary.json` updated with new diff data.
- `docs/runtime_vs_gamma_walo.md` and `docs/api_map.md` regenerated.
- Tests run successfully.
- `agent_subtasks.md` Pass 1 checkbox marked as done.

## Task: Pass 2: Signature & Callsite Audit

### Objective
Generate updated function signature and callsite analysis for modified functions. Output to `docs/function_compat_report.md`.

### Steps
1. Run new `tools/function_signature_audit.py` to parse `diff_summary.json` and scan callsites.
2. Review generated `docs/function_compat_report.md`.
3. Run `busted` tests.
4. Commit updated report and tasks.

### Integration Points
- Static analysis only; no runtime code changes.

### Completion Criteria
- `docs/function_compat_report.md` refreshed with current signatures and callsites.
- Tests pass.
- `agent_subtasks.md` Pass 2 checkbox marked as done.

## Task: Pass 3: Nil Defense Elimination & Root Tracing

### Objective
Audit modified scripts for added nil checks. Remove band-aid guards and fix the
originating cause of nil values. Summarize fixes in `docs/root_cause_fixes.md`.

### Steps
1. Review `diff_summary.json` to find functions changed in `gamma_walo`.
2. Search those functions for `nil` checks or `or {}` fallback tables.
3. Compare to the runtime version and remove any new guards.
4. Trace the source of the nil value and ensure the upstream table/object is
   initialized before use.
5. Document each fix in `docs/root_cause_fixes.md`.
6. Run `python tools/gen_docs.py` to refresh docs.
7. Execute `busted tests` to ensure no regressions.

### Integration Points
- Purely static script adjustments; must retain compatibility with Anomaly hooks.

### Completion Criteria
- `docs/root_cause_fixes.md` updated with the investigated fixes.
- Documentation regenerated.
- Tests pass.
- `agent_subtasks.md` Pass 3 checkbox marked as done.

## Task: Pass 4: Behavior Consistency Review

### Objective
Analyze modified functions for behavioral deviations between `runtime files` and
`gamma_walo`. Document significant logic differences.

### Steps
1. Create `tools/behavior_consistency_review.py` to parse `diff_summary.json` and
   inspect changed functions.
2. Categorize each function as `major` or `minor` change based on diff size and
   presence of altered return statements.
3. Output findings to `docs/behavior_change_log.md`.
4. Run `python tools/gen_docs.py` to keep documentation in sync.
5. Execute `busted` to verify existing tests still pass.

### Integration Points
- Static analysis only; ensures script parity with original Anomaly logic.

### Completion Criteria
- `docs/behavior_change_log.md` generated summarizing all detected changes.
- Documentation regenerated.
- Tests pass.
- `agent_subtasks.md` Pass 4 checkbox marked as done.

## Task: Pass 5: Final Verification + Structured Report

### Objective
Generate final integration report consolidating diff, signature, and behavior checks.

### Steps
1. Rerun `generate_diff_summary.py`, `function_signature_audit.py`, and `behavior_consistency_review.py` to refresh docs.
2. Create new script `tools/final_verification.py` to compile `docs/final_integration_report.md`.
   - Summarize changed files with counts of added/removed/modified functions.
   - Include behavior change classification from `behavior_change_log.md`.
   - Mark each file as `compatible` if no major changes or callsite mismatches.
3. Run `python tools/final_verification.py`.
4. Execute `python tools/gen_docs.py` for consistency.
5. Run `busted tests` to ensure suite still passes.

### Integration Points
- Static analysis only; ensures final documentation aligns with current state.

### Completion Criteria
- `docs/final_integration_report.md` generated summarizing module status.
- Documentation regenerated.
- Tests pass.
- `agent_subtasks.md` Pass 5 checkbox marked as done.

## Task: Implement Squad Loot Recovery

### Objective
Capture transport squad cargo when members die and allow patrol squads to retrieve these resources.

### Steps
1. Create new module `squad_loot_recovery.script` managing dropped resources.
2. Register `npc_on_death_callback` within this module and store `carrying` items from fallen transport members.
3. Provide `collect_nearby_loot(squad)` for patrol squads to gather nearby drops and transfer to `resource_system`.
4. Update `squad_transport.create` to tag members with `carrying` for callback lookup.
5. Add unit tests covering death capture and recovery.
6. Run `python tools/gen_docs.py` and `python tools/generate_diff_summary.py`.
7. Execute `busted` tests.
8. Update `CHANGELOG.md` and mark subtask complete in `agent_subtasks.md`.

### Integration Points
- Uses existing `npc_on_death_callback` from callbacks_gameobject.script.
- Utilizes `resource_system.add_resource` to deposit recovered items.

### Completion Criteria
- New script and modified transport logic present with tests.
- Documentation regenerated and diff summary updated.
- Checklist updated in `agent_subtasks.md`.

## Task: Add Dynamic Rerouting Logic

### Objective
Allow transport squads to dynamically reroute to a different base when squad members die or when an external danger flag is raised.

### Steps
1. Extend `squad_transport.script` with a new `reroute(squad)` function that selects a fallback base using `hq_coordinator.bases_by_faction`.
2. Update `transport.create` to store `faction` on the squad and reference the squad in each member table for callback usage.
3. Expose `mark_danger(squad)` which simply calls `reroute`.
4. Modify `squad_loot_recovery.on_npc_death` to reroute the victim's squad when available.
5. Add helper `get_fallback_base(faction, exclude)` to `hq_coordinator.script`.
6. Write new unit tests in `squad_transport_spec.lua` validating reroute behaviour.
7. Regenerate documentation via `tools/gen_docs.py` and `tools/generate_diff_summary.py`.
8. Run `busted tests` to ensure suite passes.
9. Update `CHANGELOG.md` and mark subtask complete in `agent_subtasks.md`.

### Integration Points
- Rerouting relies on HQ coordinator base lists from existing logistics system.
- Loot death callback in `squad_loot_recovery` triggers reroute using new API.

### Completion Criteria
- Reroute logic implemented with tests.
- Documentation and diff summary updated.
- Subtask checkbox ticked in `agent_subtasks.md`.



## Task: Crashlog Fix - tasks_defense.script
### Objective
Resolve LUA error at tasks_defense.script line 241 when calling `game_relations.is_factions_enemies` which was nil. Use global `is_factions_enemies` instead and ensure script is copied into gamma_walo.
### Steps
1. Copy `runtime files/gamedata/scripts/tasks_defense.script` to `gamma_walo/gamedata/scripts/` if not present.
2. Replace calls to `game_relations.is_factions_enemies` with `is_factions_enemies`.
3. Add header comment noting modification.
4. Regenerate docs via `python tools/gen_docs.py` and `python tools/generate_diff_summary.py`.
5. Run pass verification scripts (`function_signature_audit.py`, `behavior_consistency_review.py`, `final_verification.py`).
6. Run `busted` tests.
### Integration Points
- Uses global relation functions; maintains compatibility.
### Completion Criteria
- Crash lines fixed; documentation and reports updated; tests executed; checklist updated.
