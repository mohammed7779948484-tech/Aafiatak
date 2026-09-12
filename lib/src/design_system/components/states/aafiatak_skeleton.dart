import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

/// Static skeleton wrapper. The child should match final content geometry.
class AafiatakSkeleton extends StatelessWidget {
  const AafiatakSkeleton({
    super.key,
    required this.child,
    this.enabled = true,
    this.ignorePointers = true,
  });

  final Widget child;
  final bool enabled;
  final bool ignorePointers;

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: enabled,
      ignorePointers: ignorePointers,
      effect: SolidColorEffect(
        color: Theme.of(context).colorScheme.surfaceContainerHigh,
      ),
      child: child,
    );
  }
}
