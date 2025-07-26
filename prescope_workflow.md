# Prescope Workflow (NP/P-Aware)

All agents must **prescope hard** before coding. Prescoping is mandatory and must be done in **DevDiary.md** or a `prescope_<task>.md` file.

---

## Steps

1. **Task Identification**
   - Name, owning agent, and reference from `agent_tasks.md` or `agent_prio.md`.
   - Summary: Why this task matters and what it is intended to solve.

2. **Scope & Context**
   - Identify affected systems, modules, and engine hooks (e.g., `spawn_item`, `level.map_add_object_spot`).
   - Determine if this is a **self-contained atomic task (P-complete)** or a **broad, multi-path task (NP-complete)**.

3. **Complexity Classification**
   - Explicitly label the task as:
     - **[P-complete]** → Can be executed as-is, single linear solution path.
     - **[NP-complete]** → Requires breaking down into smaller, P-complete subtasks.
   - **Justify classification**: why is it atomic or why does it require multiple steps to solve?

4. **Dependencies (Hard Blockers)**
   - Identify upstream `[a]` tasks, missing APIs, or data required.
   - If any blockers exist:
     - Mark the current task `[a]` in `agent_tasks.md`.
     - Add or update the relevant parent task in `agent_prio.md`.
   - If the task is NP-complete:
     - Proceed directly to the **NP Split Strategy** step (Step 5).

5. **NP Split Strategy (for NP-complete tasks)**
   - Break the task into smaller P-complete subtasks.
   - Add each subtask as `[ ]` in `agent_prio.md` **indented one level deeper (two spaces)** under the parent task.
   - Assign weights to subtasks (1–1000) and document dependencies between them.
   - Stop execution. Future iterations will pick these P-complete subtasks.

6. **Data Flow Analysis**
   - Map input → processing → output using ASCII or markdown diagrams.
   - Identify exact input data, output data, and downstream consumers of the results.
   - If unknown inputs/outputs remain → reclassify as NP-complete and split further.

7. **Failure Cases**
   - Analyze how and where this task could break (crashes, corrupted state, inconsistent data).
   - If unknown failure points exist or too many branches to resolve → mark as NP-complete and split.

8. **Test Plan**
   - Define specific **Busted tests** or in-game validation for atomic tasks.
   - Define multi-step validation if subtasks are needed for NP-complete problems.

9. **Rollback & Risk**
   - Define how to roll back the work if it fails (file revert, config flags, temporary disable).
   - Identify risks and possible impact to related systems.

10. **Definition of Done**
    - Define the success criteria:
      - All subtasks completed (for NP-complete parents).
      - All tests pass.
      - Docs updated and tasks cleaned up in `agent_prio.md` and `agent_tasks.md`.

---

## Output Template (Used in DevDiary.md)

## Prescope: <Task Title>
- **Task ID**: <Task ID>
- **Agent**: <Agent Name>
- **Summary**: Brief summary of intended work.

### Complexity Classification
- **Complexity**: `[P-complete]` or `[NP-complete]`
- **Justification**: Why is this task atomic or requiring decomposition?

### Scope & Context
- Define clearly what the task does.
- Specify affected modules, scripts, and any engine hooks.

### Dependencies
- List explicit dependencies (other P-complete tasks or required NP splits).

### NP Split Strategy (for NP-complete only)
- Enumerate the new subtasks, assign weights, and indent them properly in `agent_prio.md`.
- Explain how these subtasks, once completed, will fully resolve the parent NP-complete task.

### Data Flow Analysis
- Explicit input data or conditions.
- Explicit output data or state changes.
- Consumers of this output.

### Failure Cases
- Identify possible failure points or ambiguities.
- Document how to handle these cases or break them into subtasks.

### Test Plan
- Specific tests or validation for atomic tasks and subtasks.

### Rollback & Risk
- Outline rollback strategies or note the risk level.

### Definition of Done
- List exact success criteria for the task or all its subtasks.

### Implementation Notes (optional)
- Notes added during implementation.
