import 'package:flutter/material.dart';

import '../../foundations/foundations.dart';

/// Button variants conforming to the High-Fidelity Burgundy Monochrome specification.
enum AafiatakButtonVariant { primary, tonal, secondary, destructive, text }

/// Aafiatak canonical button component.
///
/// Variants:
/// - [primary]: Burgundy fill with subtle shadow
/// - [tonal]: Light burgundy container (#F7E9EC) with deep burgundy text (#5C0016)
/// - [secondary]: White surface with subtle border and burgundy text
/// - [destructive]: Neutral container fill with charcoal text
/// - [text]: Transparent background with burgundy text
class AafiatakButton extends StatelessWidget {
  const AafiatakButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = AafiatakButtonVariant.primary,
    this.block = false,
    this.compact = false,
    this.icon,
  });

  final String label;
  final VoidCallback? onPressed;
  final AafiatakButtonVariant variant;
  final bool block;
  final bool compact;
  final dynamic icon; // Can be IconData or Widget

  @override
  Widget build(BuildContext context) {
    final isEnabled = onPressed != null;
    final minHeight = compact ? 44.0 : 48.0;
    final textStyle = compact
        ? AafiatakTypography.label
        : AafiatakTypography.labelLarge;

    Color backgroundColor;
    Color foregroundColor;
    BorderSide borderSide = BorderSide.none;
    List<BoxShadow> shadows = const <BoxShadow>[];

    switch (variant) {
      case AafiatakButtonVariant.primary:
        backgroundColor = AafiatakColors.primary;
        foregroundColor = AafiatakColors.onPrimary;
        if (isEnabled) {
          shadows = const <BoxShadow>[
            BoxShadow(
              color: Color(0x1A800020),
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ];
        }
      case AafiatakButtonVariant.tonal:
        backgroundColor = AafiatakColors.primaryContainer;
        foregroundColor = AafiatakColors.onPrimaryContainer;
      case AafiatakButtonVariant.secondary:
        backgroundColor = AafiatakColors.surface;
        foregroundColor = AafiatakColors.primary;
        borderSide = const BorderSide(color: AafiatakColors.outline, width: 1);
      case AafiatakButtonVariant.destructive:
        backgroundColor = AafiatakColors.surfaceContainer;
        foregroundColor = AafiatakColors.textPrimary;
      case AafiatakButtonVariant.text:
        backgroundColor = Colors.transparent;
        foregroundColor = AafiatakColors.primary;
    }

    Widget? iconWidget;
    if (icon is IconData) {
      iconWidget = Icon(
        icon as IconData,
        size: compact ? 18 : 20,
        color: isEnabled ? foregroundColor : AafiatakColors.textSecondary,
      );
    } else if (icon is Widget) {
      iconWidget = IconTheme(
        data: IconThemeData(size: compact ? 18 : 20, color: foregroundColor),
        child: icon as Widget,
      );
    }

    final Widget labelWidget = Text(
      label,
      style: textStyle.copyWith(
        color: isEnabled ? foregroundColor : AafiatakColors.textSecondary,
        fontWeight: FontWeight.w600,
      ),
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
    );

    final Widget content = Row(
      mainAxisSize: block ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        if (iconWidget != null) ...<Widget>[
          iconWidget,
          const SizedBox(width: AafiatakSpacing.xs),
        ],
        Flexible(fit: FlexFit.loose, child: labelWidget),
      ],
    );

    return Opacity(
      opacity: isEnabled ? 1.0 : 0.52,
      child: Container(
        constraints: BoxConstraints(
          minHeight: minHeight,
          minWidth: block ? double.infinity : 0,
        ),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: AafiatakRadii.button,
          border: borderSide != BorderSide.none
              ? Border.fromBorderSide(borderSide)
              : null,
          boxShadow: shadows,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onPressed,
            borderRadius: AafiatakRadii.button,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: compact ? AafiatakSpacing.sm : AafiatakSpacing.md,
                vertical: compact ? 8 : 10,
              ),
              child: Center(widthFactor: block ? 1.0 : null, child: content),
            ),
          ),
        ),
      ),
    );
  }
}
