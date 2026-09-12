import 'package:flutter/material.dart';

import '../../foundations/foundations.dart';

/// Standard Aafiatak app bar.
///
/// The wrapper owns the leading slot explicitly so `showBackButton` has a
/// deterministic meaning. [BackButton] keeps platform and RTL behavior correct.
class AafiatakAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AafiatakAppBar({
    super.key,
    required this.title,
    this.actions = const <Widget>[],
    this.leading,
    this.showBackButton = false,
    this.onBack,
    this.bottom,
  }) : assert(
         leading == null || !showBackButton,
         'Provide either leading or showBackButton, not both.',
       );

  final String title;
  final List<Widget> actions;
  final Widget? leading;
  final bool showBackButton;
  final VoidCallback? onBack;
  final PreferredSizeWidget? bottom;

  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight + (bottom?.preferredSize.height ?? 0));

  @override
  Widget build(BuildContext context) {
    final resolvedLeading =
        leading ??
        (showBackButton
            ? BackButton(
                onPressed: onBack,
                style: const ButtonStyle(
                  minimumSize: WidgetStatePropertyAll<Size>(
                    Size.square(AafiatakSizes.minimumTouchTarget),
                  ),
                ),
              )
            : null);

    return AppBar(
      automaticallyImplyLeading: false,
      title: Text(title),
      leading: resolvedLeading,
      leadingWidth: resolvedLeading == null
          ? null
          : AafiatakSizes.minimumTouchTarget + AafiatakSpacing.xs,
      actions: actions,
      bottom: bottom,
    );
  }
}
