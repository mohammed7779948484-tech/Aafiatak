import 'package:flutter/material.dart';

/// حقل البحث المشترك لشاشات الاكتشاف والبحث في عافيتك.
///
/// يعتمد مباشرة على [SearchBar]، لذلك تأتي هيئة السطح والارتفاع والحواف من
/// `SearchBarThemeData`. استخدمه للبحث فقط، ولا تضف إليه منطق جلب بيانات أو
/// اقتراحات؛ الشاشة هي المسؤولة عن البيانات من خلال [onChanged] و[onSubmitted].
class AafiatakSearchField extends StatelessWidget {
  const AafiatakSearchField({
    super.key,
    required this.hintText,
    this.controller,
    this.onChanged,
    this.onSubmitted,
    this.enabled = true,
  });

  final String hintText;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      controller: controller,
      enabled: enabled,
      hintText: hintText,
      leading: const Icon(Icons.search_rounded, size: 22),
      onChanged: onChanged,
      onSubmitted: onSubmitted,
    );
  }
}
