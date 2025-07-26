
## Prescope: Clone baseline - Enumerate affected files from old_walo
- **Task ID**: SETUP-2
- **Agent**: DiffAnalysisAgent
- **Summary**: Identify all script and config files in old_walo to know which baseline files must be copied to gamma_walo.

### Complexity Classification
- **Complexity**: [P-complete]
- **Justification**: Straightforward filesystem listing with no branching logic.

### Scope & Context
- Inspect `old walo/gamedata` for `.script`, `.ltx`, and `.xml` files.
- No engine hooks involved; purely file enumeration.

### Dependencies
- Requires presence of `old walo/` directory. No other blockers.

### Data Flow Analysis
- **Input**: Directory tree under `old walo/gamedata`.
- **Output**: `docs/old_walo_files.txt` listing relative file paths.
- **Consumers**: Subsequent tasks that copy baseline files and compare versions.

### Failure Cases
- Missing directory or read permissions → task fails.
- Unexpected file types not captured by patterns → may require rerun.

### Test Plan
- Verify that `docs/old_walo_files.txt` contains all expected files and only those.

### Rollback & Risk
- Delete the generated file to rollback.
- Minimal risk as no game files are touched.

### Definition of Done
- `docs/old_walo_files.txt` committed with accurate list.
- Entry added to CHANGELOG and task recorded in DevDiary.

### Completed SETUP-2
- Enumerated old_walo files and saved list to docs/old_walo_files.txt.
- Date: 2025-07-26
