#!/usr/bin/env python3
"""Generate final integration report summarizing remaining differences."""
import json
import re
from pathlib import Path

diff_data = json.loads(Path('diff_summary.json').read_text())
behavior_lines = Path('docs/behavior_change_log.md').read_text().splitlines()
behavior = {}
current = None
for line in behavior_lines:
    if line.startswith('## '):
        current = line[3:].strip()
    elif line.startswith('- `'):
        if current:
            note = 'major' if 'major' in line else 'minor'
            behavior.setdefault(current, set()).add(note)

rows = [
    '# Final Integration Report',
    '',
    'This report confirms module compatibility after Pass 5 static analysis.',
    '',
    '| File | Added | Removed | Modified | Behavior | Verdict |',
    '| ---- | ----- | ------- | -------- | -------- | ------- |'
]

for file_name, data in sorted(diff_data.items()):
    if not (data['added'] or data['removed'] or data['modified']):
        continue
    added = len(data['added'])
    removed = len(data['removed'])
    modified = len(data['modified'])
    b_notes = behavior.get(file_name)
    if b_notes:
        note = 'major' if 'major' in b_notes else 'minor'
    else:
        note = '-'
    verdict = 'compatible' if note != 'major' and removed == 0 else 'needs review'
    rows.append(f'| {file_name} | {added} | {removed} | {modified} | {note} | {verdict} |')

Path('docs/final_integration_report.md').write_text('\n'.join(rows))
