import 'package:flutter/material.dart';

/// Restrained elevation. Aafiatak is surface-led, not shadow-led.
abstract final class AafiatakElevation {
  const AafiatakElevation._();

  static const double level0 = 0;
  static const double level1 = 1;
  static const double level2 = 3;

  static const List<BoxShadow> none = <BoxShadow>[];
  static const List<BoxShadow> card = <BoxShadow>[
    BoxShadow(color: Color(0x0F171519), blurRadius: 8, offset: Offset(0, 2)),
  ];
  static const List<BoxShadow> overlay = <BoxShadow>[
    BoxShadow(color: Color(0x17171519), blurRadius: 24, offset: Offset(0, 8)),
  ];
}
