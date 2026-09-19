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
    this.onSubmitted,
  });

  final String hintText;
  final ValueChanged<String>? onSubmitted;

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      hintText: hintText,
      leading: const Icon(Icons.search_rounded, size: 22),
      onSubmitted: onSubmitted,
    );
  }
}
