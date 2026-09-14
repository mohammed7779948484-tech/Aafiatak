import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../design_system/design_system.dart';
import 'routing/app_router.dart';

class AafiatakApp extends StatelessWidget {
  const AafiatakApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'عافيتك',
      debugShowCheckedModeBanner: false,
      theme: AafiatakTheme.light,
      locale: const Locale('ar'),
      supportedLocales: const <Locale>[Locale('ar')],
      localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      routerConfig: appRouter,
    );
  }
}
