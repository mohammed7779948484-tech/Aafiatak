#!/usr/bin/env python3
from __future__ import annotations

import json
import re
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
LIB = ROOT / 'lib'
DS = ROOT / 'lib/src/design_system'

EXPECTED_COMPONENTS = {
    'AafiatakButton', 'AafiatakTextField', 'AafiatakCard',
    'AafiatakInfoRows', 'AafiatakBadge', 'AafiatakNotice',
    'AafiatakStatusBlock', 'AafiatakSectionHeading', 'AafiatakEmptyState',
}

EXPECTED_PATTERNS = {
    'DoctorCard', 'ServiceCard', 'FacilitySummary',
    'AppointmentSummary', 'ReservationHoldBanner',
    'ArrivalWindowCard', 'PolicyCard',
}

LEGACY = [
    ROOT / 'lib/src/theme',
    ROOT / 'lib/src/shared/widgets/app_button.dart',
    ROOT / 'lib/src/shared/widgets/app_card.dart',
    ROOT / 'lib/src/shared/widgets/app_text_field.dart',
    ROOT / 'lib/src/shared/widgets/app_top_bar.dart',
    ROOT / 'lib/src/shared/widgets/app_icon.dart',
    ROOT / 'lib/src/shared/widgets/app_loading.dart',
    ROOT / 'lib/src/shared/widgets/app_empty_state.dart',
    ROOT / 'lib/src/shared/widgets/app_error_widget.dart',
]


def local_import_errors() -> list[str]:
    errors: list[str] = []
    directive = re.compile(r"^(?:import|export|part)\s+'([^']+)'", re.MULTILINE)
    for file in ROOT.rglob('*.dart'):
        text = file.read_text(encoding='utf-8')
        for target in directive.findall(text):
            if target.startswith(('dart:', 'package:flutter', 'package:flutter_test', 'package:flutter_localizations', 'package:go_router')):
                continue
            if target.startswith('package:aafiatak/'):
                resolved = ROOT / 'lib' / target.removeprefix('package:aafiatak/')
            elif target.startswith('package:'):
                continue
            else:
                resolved = (file.parent / target).resolve()
            if not resolved.exists():
                errors.append(f'{file.relative_to(ROOT)} -> {target}')
    return errors



def public_export_closure(entry: Path) -> set[Path]:
    directive = re.compile(r"^export\s+'([^']+)'", re.MULTILINE)
    visited: set[Path] = set()

    def walk(file: Path) -> None:
        resolved_file = file.resolve()
        if resolved_file in visited or not resolved_file.exists():
            return
        visited.add(resolved_file)
        for target in directive.findall(resolved_file.read_text(encoding='utf-8')):
            if target.startswith('package:'):
                continue
            walk((resolved_file.parent / target).resolve())

    walk(entry)
    return visited

def delimiter_errors() -> list[str]:
    errors: list[str] = []
    pairs = {')': '(', ']': '[', '}': '{'}
    opens = set(pairs.values())
    for file in ROOT.rglob('*.dart'):
        source = file.read_text(encoding='utf-8')
        stack: list[tuple[str, int]] = []
        i = 0
        line = 1
        state = 'code'
        quote = ''
        triple = False
        while i < len(source):
            ch = source[i]
            nxt = source[i + 1] if i + 1 < len(source) else ''
            tri = source[i:i + 3]
            if ch == '\n':
                line += 1
            if state == 'line_comment':
                if ch == '\n': state = 'code'
                i += 1; continue
            if state == 'block_comment':
                if ch == '*' and nxt == '/': state = 'code'; i += 2
                else: i += 1
                continue
            if state == 'string':
                if ch == '\\': i += 2; continue
                if triple:
                    if tri == quote * 3: state = 'code'; i += 3
                    else: i += 1
                    continue
                if ch == quote: state = 'code'
                i += 1; continue
            if ch == '/' and nxt == '/': state = 'line_comment'; i += 2; continue
            if ch == '/' and nxt == '*': state = 'block_comment'; i += 2; continue
            if ch in "'\"":
                quote = ch; triple = tri == ch * 3; state = 'string'
                i += 3 if triple else 1; continue
            if ch in opens:
                stack.append((ch, line))
            elif ch in pairs:
                if not stack or stack[-1][0] != pairs[ch]:
                    errors.append(f'{file.relative_to(ROOT)}:{line}: unexpected {ch}')
                    break
                stack.pop()
            i += 1
        else:
            if stack:
                errors.append(f'{file.relative_to(ROOT)}:{stack[-1][1]}: unclosed {stack[-1][0]}')
    return errors



def _relative_luminance(hex_color: str) -> float:
    value = hex_color.removeprefix('#')
    channels = [int(value[i:i + 2], 16) / 255 for i in (0, 2, 4)]

    def linearize(channel: float) -> float:
        if channel <= 0.04045:
            return channel / 12.92
        return ((channel + 0.055) / 1.055) ** 2.4

    red, green, blue = (linearize(channel) for channel in channels)
    return 0.2126 * red + 0.7152 * green + 0.0722 * blue


