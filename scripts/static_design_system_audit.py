#!/usr/bin/env python3
from __future__ import annotations

import json
import re
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
LIB = ROOT / 'lib'
DS = ROOT / 'lib/src/design_system'

EXPECTED = {
    'AafiatakButton', 'AafiatakIconButton', 'AafiatakTextField',
    'AafiatakPhoneField', 'AafiatakOtpInput', 'AafiatakSearchField',
    'AafiatakChip', 'AafiatakSegmentedControl', 'AafiatakCard',
    'AafiatakDivider', 'AafiatakInfoRow', 'AafiatakAppBar',
    'AafiatakNavigationBar', 'AafiatakStatusBlock', 'AafiatakBanner',
    'AafiatakSnackbar', 'AafiatakDialog', 'AafiatakBottomSheetBody',
    'AafiatakLoading', 'AafiatakSkeleton', 'AafiatakEmptyState',
    'AafiatakErrorState', 'AafiatakProgress', 'AafiatakBadge', 'AafiatakIcon',
    'AafiatakListRow', 'AafiatakPrimaryActionBar',
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
            if target.startswith(('dart:', 'package:flutter')):
                continue
            if target.startswith('package:aafiatak/'):
                resolved = ROOT / 'lib' / target.removeprefix('package:aafiatak/')
            elif target.startswith('package:'):
                continue
            else:
                resolved = (file.parent / target).resolve()
            if not resolved.exists():
                generated_l10n = ROOT / 'lib/l10n/generated/app_localizations.dart'
                if resolved == generated_l10n.resolve():
                    continue
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
                if ch == '\n':
                    state = 'code'
                i += 1
                continue
            if state == 'block_comment':
                if ch == '*' and nxt == '/':
                    state = 'code'
                    i += 2
                else:
                    i += 1
                continue
            if state == 'string':
                if ch == '\\':
                    i += 2
                    continue
                if triple:
                    if tri == quote * 3:
                        state = 'code'
                        i += 3
                    else:
                        i += 1
                    continue
                if ch == quote:
                    state = 'code'
                i += 1
                continue
            if ch == '/' and nxt == '/':
                state = 'line_comment'
                i += 2
                continue
            if ch == '/' and nxt == '*':
                state = 'block_comment'
                i += 2
                continue
            if ch in "'\"":
                quote = ch
                triple = tri == ch * 3
                state = 'string'
                i += 3 if triple else 1
                continue
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
                errors.append(
                    f'{file.relative_to(ROOT)}:{stack[-1][1]}: unclosed {stack[-1][0]}',
                )
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
    patterns = [
        str(p.relative_to(ROOT))
        for p in (ROOT / 'lib').rglob('patterns')
        if p.is_dir()
    ]
    add('no_domain_patterns_created', not patterns, patterns)
    old = [str(p.relative_to(ROOT)) for p in LEGACY if p.exists()]
    add('legacy_visual_system_removed', not old, old)

    ds_text = '\n'.join(
        p.read_text(encoding='utf-8') for p in DS.rglob('*.dart')
    )
    classes = set(re.findall(r'\bclass\s+(Aafiatak\w+)', ds_text))
    missing = sorted(EXPECTED - classes)
    add('expected_core_components_present', not missing, missing)

    public_files = public_export_closure(DS / 'design_system.dart')
    leaf_modules = {
        p.resolve()
        for p in DS.rglob('aafiatak_*.dart')
        if p.is_file()
    }
    unexported = sorted(
        str(p.relative_to(ROOT)) for p in leaf_modules - public_files
    )
    add(
        'public_design_system_barrel_exports_all_leaf_modules',
        not unexported,
        unexported,
    )

    component_text = '\n'.join(
        p.read_text(encoding='utf-8')
        for p in (DS / 'components').rglob('*.dart')
    )
    raw_hex = re.findall(r'Color\(0x[0-9A-Fa-f]+\)', component_text)
    add('core_components_have_no_raw_hex_colors', not raw_hex, raw_hex)
    physical = re.findall(
        r'(?:EdgeInsets\.fromLTRB|TextAlign\.(?:left|right)|Alignment\.(?:centerLeft|centerRight|topLeft|topRight|bottomLeft|bottomRight))',
        component_text,
    )
    add('core_components_are_rtl_direction_safe', not physical, physical)

    outside_huge = []
    for p in (ROOT / 'lib').rglob('*.dart'):
        if DS in p.parents:
            continue
        text = p.read_text(encoding='utf-8')
        if 'HugeIcon(' in text or 'HugeIcons.' in text or 'package:hugeicons' in text:
            outside_huge.append(str(p.relative_to(ROOT)))
    add('hugeicons_encapsulated_by_design_system', not outside_huge, outside_huge)

    imports = local_import_errors()
    add('local_imports_resolve', not imports, imports)
    delimiters = delimiter_errors()
    add('dart_delimiters_balanced', not delimiters, delimiters)

    required_hex = [
        '0xFF800020',
        '0xFF5C0016',
        '0xFFF7E9EC',
        '0xFFE5E5E5',
        '0xFFFFFFFF',
        '0xFF1A1A1A',
        '0xFF1F1F1F',
        '0xFF6E6E6E',
        '0xFFB5B5B5',
        '0xFFEFEFEF',
        '0xFFD9D9D9',
        '0xFFF7F7F7',
    ]
    missing_hex = [x for x in required_hex if x.upper() not in ds_text.upper()]
    add('canonical_color_anchors_present', not missing_hex, missing_hex)

    legacy_hex = [
        '0xFF4A315D',
        '0xFF3F786E',
        '0xFFA85A41',
        '0xFF2F725F',
        '0xFF9B651F',
        '0xFFA94452',
        '0xFF496B98',
    ]
    leaked_legacy = [x for x in legacy_hex if x.upper() in ds_text.upper()]
    add('legacy_mineral_bloom_accents_removed', not leaked_legacy, leaked_legacy)

    add(
        'canonical_spacing_scale_present',
        'static const List<double> scale' in ds_text
        and 'micro = 2' in ds_text
        and 'x4l = 48' in ds_text,
    )
    add(
        'canonical_motion_scale_present',
        all(
            value in ds_text
            for value in [
                'milliseconds: 80',
                'milliseconds: 140',
                'milliseconds: 220',
                'milliseconds: 320',
                'milliseconds: 1350',
            ]
        ),
    )
    add('minimum_touch_target_is_48', 'minimumTouchTarget = 48' in ds_text)
    add(
        'approved_typography_contract_present',
        "arabicFamily = 'IBMPlexSansArabic'" in ds_text
        and "latinFamily = 'IBMPlexSans'" in ds_text,
    )

    contrast_pairs = {
        'primary/onPrimary': ('#800020', '#FFFFFF'),
        'primaryContainer/onPrimaryContainer': ('#F7E9EC', '#5C0016'),
        'secondary/onSecondary': ('#5C0016', '#FFFFFF'),
        'tertiary/onTertiary': ('#1A1A1A', '#FFFFFF'),
        'success/onSuccess': ('#800020', '#FFFFFF'),
        'warning/onWarning': ('#1A1A1A', '#FFFFFF'),
        'error/onError': ('#1F1F1F', '#FFFFFF'),
        'info/onInfo': ('#1A1A1A', '#FFFFFF'),
        'hold/onHold': ('#800020', '#FFFFFF'),
        'successContainer/onSuccessContainer': ('#F7E9EC', '#5C0016'),
        'warningContainer/onWarningContainer': ('#EFEFEF', '#1A1A1A'),
        'errorContainer/onErrorContainer': ('#EFEFEF', '#1A1A1A'),
        'infoContainer/onInfoContainer': ('#EFEFEF', '#1A1A1A'),
        'holdContainer/onHoldContainer': ('#F7E9EC', '#5C0016'),
        'surface/onSurface': ('#FFFFFF', '#1A1A1A'),
        'surface/onSurfaceVariant': ('#FFFFFF', '#6E6E6E'),
        'surfaceLow/onSurfaceVariant': ('#F7F7F7', '#6E6E6E'),
        'canvas/onSurface': ('#E5E5E5', '#1A1A1A'),
    }
    failing_contrast = {
        name: round(_contrast_ratio(*colors), 2)
        for name, colors in contrast_pairs.items()
        if _contrast_ratio(*colors) < 4.5
    }
    add(
        'canonical_text_contrast_pairs_meet_4_5_to_1',
        not failing_contrast,
        failing_contrast,
    )

    theme_text = (DS / 'theme/aafiatak_theme.dart').read_text(encoding='utf-8')
    chip_text = (
        DS / 'components/selection/aafiatak_chip.dart'
    ).read_text(encoding='utf-8')
    segmented_text = (
        DS / 'components/selection/aafiatak_segmented_control.dart'
    ).read_text(encoding='utf-8')
    add(
        'selection_controls_have_non_color_selected_indicators',
        'showCheckmark: true' in theme_text
        and 'showCheckmark: true' in chip_text
        and 'this.showSelectedIcon = true' in segmented_text,
    )
    add(
        'input_labels_and_messages_support_persistent_readability',
        'FloatingLabelBehavior.always' in theme_text
        and 'helperMaxLines: 3' in theme_text
        and 'errorMaxLines: 3' in theme_text,
    )

    button_text = (
        DS / 'components/buttons/aafiatak_button.dart'
    ).read_text(encoding='utf-8')
    add(
        'custom_button_semantics_preserve_accessible_tap_action',
        'onTap: isEnabled ? onPressed : null' in button_text,
    )

    app = (ROOT / 'lib/src/app/aafiatak_app.dart').read_text(encoding='utf-8')
    add(
        'arabic_locale_configured',
        "Locale('ar')" in app
        and 'AppLocalizations.localizationsDelegates' in app
        and 'AppLocalizations.supportedLocales' in app,
    )
    add('aafiatak_theme_is_app_theme', 'theme: AafiatakTheme.light' in app)
    add('no_dark_theme_added', 'darkTheme:' not in app and 'themeMode:' not in app)

    pubspec = (ROOT / 'pubspec.yaml').read_text(encoding='utf-8')
    add(
        'targets_flutter_3_47_and_dart_3_13',
        "flutter: '>=3.47.0'" in pubspec
        and "sdk: '>=3.13.0 <4.0.0'" in pubspec,
    )
    add('no_dependency_override', 'dependency_overrides:' not in pubspec)
    add('flutter_localizations_dependency_present', 'flutter_localizations:' in pubspec)
    l10n_yaml = (
        (ROOT / 'l10n.yaml').read_text(encoding='utf-8')
        if (ROOT / 'l10n.yaml').exists()
        else ''
    )
    arb = ROOT / 'lib/l10n/app_ar.arb'
    add(
        'flutter_gen_l10n_is_configured',
        'generate: true' in pubspec
        and 'synthetic-package: false' in l10n_yaml
        and arb.exists(),
    )
    visible_arabic_dart = []
    arabic = re.compile(r'[ء-ي]')
    for dart in LIB.rglob('*.dart'):
        if 'generated' in dart.parts and 'l10n' in dart.parts:
            continue
        if arabic.search(dart.read_text(encoding='utf-8')):
            visible_arabic_dart.append(str(dart.relative_to(ROOT)))
    add(
        'visible_arabic_copy_externalized_from_dart',
        not visible_arabic_dart,
        visible_arabic_dart,
    )

    otp_text = (
        DS / 'components/inputs/aafiatak_otp_input.dart'
    ).read_text(encoding='utf-8')
    add(
        'otp_input_is_configuration_driven_and_single_logical_field',
        'required this.length' in otp_text
        and 'List<Widget>.generate' in otp_text
        and 'widget.length' in otp_text
        and 'Semantics(' in otp_text
        and 'textField: true' in otp_text
        and 'AutofillHints.oneTimeCode' in otp_text,
    )
    status_text = (
        DS / 'components/feedback/aafiatak_status_block.dart'
    ).read_text(encoding='utf-8')
    add(
        'status_block_supports_optional_copy_and_next_action',
        'final String? message;' in status_text and 'final Widget? action;' in status_text,
    )
    add(
        'primary_action_bar_present',
        (DS / 'components/layout/aafiatak_primary_action_bar.dart').exists(),
    )
    add(
        'list_row_present',
        (DS / 'components/surfaces/aafiatak_list_row.dart').exists(),
    )
    contract_docs = [
        ROOT / 'docs/design_system/COMPONENT_COVERAGE_AUDIT_v1.3.md',
        ROOT / 'docs/design_system/COMPONENT_USAGE_CONTRACTS_v1.3.md',
    ]
    add(
        'component_coverage_and_usage_contracts_documented',
        all(path.exists() for path in contract_docs),
        [str(path.relative_to(ROOT)) for path in contract_docs if not path.exists()],
    )

    tests = list((ROOT / 'test/design_system').glob('*_test.dart'))
    add(
        'design_system_tests_authored',
        len(tests) >= 4,
        [str(p.relative_to(ROOT)) for p in tests],
    )

    passed = all(bool(item['passed']) for item in checks)
    report = {
        'scope': 'Aafiatak Flutter Design System — Burgundy Monochrome v2.1 migration before Domain Patterns',
        'flutter_cli_executed': False,
        'flutter_cli_reason': 'Run Flutter CLI gates on the developer machine/CI after token migration.',
        'static_result': 'passed' if passed else 'failed',
        'check_count': len(checks),
        'checks': checks,
    }
    out = ROOT / 'docs/design_system/STATIC_QA_REPORT.json'
    out.parent.mkdir(parents=True, exist_ok=True)
    out.write_text(
        json.dumps(report, ensure_ascii=False, indent=2) + '\n',
        encoding='utf-8',
    )
    print(json.dumps(report, ensure_ascii=False, indent=2))
    return 0 if passed else 1


if __name__ == '__main__':
    raise SystemExit(main())
