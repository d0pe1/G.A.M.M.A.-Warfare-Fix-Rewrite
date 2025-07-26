# Prescope Workflow

All agents must "prescope hard" before coding. Prescoping is mandatory and must be done in **DevDiary.md** or a `prescope_<task>.md` file.

## Steps

1. **Task Identification**
   - Name, owning agent, reference from `agent_tasks.md` or `agent_prio.md`
   - Summary: Why this task matters

2. **Scope & Context**
   - List affected systems and modules
   - List engine hooks involved (e.g. `spawn_item`, `level.map_add_object_spot`)

3. **Dependencies (Hard Blockers)**
   - Identify upstream `[a]` tasks or required APIs
   - If blocking tasks exist:
     - Mark your current task `[a]` in `agent_tasks.md`
     - Add an entry to `agent_prio.md`

4. **Data Flow Analysis**
   - Diagram input/output flow (ASCII or markdown)
   - List inputs, outputs, and downstream consumers

5. **Failure Cases**
   - What could crash? corrupt state? cause exploits?
   - Note logging and assertions needed

6. **Test Plan**
   - List exact tests and edge cases (Busted tests)
   - Define how you’ll confirm the system works

7. **Rollback & Risk**
   - If this breaks, how can we disable it quickly?
   - Any migration/cleanup needed for corrupted data?

## Output

- Full prescope section written into `DevDiary.md` (or `prescope_<task>.md`)
- Only start implementation when prescoping is complete and blockers are resolved.
