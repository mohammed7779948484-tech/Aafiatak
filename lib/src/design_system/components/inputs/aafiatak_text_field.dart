import 'package:flutter/material.dart';

import '../../foundations/foundations.dart';

/// Simplified form text input matching the High-Fidelity design system.
///
/// Follows the High-Fidelity .input-group pattern:
/// - Distinct top label
/// - 56px minimum height white surface shell
/// - High-Fidelity typography and monochrome borders
/// - Clean helper/error text below the shell
class AafiatakTextField extends StatelessWidget {
  const AafiatakTextField({
    super.key,
    this.label,
    String? hint,
    String? hintText,
    this.helperText,
    this.errorText,
    this.controller,
    this.initialValue,
    this.keyboardType,
    this.onChanged,
    this.onSubmitted,
    this.obscureText = false,
    this.enabled = true,
    this.maxLines = 1,
    this.prefixIcon,
    this.suffixIcon,
    this.textDirection,
    this.autofocus = false,
  }) : hint = hintText ?? hint;

  final String? label;
  final String? hint;
  final String? helperText;
  final String? errorText;
  final TextEditingController? controller;
  final String? initialValue;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final bool obscureText;
  final bool enabled;
  final int? maxLines;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextDirection? textDirection;
  final bool autofocus;

  @override
  Widget build(BuildContext context) {
    final hasError = errorText != null && errorText!.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        if (label != null) ...<Widget>[
          Text(
            label!,
            style: AafiatakTypography.label.copyWith(
              color: AafiatakColors.textPrimary,
            ),
          ),
          const SizedBox(height: AafiatakSpacing.xs),
        ],
        Container(
          constraints: const BoxConstraints(minHeight: 56),
          decoration: BoxDecoration(
            color: enabled
                ? AafiatakColors.surface
                : AafiatakColors.surfaceContainer,
            borderRadius: AafiatakRadii.md,
            border: Border.all(
              color: hasError ? AafiatakColors.error : AafiatakColors.outline,
              width: hasError ? 1.5 : 1,
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: AafiatakSpacing.md),
          alignment: Alignment.center,
          child: Row(
            children: <Widget>[
              if (prefixIcon != null) ...<Widget>[
                IconTheme(
                  data: const IconThemeData(
                    size: 22,
                    color: AafiatakColors.primary,
                  ),
                  child: prefixIcon!,
                ),
                const SizedBox(width: AafiatakSpacing.sm),
              ],
              Expanded(
                child: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: hint,
                    hintStyle: AafiatakTypography.body.copyWith(
                      color: AafiatakColors.textSecondary,
                    ),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                    isDense: true,
                    fillColor: Colors.transparent,
                    filled: false,
                  ),
                  style: AafiatakTypography.body.copyWith(
                    color: enabled
                        ? AafiatakColors.textPrimary
                        : AafiatakColors.textSecondary,
                  ),
                  keyboardType: keyboardType,
                  onChanged: onChanged,
                  onSubmitted: onSubmitted,
                  obscureText: obscureText,
                  enabled: enabled,
                  maxLines: obscureText ? 1 : maxLines,
                  textDirection: textDirection,
                  autofocus: autofocus,
                  cursorColor: AafiatakColors.primary,
                ),
              ),
              if (suffixIcon != null) ...<Widget>[
                const SizedBox(width: AafiatakSpacing.sm),
                IconTheme(
                  data: const IconThemeData(
                    size: 22,
                    color: AafiatakColors.textSecondary,
                  ),
                  child: suffixIcon!,
                ),
              ],
            ],
          ),
        ),
        if (hasError ||
            (helperText != null && helperText!.isNotEmpty)) ...<Widget>[
          const SizedBox(height: AafiatakSpacing.xxs),
          Text(
            hasError ? errorText! : helperText!,
            style: AafiatakTypography.bodySmall.copyWith(
              color: hasError
                  ? AafiatakColors.error
                  : AafiatakColors.textSecondary,
            ),
          ),
        ],
      ],
    );
  }
}
