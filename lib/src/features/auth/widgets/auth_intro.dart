import 'package:flutter/material.dart';

import 'package:aafiatak/src/design_system/design_system.dart';

class AuthIntro extends StatelessWidget {
  const AuthIntro({
    super.key,
    required this.eyebrow,
    required this.title,
    required this.description,
  });

  final String eyebrow;
  final String title;
  final Widget description;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          eyebrow,
          style: AafiatakTypography.label.copyWith(
            color: AafiatakColors.primary,
          ),
        ),
        const SizedBox(height: AafiatakSpacing.space8),

        Text(title, style: AafiatakTypography.h1),
        SizedBox(height: AafiatakSpacing.space12),

        DefaultTextStyle(
          style: AafiatakTypography.bodySmall,
          child: description,
        ),
      ],
    );
  }
}
