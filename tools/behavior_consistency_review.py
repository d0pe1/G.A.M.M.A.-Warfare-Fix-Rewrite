#!/usr/bin/env python3
"""Generate behavior change log for modified functions."""
import json
import re
from pathlib import Path

runtime_dir = Path('runtime files/gamedata/scripts')
gamma_dir = Path('gamma_walo/gamedata/scripts')

summary = json.loads(Path('diff_summary.json').read_text())

rows = [
    '# Behavior Change Log',
    '',
    'This report flags potential behavioral differences between `runtime files` and `gamma_walo`.',
    ''
]

for file_name, data in sorted(summary.items()):
    mods = data.get('modified', [])
    if not mods:
        continue
    runtime_path = runtime_dir / file_name
    gamma_path = gamma_dir / file_name
    if not runtime_path.exists() or not gamma_path.exists():
        continue

    rows.append(f'## {file_name}')
    runtime_lines = runtime_path.read_text(encoding='utf-8', errors='ignore').splitlines()
    gamma_lines = gamma_path.read_text(encoding='utf-8', errors='ignore').splitlines()

    for entry in mods:
        func = entry['name']
        diff_lines = entry.get('diff_lines', 0)
        note = 'major' if diff_lines > 10 else 'minor'
        pattern = re.compile(r'^\s*function\s+' + re.escape(func))
        start_a = next((i for i,l in enumerate(runtime_lines) if pattern.match(l)), None)
        start_b = next((i for i,l in enumerate(gamma_lines) if pattern.match(l)), None)
        def grab(lines, start):
            if start is None:
                return []
            return lines[start:start+20]
        body_a = grab(runtime_lines, start_a)
        body_b = grab(gamma_lines, start_b)
        returns_a = sum('return' in l for l in body_a)
        returns_b = sum('return' in l for l in body_b)
        if returns_a != returns_b:
            note += ' - return logic changed'
        rows.append(f'- `{func}`: {diff_lines} line diff ({note})')
    rows.append('')

Path('docs/behavior_change_log.md').write_text('\n'.join(rows))
