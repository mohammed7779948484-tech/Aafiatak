import 'package:flutter/material.dart';

@immutable
class AafiatakSegment<T> {
  const AafiatakSegment({
    required this.value,
    required this.label,
    this.icon,
    this.enabled = true,
  });

  final T value;
  final String label;
  final Widget? icon;
  final bool enabled;
}

class AafiatakSegmentedControl<T> extends StatelessWidget {
  const AafiatakSegmentedControl({
    super.key,
    required this.segments,
    required this.selected,
    required this.onChanged,
    this.showSelectedIcon = true,
  }) : assert(
         segments.length >= 2 && segments.length <= 4,
         'A segmented control supports 2 to 4 choices.',
       );

  final List<AafiatakSegment<T>> segments;
  final T selected;
  final ValueChanged<T> onChanged;
  final bool showSelectedIcon;

  @override
  Widget build(BuildContext context) {
    assert(
      segments.map((segment) => segment.value).toSet().length ==
          segments.length,
      'Segment values must be unique.',
    );
    assert(
      segments.any((segment) => segment.value == selected),
      'selected must match one of the provided segments.',
    );

    return SegmentedButton<T>(
      segments: segments
          .map(
            (segment) => ButtonSegment<T>(
              value: segment.value,
              label: Text(segment.label),
              icon: segment.icon,
              enabled: segment.enabled,
            ),
          )
          .toList(growable: false),
      selected: <T>{selected},
      onSelectionChanged: (selection) {
        if (selection.isNotEmpty) onChanged(selection.first);
      },
      showSelectedIcon: showSelectedIcon,
      multiSelectionEnabled: false,
      emptySelectionAllowed: false,
    );
  }
}
