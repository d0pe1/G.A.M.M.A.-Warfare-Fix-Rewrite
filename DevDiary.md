
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

## Prescope: Verify gamma_walo structure
- **Task ID**: SETUP-4
- **Agent**: DiffAnalysisAgent
- **Summary**: Ensure gamma_walo directory mirrors the baseline paths enumerated from old_walo without extra files.

### Complexity Classification
- **Complexity**: [P-complete]
- **Justification**: Simple file existence checks using generated list.

### Scope & Context
- Check all paths in docs/old_walo_files.txt exist under gamma_walo.
- Confirm no extra files exist in gamma_walo.
- Requires only filesystem operations, no engine hooks.

### Dependencies
- Completion of SETUP-3 to have copied baseline files.

### Data Flow Analysis
- **Input**: docs/old_walo_files.txt and gamma_walo directory.
- **Output**: Test results verifying structure.
- **Consumers**: Future diff analysis and merges rely on correct baseline clone.

### Failure Cases
- Missing or extra files would cause spec failures.

### Test Plan
- Add Busted test to compare file list from docs/old_walo_files.txt to actual gamma_walo files.

### Rollback & Risk
- Low risk: only test and documentation updates.

### Definition of Done
- Spec passes confirming structure.
- Task marked complete and changelog updated.

### Completed SETUP-4
- Verified gamma_walo mirrors baseline file structure via new Busted spec.
- Date: 2025-07-26

## Prescope: WALO Port
- **Task ID**: WALO-1
- **Agent**: DiffAnalysisAgent
- **Summary**: Begin porting useful features from old_walo into gamma_walo. This requires merging multiple scripts carefully.

### Complexity Classification
- **Complexity**: [NP-complete]
- **Justification**: Many scripts need selective merging and testing, so it must be broken down into smaller tasks.

### Scope & Context
- Affected modules include dialogs.script, faction_expansions.script, game_relations.script, sim_offline_combat.script, sim_squad_scripted.script, smart_terrain_warfare.script, tasks_assault.script, tasks_smart_control.script and ui_options.script.
- These hook into dialog conditions, spawn chance calculation, offline combat loops and UI options.

### Dependencies
- Baseline copies of these scripts already exist in gamma_walo.
- Diff reports in docs/runtime_vs_gamma_walo.md guide needed changes.

### NP Split Strategy
- Create per-file subtasks under WALO-1 in agent_prio.md describing each merge step with weights.

### Data Flow Analysis
- **Input**: Differences between old_walo and baseline scripts.
- **Output**: Updated gamma_walo scripts integrating selected features.
- **Consumers**: Warfare gameplay scripts during runtime.

### Failure Cases
- Merge mistakes leading to Lua errors or broken warfare logic.
- Conflicts with GAMMA patch functionality.

### Test Plan
- For each merged script add or update Busted specs.
- Run existing specs after each change.

### Rollback & Risk
- Use git revert to undo problematic merges.
- Medium risk: wrong merges could destabilise the overhaul.

### Definition of Done
- All subtasks in agent_prio.md completed with tests passing and documentation updated.


## Prescope: Port important_docs table
- **Task ID**: WALO-2
- **Agent**: DiffAnalysisAgent
- **Summary**: Merge the important_docs reward table from old_walo into gamma_walo dialogs.script and ensure warfare_disabled function preserved.

### Complexity Classification
- **Complexity**: [P-complete]
- **Justification**: Simple table port with minimal hooks.

### Scope & Context
- Modify gamma_walo/gamedata/scripts/dialogs.script to include document reward values.
- Ensure warfare_disabled helper remains unchanged.

### Dependencies
- Requires old_walo version for values. No other blockers.

### Data Flow Analysis
- **Input**: Document reward entries from old_walo.
- **Output**: Updated dialogs.script used by task dialogs.
- **Consumers**: NPC dialog trade logic.

### Failure Cases
- Typo in table causing nil lookups.
- Tests failing if file not updated correctly.

### Test Plan
- Update Busted spec to check for specific document entries.

### Rollback & Risk
- Revert file if dialog errors occur. Low risk.

### Definition of Done
- Spec passes confirming document table entries.
- agent_prio updated and changelog entry written.

### Completed WALO-2
- Added old_walo document reward values to dialogs.script and preserved warfare_disabled helper. Updated tests accordingly.
- Date: 2025-07-26
