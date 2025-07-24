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
