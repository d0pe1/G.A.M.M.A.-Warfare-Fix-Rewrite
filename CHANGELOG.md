# 📑 Changelog

All notable changes to this project will be documented in this file.

## [Unreleased]
### Added
- `CHANGELOG.md` to track repository progress.

### Improved
- `sim_offline_combat.script` hardening:
  - Added nil check when retrieving smart terrain data.
  - Replaced `pairs` with `ipairs` for sequential tables.
  - Recalculated `lid_1` per squad to avoid cross-level mismatches.

### Gameplay Expansion
- Introduced `resource_system.script` providing faction resource pools and node capture logic.
- Added `placeable_system.script` allowing factions to construct infrastructure using resources.
- Implemented `diplomacy_system.script` with symmetric relations and request queues.
- Created `legendary_squad_system.script` to track squad experience and rank progression.
- Added `meta_overlord.script` for scheduling antagonist events.
- New `ui_pda_diplomacy.script` generates diplomacy status lists for the PDA.

### Testing
- Added Busted unit tests covering new systems under `tests/`.

### Docs
- Documented new systems in `docs/` directory.
