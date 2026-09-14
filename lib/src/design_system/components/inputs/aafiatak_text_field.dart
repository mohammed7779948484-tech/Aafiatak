import 'package:flutter/material.dart';

/// Thin wrapper over [TextFormField] for common Aafiatak form inputs.
class AafiatakTextField extends StatelessWidget {
  const AafiatakTextField({
    super.key,
    required this.hintText,
    this.controller,
    this.labelText,
    this.helperText,
    this.errorText,
    this.keyboardType,
    this.onChanged,
    this.onFieldSubmitted,
    this.enabled = true,
    this.maxLines = 1,
    this.prefixIcon,
    this.suffixIcon,
    this.textDirection,
  });

  final String hintText;
  final TextEditingController? controller;
  final String? labelText;
  final String? helperText;
  final String? errorText;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onFieldSubmitted;
  final bool enabled;
  final int maxLines;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextDirection? textDirection;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      enabled: enabled,
      keyboardType: keyboardType,
      maxLines: maxLines,
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      textDirection: textDirection,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        helperText: helperText,
        errorText: errorText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
    );
  }
}
