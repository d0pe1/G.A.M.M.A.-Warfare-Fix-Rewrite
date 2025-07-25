#!/usr/bin/env python3
"""Generate function-level diff summary between runtime files and gamma_walo.

This script compares corresponding `.script` files in `gamma_walo/gamedata/scripts`
with those in `runtime files/gamedata/scripts` and outputs a JSON summary
listing added, removed, and modified functions for each file.
"""
import difflib
import json
import re
from pathlib import Path

runtime_dir = Path('runtime files/gamedata/scripts')
gamma_dir = Path('gamma_walo/gamedata/scripts')

# pattern to match function definitions at the start of a line
FUNC_RE = re.compile(r'^\s*function\s+([\w\.]+)')


def extract_functions(lines):
    funcs = {}
    current_name = None
    current_lines = []
    for line in lines:
        m = FUNC_RE.match(line)
        if m:
            if current_name is not None:
                funcs[current_name] = '\n'.join(current_lines)
            current_name = m.group(1)
            current_lines = [line]
        elif current_name is not None:
            current_lines.append(line)
    if current_name is not None:
        funcs[current_name] = '\n'.join(current_lines)
    return funcs

summary = {}
for gamma_file in sorted(gamma_dir.glob('*.script')):
    runtime_file = runtime_dir / gamma_file.name
    if not runtime_file.exists():
        summary[gamma_file.name] = {'added': list(extract_functions(gamma_file.read_text(encoding='utf-8', errors='ignore').splitlines()).keys()),
                                    'removed': [], 'modified': []}
        continue

    gamma_lines = gamma_file.read_text(encoding='utf-8', errors='ignore').splitlines()
    runtime_lines = runtime_file.read_text(encoding='utf-8', errors='ignore').splitlines()

    gamma_funcs = extract_functions(gamma_lines)
    runtime_funcs = extract_functions(runtime_lines)

    added = [f for f in gamma_funcs if f not in runtime_funcs]
    removed = [f for f in runtime_funcs if f not in gamma_funcs]
    modified = []
    for name in gamma_funcs:
        if name in runtime_funcs and gamma_funcs[name] != runtime_funcs[name]:
            diff = list(difflib.unified_diff(runtime_funcs[name].splitlines(), gamma_funcs[name].splitlines(), lineterm=''))
            modified.append({'name': name, 'diff_lines': len(diff)})

    summary[gamma_file.name] = {'added': added, 'removed': removed, 'modified': modified}

# check for runtime files missing in gamma_walo
for runtime_file in sorted(runtime_dir.glob('*.script')):
    if not (gamma_dir / runtime_file.name).exists():
        summary.setdefault(runtime_file.name, {'added': [], 'removed': [], 'modified': []})
        summary[runtime_file.name]['missing_in_gamma'] = True

Path('diff_summary.json').write_text(json.dumps(summary, indent=2))
