import 'package:flutter/material.dart';

import '../../components/components.dart';
import '../../foundations/foundations.dart';

class PolicyCard extends StatelessWidget {
  const PolicyCard({super.key, required this.title, required this.items});

  final String title;
  final List<String> items;

  @override
  Widget build(BuildContext context) {
    return AafiatakCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            children: <Widget>[
              const Icon(
                Icons.verified_user_outlined,
                size: 22,
                color: AafiatakColors.primary,
              ),
              const SizedBox(width: AafiatakSpacing.space8),
              Expanded(
                child: Text(
                  title,
                  style: AafiatakTypography.labelLarge.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AafiatakSpacing.space12),
          for (final item in items)
            Padding(
              padding: const EdgeInsetsDirectional.only(
                bottom: AafiatakSpacing.space8,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsetsDirectional.only(
                      top: AafiatakSpacing.space8,
                      start: AafiatakSpacing.space4,
                      end: AafiatakSpacing.space8,
                    ),
                    width: 5,
                    height: 5,
                    decoration: const BoxDecoration(
                      color: AafiatakColors.textSecondary,
                      shape: BoxShape.circle,
                    ),
                  ),
                  Expanded(
                    child: Text(item, style: AafiatakTypography.bodySmall),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
