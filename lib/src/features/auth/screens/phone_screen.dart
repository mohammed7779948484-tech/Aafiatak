import 'package:flutter/material.dart';

import 'package:aafiatak/src/app/patient_shell.dart';
import 'package:aafiatak/src/design_system/design_system.dart';

import '../widgets/auth_intro.dart';
import '../auth_intent.dart';

class PhoneScreen extends StatefulWidget {
  const PhoneScreen({
    super.key,
    required this.intent,
    required this.onOtpRequested,
  });

  final AuthIntent intent;
  final ValueChanged<String> onOtpRequested;

  @override
  State<PhoneScreen> createState() => _PhoneScreenState();
}

class _PhoneScreenState extends State<PhoneScreen> {
  final TextEditingController _PhoneController = TextEditingController();

  @override
  void dispose() {
    _PhoneController.dispose();
    super.dispose();
  }

  void _handleOtpRequested() {
    final phone = _PhoneController.text;

    widget.onOtpRequested(phone);
  }

  @override
  Widget build(BuildContext context) {
    return PatientShell.detail(
      title: "رقم الهاتف",
      scrollable: true,
      body: Padding(
        padding: const EdgeInsets.all(AafiatakSpacing.space16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const AuthIntro(
              eyebrow: "التحقق برقم الهاتف",
              title: "أدخل رقم هاتفك",
              description: Text(
                "سنستخدم رقم الهاتف الموثق كهوية دخول، ثم نرسل رمز تحقق لمرة واحدة عبر واتساب.",
              ),
            ),
            const SizedBox(height: AafiatakSpacing.space32),
            AafiatakTextField(
              controller: _PhoneController,
              label: "رقم الهاتف",
              hintText: "اضفط",

              keyboardType: TextInputType.phone,
              textDirection: TextDirection.ltr,
            ),
            const SizedBox(height: AafiatakSpacing.space32),
            _InfoCard(),
          ],
        ),
      ),
      bottomAction: AafiatakButton.primary(
        label: "ارسال رمز التحقق عبر واتساب",
        fullWidth: true,
        onPressed: _handleOtpRequested,
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const AafiatakCard(
      child: Row(
        children: [
          Icon(Icons.app_blocking),
          SizedBox(width: AafiatakSpacing.space16),

          Text("سيصل الرمز عبر واتساب", style: AafiatakTypography.h3),
        ],
      ),
    );
  }
}
