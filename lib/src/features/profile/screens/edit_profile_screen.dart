import 'package:aafiatak/src/app/patient_shell.dart';
import 'package:aafiatak/src/design_system/design_system.dart';
import 'package:aafiatak/src/features/profile/mock_data.dart';
import 'package:flutter/material.dart';

/// شاشة «تعديل البيانات»: حقل الاسم الوحيد القابل للتعديل وبطاقة
/// هاتف للقراءة فقط وزر حفظ يرفع القيمة عبر onSave.
/// StatefulWidget لأن حاوية تحكم النص تُنشأ وتُتلف مع دورة الحياة.
class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({
    super.key,
    required this.onSave,
    required this.onBackPressed,
  });

  final ValueChanged<String> onSave;
  final VoidCallback onBackPressed;

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late final TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: patientProfile1.name);
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PatientShell.detail(
      title: 'تعديل البيانات',
      screenId: 'PAT-17',
      onBackPressed: widget.onBackPressed,
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
            AafiatakTextField(
              controller: _nameController,
              label: 'الاسم الكامل',
              helperText: 'يمكنك تعديل الاسم وحفظ التغييرات عند الانتهاء.',
            ),
            AafiatakCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: AafiatakSpacing.space12,
                children: [
                  const AafiatakSectionHeading(label: 'رقم الهاتف الموثق'),
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: Text(
                      patientProfile1.maskedPhone,
                      style: AafiatakTypography.bodyLarge.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const Text(
                    'رقم الهاتف هو هوية الدخول الموثقة ولا يتم تعديله من هذا '
                    'الحقل.',
                    style: AafiatakTypography.bodySmall,
                  ),
                ],
              ),
            ),
            AafiatakButton.primary(
              label: 'حفظ التغييرات',
              fullWidth: true,
              onPressed: () => widget.onSave(_nameController.text),
            ),
          ],
        ),
      ),
    );
  }
}