def _contrast_ratio(a: str, b: str) -> float:
    first = _relative_luminance(a)
    second = _relative_luminance(b)
    lighter, darker = max(first, second), min(first, second)
    return (lighter + 0.05) / (darker + 0.05)

def main() -> int:
    checks: list[dict[str, object]] = []
    def add(name: str, ok: bool, details: object = None) -> None:
        checks.append({'name': name, 'passed': ok, 'details': details})

    add('design_system_directory_exists', DS.is_dir())
    add('legacy_core_directory_removed', not (ROOT / 'lib/src/core').exists())
    old = [str(p.relative_to(ROOT)) for p in LEGACY if p.exists()]
    add('legacy_visual_system_removed', not old, old)

    ds_text = '\n'.join(p.read_text(encoding='utf-8') for p in DS.rglob('*.dart'))
    classes = set(re.findall(r'\bclass\s+(\w+)', ds_text))

    missing_components = sorted(EXPECTED_COMPONENTS - classes)
    add('expected_core_components_present', not missing_components, missing_components)

    missing_patterns = sorted(EXPECTED_PATTERNS - classes)
    add('expected_domain_patterns_present', not missing_patterns, missing_patterns)

    barrel_text = (DS / 'design_system.dart').read_text(encoding='utf-8')
    add('public_design_system_barrel_exports_foundations', "export 'foundations/foundations.dart';" in barrel_text)
    add('public_design_system_barrel_exports_components', "export 'components/components.dart';" in barrel_text)
    add('public_design_system_barrel_exports_patterns', "export 'patterns/patterns.dart';" in barrel_text)
    add('public_design_system_barrel_exports_theme', "export 'theme/theme.dart';" in barrel_text)

    banned_in_ds = []
    for p in DS.rglob('*.dart'):
        t = p.read_text(encoding='utf-8')
        if any(pkg in t for pkg in ['hugeicons', 'cached_network_image', 'flutter_svg', 'skeletonizer', 'flutter_riverpod']):
            banned_in_ds.append(str(p.relative_to(ROOT)))
    add('no_banned_packages_in_design_system', not banned_in_ds, banned_in_ds)

    required_colors = ['0xFF800020', '0xFFE5E5E5', '0xFFFFFFFF', '0xFF1A1A1A', '0xFF6E6E6E']
    missing_colors = [c for c in required_colors if c not in ds_text]
    add('canonical_burgundy_monochrome_color_anchors_present', not missing_colors, missing_colors)

    banned_colors = ['0xFF4A315D', '0xFF3F786E', '0xFFA85A41', '0xFFF7F3EE']
    present_banned_colors = [c for c in banned_colors if c in ds_text]
    add('legacy_mineral_bloom_palette_removed', not present_banned_colors, present_banned_colors)

    add('canonical_spacing_scale_present', 'static const List<double> scale' in ds_text and 'x3l = 40' in ds_text)
    add('canonical_radii_scale_present', 'smValue = 8' in ds_text and 'fullValue = 999' in ds_text)
    add('approved_typography_contract_present', "arabicFamily = 'IBM Plex Sans Arabic'" in ds_text and "latinFamily = 'IBM Plex Sans'" in ds_text)

    imports = local_import_errors()
    add('local_imports_resolve', not imports, imports)
    delimiters = delimiter_errors()
    add('dart_delimiters_balanced', not delimiters, delimiters)

    app = (ROOT / 'lib/src/app/aafiatak_app.dart').read_text(encoding='utf-8')
    add('arabic_locale_configured', "Locale('ar')" in app)
    add('aafiatak_theme_is_app_theme', 'theme: AafiatakTheme.light' in app)
    add('no_dark_theme_added', 'darkTheme:' not in app and 'themeMode:' not in app)

    tests = list((ROOT / 'test/design_system').glob('*_test.dart'))
    add('design_system_tests_authored', len(tests) >= 4, [str(p.relative_to(ROOT)) for p in tests])

    fonts = [
        str(p.relative_to(ROOT))
        for p in ROOT.rglob('*')
        if p.is_file()
        and p.suffix.lower() in {'.ttf', '.otf', '.woff', '.woff2'}
        and 'build' not in p.parts
        and '.dart_tool' not in p.parts
    ]
    add('no_font_files_bundled', not fonts, fonts)

    passed = all(bool(x['passed']) for x in checks)
    report = {
        'scope': 'Aafiatak Flutter v2.1 Burgundy Monochrome Design System audit',
        'static_result': 'passed' if passed else 'failed',
        'check_count': len(checks),
        'checks': checks,
    }
    out = ROOT / 'docs/design_system/STATIC_QA_REPORT.json'
    out.parent.mkdir(parents=True, exist_ok=True)
    out.write_text(json.dumps(report, ensure_ascii=False, indent=2) + '\n', encoding='utf-8')
    print(json.dumps(report, ensure_ascii=False, indent=2))
    return 0 if passed else 1

if __name__ == '__main__':
    raise SystemExit(main())
