/// Aafiatak's canonical 4dp spacing scale.
abstract final class AafiatakSpacing {
  const AafiatakSpacing._();

  static const double none = 0;
  static const double xxs = 4;
  static const double xs = 8;
  static const double sm = 12;
  static const double md = 16;
  static const double lg = 20;
  static const double xl = 24;
  static const double x2l = 32;
  static const double x3l = 40;
  static const double x4l = 48;
  static const double x5l = 64;

  static const List<double> scale = <double>[
    none,
    xxs,
    xs,
    sm,
    md,
    lg,
    xl,
    x2l,
    x3l,
    x4l,
    x5l,
  ];

  static const double pageHorizontal = md;
}
