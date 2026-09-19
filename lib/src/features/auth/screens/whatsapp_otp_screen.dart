import 'package:flutter/material.dart';

import 'package:aafiatak/src/app/patient_shell.dart';
import 'package:aafiatak/src/design_system/design_system.dart';

import '../auth_intent.dart';
import '../mock_data.dart';
import '../widgets/auth_intro.dart';
import '../widgets/otp_input.dart';
import '../widgets/verified_phone_summary.dart';

class WhatsAppOtpScreen extends StatefulWidget {
  const WhatsAppOtpScreen({
    super.key,
    required this.intent,
    required this.phone,
    required this.onChangePhone,
    required this.onResendRequested,
    required this.onVerifyRequested,
  });

  final AuthIntent intent;
  final String phone;
  final VoidCallback onChangePhone;

  final VoidCallback onResendRequested;

  final ValueChanged<String> onVerifyRequested;

  @override
  State<WhatsAppOtpScreen> createState() =>
      _WhatsAppOtpScreenState();
}

class _WhatsAppOtpScreenState
    extends State<WhatsAppOtpScreen> {
  String _otpCode = AuthMockData.waitingOtpFixture;

  void _handleOtpChanged(String value) {
    setState(() {
      _otpCode = value;
    });
  }

  void _handleVerifyPressed() {
    widget.onVerifyRequested(_otpCode);
  }

  @override
  Widget build(BuildContext context) {
    return PatientShell.detail(
      title: 'التحقق برمز واتساب',

      scrollable: true,

      bottomAction: AafiatakButton.primary(
        label: 'تحقق من الرمز',
        fullWidth: true,
        onPressed: _handleVerifyPressed,
      ),

      body: Padding(
        padding:  EdgeInsets.all(
          AafiatakSpacing.space16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            AuthIntro(
              eyebrow: 'التحقق عبر واتساب',
              title: 'أدخل رمز التحقق',
              description: Text.rich(
                TextSpan(
                  children: <InlineSpan>[
                     TextSpan(
                      text:
                      'أرسلنا رمزًا لمرة واحدة إلى الرقم ',
                    ),
                    WidgetSpan(
                      alignment:
                      PlaceholderAlignment.middle,
                      child: Directionality(
                        textDirection:
                        TextDirection.ltr,
                        child: Text(
                          widget.phone,
                          style:
                          AafiatakTypography
                              .bodySmall,
                        ),
                      ),
                    ),
                     TextSpan(
                      text:
                      '. اكتب الرمز كما وصلك في واتساب. '
                          'عدد الخانات ومدة الصلاحية يتبعان إعدادات الخدمة.',
                    ),
                  ],
                ),
              ),
            ),

             SizedBox(
              height: AafiatakSpacing.space24,
            ),

            AafiatakCard(
              child: OtpInput(
                length: AuthMockData.otpLength,
                initialValue:
                AuthMockData.waitingOtpFixture,
                onChanged: _handleOtpChanged,
              ),
            ),

             SizedBox(
              height: AafiatakSpacing.space16,
            ),

            AafiatakCard(
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.stretch,
                children: <Widget>[
                   AafiatakInfoRows(
                    rows: <InfoRowItem>[
                      InfoRowItem(
                        label: 'إعادة الإرسال',
                        value:
                        'تتاح عند السماح بإعادة الإرسال',
                      ),
                    ],
                  ),

                   SizedBox(
                    height: AafiatakSpacing.space16,
                  ),

                   Divider(),

                   SizedBox(
                    height: AafiatakSpacing.space16,
                  ),

                   VerifiedPhoneSummary(
                    phone:
                    // AuthMockData.maskedPhone
                     widget.phone,
                  ),

                   SizedBox(
                    height: AafiatakSpacing.space20,
                  ),

                  AafiatakButton.secondary(
                    label: 'تغيير الرقم',
                    fullWidth: true,
                    onPressed:
                    widget.onChangePhone,
                  ),

                   SizedBox(
                    height: AafiatakSpacing.space12,
                  ),

                  AafiatakButton.tonal(
                    label: 'إعادة الإرسال',
                    fullWidth: true,
                    onPressed:
                    widget
                        .onResendRequested,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}