import 'package:flutter/material.dart';

import '../../foundations/foundations.dart';

/// بطاقة موحّدة تعتمد مباشرة على [Card] من Material.
///
/// استخدمها للأسطح المتكررة بدل `Container` بحدود محلية. يأتي اللون والشكل
/// من `CardThemeData`، ويضاف [InkWell] فقط عند تمرير [onTap]. البطاقة لا تجلب
/// بيانات ولا تنفذ تنقلًا؛ الشاشة تمرر المحتوى والحدث.
class AafiatakCard extends StatelessWidget {
  const AafiatakCard({
    super.key,
    required this.child,
    this.elevated = false,
    this.onTap,
  });

  final Widget child;
  final bool elevated;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final content = Padding(
      padding: const EdgeInsets.all(AafiatakSpacing.space16),
      child: child,
    );

    return Card(
      elevation: elevated ? 2 : null,
      clipBehavior: onTap == null ? Clip.none : Clip.antiAlias,
      child: onTap == null ? content : InkWell(onTap: onTap, child: content),
    );
  }
}
