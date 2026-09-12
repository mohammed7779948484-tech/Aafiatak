import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'aafiatak_text_field.dart';

/// Phone input primitive. Country/normalization policy belongs to feature logic.
class AafiatakPhoneField extends StatelessWidget {
  const AafiatakPhoneField({
    super.key,
    required this.label,
    this.controller,
    this.hint,
    this.helperText,
    this.errorText,
    this.validator,
    this.onChanged,
    this.onFieldSubmitted,
    this.focusNode,
    this.textInputAction,
    this.prefixIcon,
    this.suffixIcon,
    this.inputFormatters,
    this.enabled = true,
    this.readOnly = false,
    this.autofocus = false,
  });

  final String label;
  final TextEditingController? controller;
  final String? hint;
  final String? helperText;
  final String? errorText;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onFieldSubmitted;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final List<TextInputFormatter>? inputFormatters;
  final bool enabled;
  final bool readOnly;
  final bool autofocus;

  @override
  Widget build(BuildContext context) {
    return AafiatakTextField(
      label: label,
      controller: controller,
      hint: hint,
      helperText: helperText,
      errorText: errorText,
      validator: validator,
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      focusNode: focusNode,
      keyboardType: TextInputType.phone,
      textInputAction: textInputAction,
      inputFormatters: inputFormatters,
      autofillHints: const <String>[AutofillHints.telephoneNumber],
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      enabled: enabled,
      readOnly: readOnly,
      autofocus: autofocus,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.start,
    );
  }
}
