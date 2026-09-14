import 'package:flutter/material.dart';

import '../../foundations/foundations.dart';

/// Single item descriptor for [AafiatakInfoRows].
class InfoRowItem {
  const InfoRowItem({
    required this.label,
    required this.value,
    this.isLtr = false,
  });

  final String label;
  final String value;
  final bool isLtr;
}

/// Key-value information list matching the High-Fidelity `.info-list` / `.info-row` pattern.
class AafiatakInfoRows extends StatelessWidget {
  const AafiatakInfoRows({super.key, required this.rows});

  final List<InfoRowItem> rows;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        for (var i = 0; i < rows.length; i++) ...<Widget>[
          if (i > 0) const SizedBox(height: AafiatakSpacing.sm),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: 100,
                child: Text(
                  rows[i].label,
                  style: AafiatakTypography.bodySmall.copyWith(
                    color: AafiatakColors.textSecondary,
                  ),
                ),
              ),
              const SizedBox(width: AafiatakSpacing.sm),
              Expanded(
                child: Directionality(
                  textDirection: rows[i].isLtr
                      ? TextDirection.ltr
                      : Directionality.of(context),
                  child: Text(
                    rows[i].value,
                    textAlign: rows[i].isLtr ? TextAlign.end : TextAlign.start,
                    style: AafiatakTypography.label.copyWith(
                      color: AafiatakColors.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}
