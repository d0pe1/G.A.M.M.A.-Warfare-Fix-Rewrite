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
