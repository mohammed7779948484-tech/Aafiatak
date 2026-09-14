import 'package:flutter/material.dart';

import '../../foundations/foundations.dart';

/// Section header matching the High-Fidelity `.section-heading` pattern.
///
/// Features an H3 label on the start side and an optional meta subtitle or action on the end side.
class AafiatakSectionHeading extends StatelessWidget {
  const AafiatakSectionHeading({super.key, required this.label, this.meta});

  final String label;
  final String? meta;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Text(
            label,
            style: AafiatakTypography.titleLarge.copyWith(
              color: AafiatakColors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        if (meta != null && meta!.isNotEmpty)
          Text(
            meta!,
            style: AafiatakTypography.labelSmall.copyWith(
              color: AafiatakColors.textSecondary,
            ),
          ),
      ],
    );
  }
}
