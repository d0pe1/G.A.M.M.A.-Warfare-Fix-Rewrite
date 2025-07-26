
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

## Prescope: Clone baseline - Copy matching baseline files
- **Task ID**: SETUP-3
- **Agent**: DiffAnalysisAgent
- **Summary**: Copy baseline versions of all files listed in docs/old_walo_files.txt into gamma_walo, preserving directory structure.

### Complexity Classification
- **Complexity**: [P-complete]
- **Justification**: Straightforward file operations with deterministic output.

### Scope & Context
- Read docs/old_walo_files.txt for list of paths.
- Copy corresponding files from runtime files/ to gamma_walo/.

### Dependencies
- Requires completion of SETUP-2 (file list generated).
- No engine hooks involved.

### Data Flow Analysis
- **Input**: Baseline files under runtime files/ matching paths in old_walo_files.txt.
- **Output**: gamma_walo/ directory containing copied files.
- **Consumers**: Future merge tasks and diff analysis.

### Failure Cases
- Missing baseline file -> task fails or file skipped.
- Directory creation errors.

### Test Plan
- Verify gamma_walo mirrors baseline for listed files.
- Busted test ensures one example file exists after copy.

### Rollback & Risk
- Delete gamma_walo directory to rollback. Minimal risk.

### Definition of Done
- All listed files copied to gamma_walo with original contents.
- Task marked complete, changelog updated.

### Completed SETUP-3
- Copied baseline files into gamma_walo.
- Date: 2025-07-26
