import 'package:aafiatak/src/app/patient_shell.dart';
import 'package:aafiatak/src/design_system/design_system.dart';
import 'package:aafiatak/src/features/profile/mock_data.dart';
import 'package:flutter/material.dart';

/// شاشة «حسابي»: بطاقة بطل شخصية وبيانات الحساب وزرا تعديل وخروج.
/// جذر بوضع العنوان (لا الشعار)، وزر الخروج ظاهر عمدًا عرضيًا فقط.
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    super.key,
    required this.onEditRequested,
    required this.onLogoutRequested,
    required this.onNotificationPressed,
    required this.onTabSelected,
  });

  final VoidCallback onEditRequested;
  final VoidCallback onLogoutRequested;
  final VoidCallback onNotificationPressed;
  final ValueChanged<PatientTab> onTabSelected;

  @override
  Widget build(BuildContext context) {
    return PatientShell.root(
      title: 'حسابي',
      activeTab: PatientTab.profile,
      onTabSelected: onTabSelected,
      onNotificationPressed: onNotificationPressed,
      scrollable: true,
      body: Padding(
        padding: const EdgeInsetsDirectional.only(
          top: 16,
          start: 16,
          end: 16,
          bottom: 32,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: AafiatakSpacing.space16,
          children: [
            const _ProfileHero(profile: patientProfile1),
            AafiatakCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: AafiatakSpacing.space12,
                children: [
                  const AafiatakSectionHeading(label: 'بيانات الحساب'),
                  AafiatakInfoRows(
                    rows: [
                      InfoRowItem(
                        label: 'الاسم الكامل',
                        value: patientProfile1.name,
                      ),
                      InfoRowItem(
                        label: 'رقم الهاتف الموثق',
                        value: patientProfile1.maskedPhone,
                        isLtr: true,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            AafiatakButton.primary(
              label: 'تعديل البيانات',
              icon: Icons.edit_outlined,
              onPressed: onEditRequested,
              fullWidth: true,
            ),
            AafiatakButton.secondary(
              label: 'تسجيل الخروج',
              icon: Icons.logout_outlined,
              onPressed: onLogoutRequested,
              fullWidth: true,
            ),
          ],
        ),
      ),
    );
  }
}

/// بطاقة البطل: أفاتار بورجوندي مصمت بأحرف المريض فوق تدرج فاتح.
class _ProfileHero extends StatelessWidget {
  const _ProfileHero({required this.profile});

  final PatientProfile profile;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AafiatakSpacing.space20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AafiatakColors.primaryContainer, Color(0xEBFFFFFF)],
        ),
        border: Border.all(color: const Color(0x14800020)),
        borderRadius: AafiatakRadii.extraLarge,
      ),
      child: Row(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: const BoxDecoration(
              color: AafiatakColors.primary,
              borderRadius: AafiatakRadii.extraLarge,
            ),
            alignment: Alignment.center,
            child: Text(
              profile.avatarText,
              style: AafiatakTypography.labelLarge.copyWith(
                color: AafiatakColors.surface,
                fontWeight: FontWeight.w700,
                fontSize: 22,
              ),
            ),
          ),
          const SizedBox(width: AafiatakSpacing.space16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  profile.name,
                  style: AafiatakTypography.h3.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(profile.profileNote, style: AafiatakTypography.bodySmall),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
