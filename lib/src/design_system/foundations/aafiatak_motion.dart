import 'package:flutter/animation.dart';

abstract final class AafiatakMotion {
  const AafiatakMotion._();

  static const instant = Duration(milliseconds: 80);
  static const fast = Duration(milliseconds: 140);
  static const standard = Duration(milliseconds: 220);
  static const deliberate = Duration(milliseconds: 320);
  static const shimmer = Duration(milliseconds: 1350);

  /// Exact High-Fidelity standard curve: cubic-bezier(.2,0,0,1).
  static const Curve standardCurve = Cubic(0.2, 0, 0, 1);
  static const Curve emphasizedCurve = Curves.easeInOutCubicEmphasized;

  /// High-Fidelity decelerate curve: cubic-bezier(0,0,.2,1).
  static const Curve enterCurve = Cubic(0, 0, 0.2, 1);

  /// High-Fidelity accelerate curve: cubic-bezier(.3,0,1,.3).
  static const Curve exitCurve = Cubic(0.3, 0, 1, 0.3);
  static const Curve microInteractionCurve = Curves.easeOutBack;
  static const Curve linear = Curves.linear;
}
