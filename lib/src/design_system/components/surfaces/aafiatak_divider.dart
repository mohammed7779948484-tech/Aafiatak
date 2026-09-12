import 'package:flutter/material.dart';

import '../../foundations/foundations.dart';

class AafiatakDivider extends StatelessWidget {
  const AafiatakDivider({super.key, this.space = AafiatakSpacing.md});
  final double space;

  @override
  Widget build(BuildContext context) => Divider(height: space);
}
