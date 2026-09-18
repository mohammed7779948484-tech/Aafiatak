import 'package:aafiatak/src/design_system/design_system.dart';
import 'package:flutter/material.dart';

/// اختصارات الاستكشاف في الرئيسية: ثلاثة مداخل متساوية العرض
/// (الأطباء، الخدمات، المنشآت). تستقبل وجهات التنقل كـ callbacks
/// ولا تعرف شيئًا عن المسارات.

class QuickActions extends StatelessWidget {
  const QuickActions({
    super.key,
    required this.onSearchRequested,
    required this.onServiceRequested,
    required this.onFacilityRequested,
  });
  final VoidCallback onSearchRequested;
  final VoidCallback onServiceRequested;
  final VoidCallback onFacilityRequested;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _QuickActionTile(
            icon: Icons.person_outline_rounded,
            label: 'الأطباء',
            onTap: onSearchRequested,
          ),
        ),
        const SizedBox(width: AafiatakSpacing.space8),
        Expanded(
          child: _QuickActionTile(
            icon: Icons.add_circle_outline,
            label: 'الخدمات',
            onTap: onServiceRequested,
          ),
        ),
        const SizedBox(width: AafiatakSpacing.space8),
        Expanded(
          child: _QuickActionTile(
            icon: Icons.location_on_outlined,
            label: 'المنشآت',
            onTap: onFacilityRequested,
          ),
        ),
      ],
    );
  }
}

/// بلاطة اختصار واحدة: أيقونة داخل مربع بورجوندي فاتح مع تسمية تحتها.

class _QuickActionTile extends StatelessWidget {
  const _QuickActionTile({
    required this.icon,
    required this.label,
    required this.onTap,
  });
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AafiatakCard(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: AafiatakColors.primaryContainer,
              borderRadius: AafiatakRadii.medium,
            ),
            child: Icon(icon, size: 21, color: AafiatakColors.primary),
          ),
          const SizedBox(height: AafiatakSpacing.space8),
          Text(label, style: AafiatakTypography.label),
        ],
      ),
    );
  }
}
