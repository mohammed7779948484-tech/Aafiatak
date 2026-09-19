import 'package:flutter/material.dart';

import '../../foundations/foundations.dart';

/// حقل إدخال موحّد للنماذج العامة في تطبيق عافيتك.
///
/// يظهر [label] فوق الحقل كما في التصميم المرجعي، بينما تأتي الحدود والألوان
/// وحالات التركيز والخطأ من `InputDecorationTheme`. لا تضف حدودًا محلية داخل
/// الـ Feature؛ وإذا كان الحقل خاصًا بميزة واحدة فضع تركيبه في `feature/widgets`.
class AafiatakTextField extends StatelessWidget {
  const AafiatakTextField({
    super.key,
    this.controller,
    this.label,
    this.hintText,
    this.helperText,
    this.keyboardType,
    this.textDirection,
  });

  final TextEditingController? controller;
  final String? label;
  final String? hintText;
  final String? helperText;
  final TextInputType? keyboardType;
  final TextDirection? textDirection;

  @override
  Widget build(BuildContext context) {
    final visibleLabel = label;
    final field = TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      textDirection: textDirection,
      decoration: InputDecoration(hintText: hintText, helperText: helperText),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        if (visibleLabel != null) ...<Widget>[
          ExcludeSemantics(
            child: Text(visibleLabel, style: AafiatakTypography.label),
          ),
          const SizedBox(height: AafiatakSpacing.space8),
        ],
        if (visibleLabel != null)
          Semantics(label: visibleLabel, textField: true, child: field)
        else
          field,
      ],
    );
  }
}
