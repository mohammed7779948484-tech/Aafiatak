import 'package:flutter/material.dart';

import 'package:aafiatak/src/app/patient_shell.dart';
import 'package:aafiatak/src/design_system/design_system.dart';

import '../auth_intent.dart';
import '../mock_data.dart';
import '../widgets/auth_intro.dart';
import '../widgets/otp_input.dart';
import '../widgets/verified_phone_summary.dart';


enum _ProfileCompletionView{
  editing,
  success,
}

class ProfileCompletion extends StatefulWidget {
  const ProfileCompletion({
    super.key,
    required this.onFinished,
    required this.phone,
  });

  final VoidCallback onFinished;
  final String phone;

  @override
  State<ProfileCompletion> createState() => _ProfileCompletionState();
}

class _ProfileCompletionState extends State<ProfileCompletion> {
  final TextEditingController _nameController = TextEditingController();

  _ProfileCompletionView _view = _ProfileCompletionView.editing;


  @override
  void dispose(){
    _nameController.dispose();
    super.dispose();
  }

  void _completeRegistration(){
    setState(() {
      _view=_ProfileCompletionView.success;
    });
  }
  @override
  Widget build(BuildContext context) {
    return PatientShell.detail(
      title: "استكمال بيانات المريض",
      scrollable: true,
      bottomAction: _view == _ProfileCompletionView.success
          ? AafiatakButton.primary(
          label: "متابعه ",
          onPressed: widget.onFinished)
          : AafiatakButton.primary(
        label: "اكمل تسجيل الدخول",
        onPressed: _completeRegistration,),
      body: Padding(
        padding:  const EdgeInsets.all(
          AafiatakSpacing.space16,
        ),

        child: _view == _ProfileCompletionView.success
            ? _successUI()
            : _editingUI(
            nameController: _nameController,
            phone: widget.phone),


      ),

    );
  }
}



// شاشه التعديل منفصله داخل كلاس
class _editingUI extends StatelessWidget {
  const _editingUI({
    super.key,
    required this.nameController,
    required this.phone,
  });
  // تم تعريفهم هنا ايضا لانه هذا الكلاس مايصل لمتغيرات الكلاس السابق نعرفهم هنا وبعدين نستدعهيهم

  final TextEditingController nameController;
  final String phone;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AuthIntro(
            eyebrow: "خطوة أخيرة",
            title: "استكمل بيانات المريض الأساسية",
            description: Text("رقم الهاتف موثق بالفعل. نحتاج إلى بيانات أساسية قليلة لإكمال حساب المريض.")
        ),
        const  SizedBox(
            height: AafiatakSpacing.space16
        ),
        AafiatakCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text("رقم الهاتف الموثق", style: AafiatakTypography.h3,),
                Text("+967 "+phone,
                  style : AafiatakTypography.label,
                  textDirection: TextDirection.ltr,),

              ],
            )
        ),
        const  SizedBox(
            height: AafiatakSpacing.space16
        ),
        AafiatakTextField(
          controller: nameController,
          label: "الاسم الكامل",
          hintText: "اكتب اسمك هنا ",
          helperText: "يمكنك تحديث بياناتك الأساسية لاحقًا من حسابك",
        )

      ],
    );
  }
}




class _successUI extends StatelessWidget {
  const _successUI({super.key});

  @override
  Widget build(BuildContext context) {
    return const AafiatakStatusBlock(
      title: 'تم إنشاء ملف المريض',
      message: 'اكتملت البيانات الأساسية بنجاح.',
      tone: AafiatakFeedbackTone.success,
      icon: Icons.check_circle_outline,
      tag: 'مكتمل',
    );
  }
}

