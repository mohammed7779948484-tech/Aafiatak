import 'package:aafiatak/src/design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

Widget buildDesignSystemTestApp(Widget child) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: AafiatakTheme.light,
    locale: const Locale('ar'),
    supportedLocales: const <Locale>[Locale('ar')],
    localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    home: Scaffold(body: SafeArea(child: child)),
  );
}
