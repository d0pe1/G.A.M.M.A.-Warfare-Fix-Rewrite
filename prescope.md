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
