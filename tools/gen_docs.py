import difflib, re
from pathlib import Path

runtime = Path('runtime files/gamedata/scripts')
gamma = Path('gamma_walo/gamedata/scripts')

rows = ['# Runtime vs Gamma_Walo Diff','',
        'This report compares scripts in `runtime files/gamedata/scripts` against their counterparts in `gamma_walo/gamedata/scripts`.','',
        '| File | Added | Removed | Verdict |','| ---- | ----- | ------- | ------- |']

for p in sorted(runtime.glob('*.script')):
    g = gamma / p.name
    if g.exists():
        a = p.read_text(encoding='utf-8', errors='ignore').splitlines()
        b = g.read_text(encoding='utf-8', errors='ignore').splitlines()
        diff = list(difflib.unified_diff(a, b, fromfile=str(p), tofile=str(g), lineterm=''))
        added = sum(1 for l in diff if l.startswith('+') and not l.startswith('+++'))
        removed = sum(1 for l in diff if l.startswith('-') and not l.startswith('---'))
        rows.append(f'| {p.name} | {added} | {removed} | keep |')
        rows.append(f'\n<details><summary>Diff for {p.name}</summary>')
        rows.append('```diff')
        rows.extend(diff)
        rows.append('```')
        rows.append('</details>')
    else:
        rows.append(f'| {p.name} | - | - | missing in gamma |')

for p in sorted(gamma.glob('*.script')):
    if not (runtime / p.name).exists():
        rows.append(f'| {p.name} | new file | - | new module |')

Path('docs/runtime_vs_gamma_walo.md').write_text('\n'.join(rows))

api = ['# API Map','', 'This index lists public functions defined in the `gamma_walo/gamedata/scripts` directory.','']
for script in sorted(gamma.glob('*.script')):
    api.append(f'## {script.name}')
    lines = script.read_text(encoding='utf-8', errors='ignore').splitlines()
    for i, l in enumerate(lines, 1):
        m = re.match(r'function\s+([\w\.]+)', l)
        if m:
            api.append(f'- `{m.group(1)}` (line {i})')
    api.append('')

Path('docs/api_map.md').write_text('\n'.join(api))
