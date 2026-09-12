import 'package:aafiatak/l10n/generated/app_localizations.dart';
import 'package:flutter/material.dart';

import '../../../../design_system/design_system.dart';

/// Development-only landing surface for the UI foundation phase.
///
/// This is not a patient-product screen and intentionally contains no booking,
/// authentication, payment, or backend assumptions. Replace this route when
/// the first approved patient feature is implemented.
class StarterScreen extends StatelessWidget {
  const StarterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AafiatakAppBar(title: l10n.appTitle),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsetsDirectional.fromSTEB(
            AafiatakSpacing.md,
            AafiatakSpacing.lg,
            AafiatakSpacing.md,
            AafiatakSpacing.x2l,
          ),
          children: <Widget>[
            Text(l10n.starterHeadline, style: textTheme.headlineSmall),
            const SizedBox(height: AafiatakSpacing.sm),
            Text(l10n.starterDescription, style: textTheme.bodyMedium),
            const SizedBox(height: AafiatakSpacing.xl),
            AafiatakStatusBlock(
              title: l10n.starterFoundationTitle,
              message: l10n.starterFoundationMessage,
              tone: AafiatakFeedbackTone.success,
            ),
            const SizedBox(height: AafiatakSpacing.lg),
            AafiatakCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    l10n.starterVersionLimitsTitle,
                    style: textTheme.titleMedium,
                  ),
                  const SizedBox(height: AafiatakSpacing.sm),
                  Text(
                    l10n.starterVersionLimitsMessage,
                    style: textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            const SizedBox(height: AafiatakSpacing.lg),
            AafiatakButton(label: l10n.starterDisabledButton, onPressed: null),
          ],
        ),
      ),
    );
  }
}
