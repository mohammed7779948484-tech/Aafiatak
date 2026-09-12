import 'package:aafiatak/l10n/generated/app_localizations.dart';
import 'package:aafiatak/src/design_system/design_system.dart';
import 'package:flutter/material.dart';

Widget buildDesignSystemTestApp(Widget child) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: AafiatakTheme.light,
    locale: const Locale('ar'),
    supportedLocales: AppLocalizations.supportedLocales,
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    home: Scaffold(body: SafeArea(child: child)),
  );
}
