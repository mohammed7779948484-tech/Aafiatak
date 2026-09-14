import 'package:flutter/material.dart';

/// الحواف الدائرية المشتركة للأسطح وعناصر التحكم.
///
/// تختار المكونات الحجم المناسب، لذلك لا تحتاج الشاشة غالبًا إلى تحديد
/// `BorderRadius` محليًا أو إنشاء شكل مختلف لكل Feature.
abstract final class AafiatakRadii {
  const AafiatakRadii._();

  static const medium = BorderRadius.all(Radius.circular(12));
  static const large = BorderRadius.all(Radius.circular(16));
  static const full = BorderRadius.all(Radius.circular(999));
}
