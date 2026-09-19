import 'package:flutter/material.dart';

import 'package:aafiatak/src/app/patient_shell.dart';
import 'package:aafiatak/src/design_system/design_system.dart';

import '../widgets/auth_intro.dart';
import '../auth_intent.dart';

class AuthEntryScreen extends StatelessWidget {
  const AuthEntryScreen({
    super.key,
    required this.onPhoneRequested,
    required this.onBrowseTap,
  });

  final ValueChanged<AuthIntent> onPhoneRequested;
  final VoidCallback onBrowseTap;
  @override
  Widget build(BuildContext context) {
    return PatientShell.detail(
      title: 'الدخول الة الحساب',
      scrollable: true,

      
      
      body: Padding(
          padding:  const EdgeInsets.all(
        AafiatakSpacing.space16, ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Icon(Icons.import_contacts ),
            const AuthIntro(
                eyebrow: "حساب المريض",
                title: "الدخول إلى حسابك",
                description: Text("استخدم رقم هاتفك ورمز تحقق لمرة واحدة يُرسل عبر واتساب")),
          const  SizedBox(
              height: AafiatakSpacing.space16
            ),
            _PasswordlessInfoCard(),
            const  SizedBox(
                height: AafiatakSpacing.space16
            ),
            AafiatakButton.primary(label: "تسجيل الدخول",
                onPressed: (){
              onPhoneRequested(AuthIntent.login);
                }),
            const  SizedBox(
                height: AafiatakSpacing.space20
            ),
            AafiatakButton.tonal(label: "انشاء حساب مريض",
                onPressed: (){
                  onPhoneRequested(AuthIntent.register);
                }),
            const  SizedBox(
                height: AafiatakSpacing.space32
            ),
            AafiatakButton.text(label: "العوده لتصفح",
                onPressed: onBrowseTap)
            
          ],
        ),
      

    ));
  }
}

class _PasswordlessInfoCard extends StatelessWidget {
  const _PasswordlessInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const AafiatakCard(
        child:Row(
          children: [
            Icon(Icons.icecream_outlined),
            SizedBox(width: AafiatakSpacing.space16),
            
            Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("دخول بدون كلمة مرور", style: AafiatakTypography.h3),
                    Text("التحقق يتم برمز لمرة واحدة عبر واتساب الرسمي. لا توجد كلمة مرور أو SMS.",
                    style: AafiatakTypography.bodyLarge)
                  ],
                )
            )
          ],
        )
    );
  }
}

