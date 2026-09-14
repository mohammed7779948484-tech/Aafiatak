import 'package:flutter/material.dart';

/// Border radii used by the High-Fidelity interface.
abstract final class AafiatakRadii {
  const AafiatakRadii._();

  static const medium = BorderRadius.all(Radius.circular(12));
  static const large = BorderRadius.all(Radius.circular(16));
  static const full = BorderRadius.all(Radius.circular(999));
}
