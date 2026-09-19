import 'package:flutter/material.dart';

import 'package:aafiatak/src/design_system/design_system.dart';

class VerifiedPhoneSummary extends StatelessWidget {
  const VerifiedPhoneSummary({
    super.key,
    required this.phone
  });

  final String phone;

  @override
  Widget build(BuildContext context) {
    return AafiatakInfoRows(
        rows: [
          InfoRowItem(
              label: 'الرقم الحالي',
              value:  phone,
              isLtr: true
          )
        ]
    );
  }
}
