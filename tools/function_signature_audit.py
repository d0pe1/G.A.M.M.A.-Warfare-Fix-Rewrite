#!/usr/bin/env python3
"""Generate function signature and callsite report for modified functions."""
import json
import re
from pathlib import Path

runtime_dir = Path('runtime files/gamedata/scripts')
gamma_dir = Path('gamma_walo/gamedata/scripts')
summary = json.loads(Path('diff_summary.json').read_text())

FUNC_RE_TEMPLATE = r'^\s*function\s+{name}\s*\(([^)]*)\)'

def extract_signature(path, func):
    if not path.exists():
        return None
    pattern = re.compile(FUNC_RE_TEMPLATE.format(name=re.escape(func)))
    for line in path.read_text(encoding='utf-8', errors='ignore').splitlines():
        m = pattern.match(line)
        if m:
            return f"{func}({m.group(1)})"
    return None

def search_callsites(func):
    results = []
    pattern = re.compile(re.escape(func) + r'\s*\(')
    def_line = re.compile(FUNC_RE_TEMPLATE.format(name=re.escape(func)))
    for base in [gamma_dir, runtime_dir]:
        for script in base.glob('*.script'):
            lines = script.read_text(encoding='utf-8', errors='ignore').splitlines()
            for idx, line in enumerate(lines, 1):
                if pattern.search(line) and not def_line.match(line):
                    results.append(f"{base}/{script.name}:{idx}:{line.strip()}")
    return results

report = []
for file_name, data in sorted(summary.items()):
    mods = data.get('modified', [])
    if not mods:
        continue
    report.append(f"## {file_name}\n")
    for entry in mods:
        func = entry['name']
        runtime_sig = extract_signature(runtime_dir / file_name, func)
        gamma_sig = extract_signature(gamma_dir / file_name, func)
        report.append(f"### Function `{func}`")
        report.append(f"- Runtime: `{runtime_sig or 'not found'}`")
        report.append(f"- Gamma: `{gamma_sig or 'not found'}`")
        calls = search_callsites(func)
        if calls:
            report.append("- Callsites:")
            for c in calls:
                report.append(f"  - {c}")
        else:
            report.append("- Callsites: None found")
        report.append("")

Path('docs/function_compat_report.md').write_text('\n'.join(report))
