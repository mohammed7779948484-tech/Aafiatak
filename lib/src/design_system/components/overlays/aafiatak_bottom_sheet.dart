import 'package:flutter/material.dart';

import '../../foundations/foundations.dart';

class AafiatakBottomSheetBody extends StatelessWidget {
  const AafiatakBottomSheetBody({
    super.key,
    required this.child,
    this.padding = const EdgeInsetsDirectional.fromSTEB(
      AafiatakSpacing.md,
      AafiatakSpacing.xs,
      AafiatakSpacing.md,
      AafiatakSpacing.xl,
    ),
  });

  final Widget child;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding.add(
        EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      ),
      child: child,
    );
  }
}

Future<T?> showAafiatakBottomSheet<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  bool isScrollControlled = true,
  bool useSafeArea = true,
  bool isDismissible = true,
  bool enableDrag = true,
}) {
  return showModalBottomSheet<T>(
    context: context,
    builder: builder,
    isScrollControlled: isScrollControlled,
    useSafeArea: useSafeArea,
    isDismissible: isDismissible,
    enableDrag: enableDrag,
  );
}
