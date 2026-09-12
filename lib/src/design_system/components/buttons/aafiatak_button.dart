import 'package:aafiatak/l10n/generated/app_localizations.dart';
import 'package:flutter/material.dart';

import '../../foundations/foundations.dart';

enum AafiatakButtonVariant { filled, tonal, outline, text, destructive }

/// Standard Aafiatak text action built on Material 3 button primitives.
class AafiatakButton extends StatelessWidget {
  const AafiatakButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = AafiatakButtonVariant.filled,
    this.leading,
    this.trailing,
    this.isLoading = false,
    this.isExpanded = false,
    this.semanticLabel,
    this.loadingSemanticLabel,
  });

  final String label;
  final VoidCallback? onPressed;
  final AafiatakButtonVariant variant;
  final Widget? leading;
  final Widget? trailing;
  final bool isLoading;
  final bool isExpanded;
  final String? semanticLabel;
  final String? loadingSemanticLabel;

  @override
  Widget build(BuildContext context) {
    final reduceMotion = MediaQuery.disableAnimationsOf(context);
    final child = AnimatedSwitcher(
      duration: reduceMotion ? Duration.zero : AafiatakMotion.fast,
      child: isLoading
          ? SizedBox.square(
              key: const ValueKey<String>('loading'),
              dimension: AafiatakSizes.iconInline,
              child: CircularProgressIndicator(
                strokeWidth: AafiatakSizes.progressStrokeCompact,
                color: _foregroundColor(context),
              ),
            )
          : Row(
              key: const ValueKey<String>('content'),
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                if (leading != null) ...<Widget>[
                  leading!,
                  const SizedBox(width: AafiatakSpacing.xs),
                ],
                Flexible(child: Text(label, textAlign: TextAlign.center)),
                if (trailing != null) ...<Widget>[
                  const SizedBox(width: AafiatakSpacing.xs),
                  trailing!,
                ],
              ],
            ),
    );

    final button = switch (variant) {
      AafiatakButtonVariant.filled => FilledButton(
        onPressed: isLoading ? null : onPressed,
        child: child,
      ),
      AafiatakButtonVariant.tonal => FilledButton.tonal(
        onPressed: isLoading ? null : onPressed,
        child: child,
      ),
      AafiatakButtonVariant.outline => OutlinedButton(
        onPressed: isLoading ? null : onPressed,
        child: child,
      ),
      AafiatakButtonVariant.text => TextButton(
        onPressed: isLoading ? null : onPressed,
        child: child,
      ),
      AafiatakButtonVariant.destructive => FilledButton(
        onPressed: isLoading ? null : onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.error,
          foregroundColor: Theme.of(context).colorScheme.onError,
        ),
        child: child,
      ),
    };

    final isEnabled = onPressed != null && !isLoading;
    final l10n = AppLocalizations.of(context);

    return Semantics(
      button: true,
      enabled: isEnabled,
      onTap: isEnabled ? onPressed : null,
      liveRegion: isLoading,
      excludeSemantics: true,
      label: semanticLabel ?? label,
      value: isLoading
          ? (loadingSemanticLabel ?? l10n.semanticsActionInProgress)
          : null,
      child: isExpanded
          ? SizedBox(width: double.infinity, child: button)
          : button,
    );
  }

  Color _foregroundColor(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return switch (variant) {
      AafiatakButtonVariant.filled => scheme.onPrimary,
      AafiatakButtonVariant.tonal => scheme.onSecondaryContainer,
      AafiatakButtonVariant.outline => scheme.primary,
      AafiatakButtonVariant.text => scheme.primary,
      AafiatakButtonVariant.destructive => scheme.onError,
    };
  }
}
