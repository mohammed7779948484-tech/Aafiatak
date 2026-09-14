import 'package:flutter/material.dart';

import '../../foundations/foundations.dart';

/// Section header matching the High-Fidelity `.section-heading` pattern.
///
/// Features an H3 label on the start side and an optional meta subtitle or action on the end side.
class AafiatakSectionHeading extends StatelessWidget {
  const AafiatakSectionHeading({
    super.key,
    required this.label,
    this.meta,
    this.action,
  });

  final String label;
  final String? meta;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: <Widget>[
        Expanded(
          child: Text(
            label,
            style: AafiatakTypography.h3.copyWith(
              color: AafiatakColors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        if (action != null)
          action!
        else if (meta != null && meta!.isNotEmpty)
          Text(
            meta!,
            style: AafiatakTypography.caption.copyWith(
              color: AafiatakColors.textSecondary,
            ),
          ),
      ],
    );
  }
}
