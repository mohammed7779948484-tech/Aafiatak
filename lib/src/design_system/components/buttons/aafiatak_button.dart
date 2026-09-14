import 'package:flutter/material.dart';

enum _ButtonType { primary, tonal, secondary, destructive, text }

/// زر موحّد لتطبيق عافيتك يعتمد على أزرار Material 3 الأصلية.
///
/// استخدم أحد المنشئات المسماة مثل [AafiatakButton.primary] داخل الشاشات،
/// حتى تبقى الأنواع واضحة ومتسقة بين أعضاء الفريق. الشكل العام يأتي من
/// `ThemeData`، وحالة التعطيل لا تحتاج خاصية إضافية؛ مرر `onPressed: null`.
class AafiatakButton extends StatelessWidget {
  const AafiatakButton.primary({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.fullWidth = false,
  }) : _type = _ButtonType.primary;

  const AafiatakButton.tonal({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.fullWidth = false,
  }) : _type = _ButtonType.tonal;

  const AafiatakButton.secondary({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.fullWidth = false,
  }) : _type = _ButtonType.secondary;

  const AafiatakButton.destructive({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.fullWidth = false,
  }) : _type = _ButtonType.destructive;

  const AafiatakButton.text({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.fullWidth = false,
  }) : _type = _ButtonType.text;

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool fullWidth;
  final _ButtonType _type;

  @override
  Widget build(BuildContext context) {
    final child = switch (_type) {
      _ButtonType.primary => _filled(),
      _ButtonType.tonal => _tonal(context),
      _ButtonType.secondary => _outlined(),
      _ButtonType.destructive => _destructive(context),
      _ButtonType.text => _text(),
    };

    return fullWidth ? SizedBox(width: double.infinity, child: child) : child;
  }

  Widget _filled() => icon == null
      ? FilledButton(onPressed: onPressed, child: Text(label))
      : FilledButton.icon(
          onPressed: onPressed,
          icon: Icon(icon),
          label: Text(label),
        );

  Widget _tonal(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final style = FilledButton.styleFrom(
      backgroundColor: colors.primaryContainer,
      foregroundColor: colors.onPrimaryContainer,
    );
    return icon == null
        ? FilledButton.tonal(
            style: style,
            onPressed: onPressed,
            child: Text(label),
          )
        : FilledButton.tonalIcon(
            style: style,
            onPressed: onPressed,
            icon: Icon(icon),
            label: Text(label),
          );
  }

  Widget _outlined() => icon == null
      ? OutlinedButton(onPressed: onPressed, child: Text(label))
      : OutlinedButton.icon(
          onPressed: onPressed,
          icon: Icon(icon),
          label: Text(label),
        );

  Widget _destructive(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final style = FilledButton.styleFrom(
      backgroundColor: colors.errorContainer,
      foregroundColor: colors.onErrorContainer,
    );
    return icon == null
        ? FilledButton(style: style, onPressed: onPressed, child: Text(label))
        : FilledButton.icon(
            style: style,
            onPressed: onPressed,
            icon: Icon(icon),
            label: Text(label),
          );
  }

  Widget _text() => icon == null
      ? TextButton(onPressed: onPressed, child: Text(label))
      : TextButton.icon(
          onPressed: onPressed,
          icon: Icon(icon),
          label: Text(label),
        );
}
