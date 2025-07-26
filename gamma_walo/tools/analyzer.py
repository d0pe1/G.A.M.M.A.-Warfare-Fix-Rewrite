import os
import re
import difflib
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]  # repo root
RUNTIME_DIR = ROOT / 'runtime files' / 'gamedata' / 'scripts'
OLD_WALO_DIR = ROOT / 'old walo' / 'gamedata' / 'scripts'
GAMMA_PATCH_DIR = ROOT / 'gammas patch' / 'gamedata' / 'scripts'
DOCS_DIR = ROOT / 'docs'

# ensure docs directory exists
DOCS_DIR.mkdir(exist_ok=True)

# Utility to read file text
def read_text(path):
    """Read a file as UTF-8, ignoring invalid bytes."""
    try:
        with open(path, 'r', encoding='utf-8', errors='ignore') as f:
            return f.read().splitlines()
    except FileNotFoundError:
        return None

def generate_diff(path_a, path_b, name_a, name_b, context=3):
    """Return unified diff between two files as list of lines."""
    a_lines = read_text(path_a)
    b_lines = read_text(path_b)
    if a_lines is None or b_lines is None:
        return []
    diff = difflib.unified_diff(
        a_lines, b_lines,
        fromfile=str(path_a), tofile=str(path_b), n=context)
    return list(diff)

def collect_files(directory):
    for file in directory.glob('*.script'):
        yield file.name

def create_runtime_vs_mod_report():
    report_lines = ['# Runtime vs Mod Diff Report', '']
    for mod_dir, mod_name in [ (OLD_WALO_DIR, 'old_walo'), (GAMMA_PATCH_DIR, 'gammas_patch') ]:
        report_lines.append(f'## Differences for {mod_name}')
        for fname in sorted(collect_files(mod_dir)):
            runtime_path = RUNTIME_DIR / fname
            mod_path = mod_dir / fname
            if not runtime_path.exists():
                continue
            diff_lines = generate_diff(runtime_path, mod_path, 'runtime', mod_name)
            if diff_lines:
                report_lines.append(f'### {fname}')
                report_lines.append('```diff')
                report_lines.extend(diff_lines)
                report_lines.append('```')
    (DOCS_DIR / 'runtime_vs_gamma_walo.md').write_text('\n'.join(report_lines))

def create_api_map():
    func_defs = {}
    pattern = re.compile(r'^\s*function\s+([\w\.]+)\s*\(')

    # pass 1: gather function definitions
    for path in RUNTIME_DIR.glob('*.script'):
        text = path.read_text(encoding='utf-8', errors='ignore')
        for m in pattern.finditer(text):
            func_defs[m.group(1)] = path.name

    call_map = {name: set() for name in func_defs}
    call_pattern = re.compile(r'([A-Za-z_][\w\.]*)\s*\(')

    # pass 2: scan for calls
    for path in RUNTIME_DIR.glob('*.script'):
        text = path.read_text(encoding='utf-8', errors='ignore')
        for m in call_pattern.finditer(text):
            name = m.group(1)
            if name in func_defs and func_defs[name] != path.name:
                call_map[name].add(path.name)

    # build report
    lines = ['# API Map', '', '| Function | Defined In | Called By |', '|---------|------------|-----------|']
    for name, mod in sorted(func_defs.items()):
        callers = ', '.join(sorted(call_map.get(name) or []))
        lines.append(f'| `{name}` | {mod} | {callers} |')
    (DOCS_DIR / 'api_map.md').write_text('\n'.join(lines))

if __name__ == '__main__':
    create_runtime_vs_mod_report()
    create_api_map()
    print('Docs generated in', DOCS_DIR)
