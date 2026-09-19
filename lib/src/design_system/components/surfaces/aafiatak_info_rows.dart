import 'package:flutter/material.dart';

import '../../foundations/foundations.dart';

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

class AafiatakInfoRows extends StatelessWidget {
  const AafiatakInfoRows({
    super.key,
    required this.rows,
  });

  final List<InfoRowItem> rows;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int i = 0; i < rows.length; i++)
          Padding(
            padding: EdgeInsets.only(
              top: i == 0 ? 0 : AafiatakSpacing.space12,
            ),
            child: _InfoRow(
              item: rows[i],
            ),
          ),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.item,
  });

  final InfoRowItem item;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100,
          child: Text(
            item.label,
            style: AafiatakTypography.bodySmall.copyWith(
              color: AafiatakColors.textSecondary,
            ),
          ),
        ),

        const SizedBox(
          width: AafiatakSpacing.space12,
        ),

        Expanded(
          child: Text(
            item.value,
            textDirection: item.isLtr
                ? TextDirection.ltr
                : TextDirection.rtl,
            textAlign: item.isLtr
                ? TextAlign.end
                : TextAlign.start,
            style: AafiatakTypography.label.copyWith(
              color: AafiatakColors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}