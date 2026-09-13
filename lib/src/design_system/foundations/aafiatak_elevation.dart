import 'package:flutter/material.dart';

/// Restrained elevation from the Burgundy Monochrome v2.1 High-Fidelity tokens.
abstract final class AafiatakElevation {
  const AafiatakElevation._();

  static const double level0 = 0;
  static const double level1 = 1;
  static const double level2 = 3;

  static const List<BoxShadow> none = <BoxShadow>[];

  /// 0 2 10 rgba(26,26,26,.055)
  static const List<BoxShadow> card = <BoxShadow>[
    BoxShadow(
      color: Color(0x0E1A1A1A),
      blurRadius: 10,
      offset: Offset(0, 2),
    ),
  ];

  /// 0 14 34 rgba(26,26,26,.11)
  static const List<BoxShadow> overlay = <BoxShadow>[
    BoxShadow(
      color: Color(0x1C1A1A1A),
      blurRadius: 34,
      offset: Offset(0, 14),
    ),
  ];

  /// 0 12 26 rgba(128,0,32,.20)
  static const List<BoxShadow> brand = <BoxShadow>[
    BoxShadow(
      color: Color(0x33800020),
      blurRadius: 26,
      offset: Offset(0, 12),
    ),
  ];
}
