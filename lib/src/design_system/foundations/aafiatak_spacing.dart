/// Aafiatak spacing tokens aligned to the approved High-Fidelity scale.
abstract final class AafiatakSpacing {
  const AafiatakSpacing._();

  static const double none = 0;
  static const double micro = 2;
  static const double xxs = 4;
  static const double xs = 8;
  static const double sm = 12;
  static const double md = 16;
  static const double lg = 20;
  static const double xl = 24;
  static const double x2l = 32;

  /// Compatibility token retained for existing authored code. New design work
  /// should prefer the canonical scale below unless 40dp is explicitly called
  /// for by a reviewed composition.
  static const double x3l = 40;

  static const double x4l = 48;
  static const double x5l = 64;

  /// Canonical High-Fidelity scale. 40dp is intentionally not part of it.
  static const List<double> scale = <double>[
    none,
    micro,
    xxs,
    xs,
    sm,
    md,
    lg,
    xl,
    x2l,
    x4l,
    x5l,
  ];

  static const double pageHorizontal = md;
  static const double itemGap = xs;
  static const double cardPadding = md;
  static const double formFieldGap = sm;
}
