#!/usr/bin/env python3
from __future__ import annotations

import json
import re
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
LIB = ROOT / 'lib'
SRC = LIB / 'src'


def dart_files() -> list[Path]:
    return sorted([*LIB.rglob('*.dart'), *(ROOT / 'test').rglob('*.dart')])


def local_import_errors() -> list[str]:
    errors: list[str] = []
    directive = re.compile(r"^(?:import|export|part)\s+'([^']+)'", re.MULTILINE)
    for file in dart_files():
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


def main() -> int:
    checks: list[dict[str, object]] = []

    def add(name: str, passed: bool, details: object = None) -> None:
        checks.append({'name': name, 'passed': passed, 'details': details})

    required_dirs = [
        SRC / 'app',
        SRC / 'design_system',
        SRC / 'features',
    ]
    missing_dirs = [str(p.relative_to(ROOT)) for p in required_dirs if not p.is_dir()]
    add('required_architecture_boundaries_exist', not missing_dirs, missing_dirs)

    banned_paths = [
        SRC / 'imports',
        SRC / 'services',
        SRC / 'utils',
        SRC / 'extensions',
        SRC / 'config',
        SRC / 'core',
        SRC / 'flavors.dart',
        SRC / 'shared',
        ROOT / '.env',
        ROOT / '.env.example',
        ROOT / 'flutter_native_splash.yaml',
        ROOT / 'l10n.yaml',
    ]
    existing_banned = [str(p.relative_to(ROOT)) for p in banned_paths if p.exists()]
    add('generator_grab_bag_and_premature_infrastructure_removed', not existing_banned, existing_banned)

    all_lib_text = '\n'.join(p.read_text(encoding='utf-8') for p in LIB.rglob('*.dart'))
    auth_conflicts = sorted(set(re.findall(
        r'(?i)(forgot.?password|password|email(?:Address)?|signup_screen|login_screen)',
        all_lib_text,
    )))
    add('no_email_password_auth_scaffolding', not auth_conflicts, auth_conflicts)

    unrelated = sorted(set(re.findall(r'(?i)(flutterinit|perfectly planned|your journey|travel)', all_lib_text)))
    add('no_unrelated_generator_product_copy', not unrelated, unrelated)

    riverpod_references = []
    for p in LIB.rglob('*.dart'):
        text = p.read_text(encoding='utf-8')
        if ('flutter_riverpod' in text or 'StateNotifierProvider' in text
                or 'ChangeNotifierProvider' in text or 'StateProvider<' in text
                or 'ProviderScope' in text or 'ConsumerWidget' in text or 'ref.watch' in text):
            riverpod_references.append(str(p.relative_to(ROOT)))
    add('no_riverpod_in_lib', not riverpod_references, riverpod_references)

    global_nav = []
    for p in LIB.rglob('*.dart'):
        text = p.read_text(encoding='utf-8')
        if ('GlobalKey<NavigatorState>' in text or 'rootContext' in text
                or 'rootNavigatorKey' in text):
            global_nav.append(str(p.relative_to(ROOT)))
    add('no_global_navigator_or_build_context', not global_nav, global_nav)

    empty_dart = [str(p.relative_to(ROOT)) for p in dart_files() if not p.read_text(encoding='utf-8').strip()]
    add('no_empty_dart_files', not empty_dart, empty_dart)

    patterns = SRC / 'design_system/patterns'
    patterns_exist = patterns.is_dir() and len(list(patterns.rglob('*.dart'))) >= 7
    add('domain_patterns_exist_and_isolated', patterns_exist, [str(patterns.relative_to(ROOT))])

    design_system_feature_imports: list[str] = []
    for p in (SRC / 'design_system').rglob('*.dart'):
        text = p.read_text(encoding='utf-8')
        if '/features/' in text or "../../features/" in text or "../features/" in text:
            design_system_feature_imports.append(str(p.relative_to(ROOT)))
    add(
        'design_system_does_not_import_features',
        not design_system_feature_imports,
        design_system_feature_imports,
    )

    imports = local_import_errors()
    add('all_local_dart_imports_resolve', not imports, imports)

    pubspec = (ROOT / 'pubspec.yaml').read_text(encoding='utf-8')
    banned_deps = [
        'flutter_riverpod:', 'cached_network_image:', 'flutter_svg:',
        'hugeicons:', 'skeletonizer:', 'intl:',
        'fpdart:', 'equatable:', 'shared_preferences:',
        'internet_connection_checker_plus:', 'flutter_dotenv:',
        'flutter_animate:', 'smooth_page_indicator:', 'logger:',
        'url_launcher:', 'flutter_native_splash:', 'cupertino_icons:',
    ]
    present_banned_deps = [dep for dep in banned_deps if dep in pubspec]
    add('unused_or_premature_dependencies_removed', not present_banned_deps, present_banned_deps)
    add('go_router_present', 'go_router:' in pubspec)

    app = (SRC / 'app/aafiatak_app.dart').read_text(encoding='utf-8')
    add('app_shell_is_arabic_and_uses_aafiatak_theme', "Locale('ar')" in app and 'AafiatakTheme.light' in app)

    main_text = (LIB / 'main.dart').read_text(encoding='utf-8')
    add('main_launches_aafiatak_app_without_riverpod', 'runApp(const AafiatakApp())' in main_text and 'ProviderScope' not in main_text)

    analysis_options = (ROOT / 'analysis_options.yaml').read_text(encoding='utf-8')
    add(
        'analyzer_language_strictness_enabled',
        'strict-casts: true' in analysis_options
        and 'strict-inference: true' in analysis_options
        and 'strict-raw-types: true' in analysis_options,
    )

    assets = ROOT / 'assets'
    add('irrelevant_social_assets_removed', not assets.exists(), None if not assets.exists() else str(assets.relative_to(ROOT)))

    passed = all(bool(item['passed']) for item in checks)
    report = {
        'scope': 'Aafiatak Flutter v2.1 Burgundy Monochrome architecture audit',
        'static_result': 'passed' if passed else 'failed',
        'check_count': len(checks),
        'checks': checks,
    }

    out = ROOT / 'docs/architecture/STATIC_ARCHITECTURE_QA_REPORT.json'
    out.write_text(json.dumps(report, ensure_ascii=False, indent=2) + '\n', encoding='utf-8')
    print(json.dumps(report, ensure_ascii=False, indent=2))
    return 0 if passed else 1


if __name__ == '__main__':
    raise SystemExit(main())
