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
