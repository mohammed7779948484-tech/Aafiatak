import 'package:flutter/material.dart';

@immutable
class AafiatakNavigationItem {
  const AafiatakNavigationItem({
    required this.label,
    required this.icon,
    this.selectedIcon,
    this.tooltip,
    this.enabled = true,
  });

  final String label;
  final Widget icon;
  final Widget? selectedIcon;
  final String? tooltip;
  final bool enabled;
}

class AafiatakNavigationBar extends StatelessWidget {
  const AafiatakNavigationBar({
    super.key,
    required this.items,
    required this.selectedIndex,
    required this.onDestinationSelected,
  });

  final List<AafiatakNavigationItem> items;
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    assert(
      items.length >= 3 && items.length <= 5,
      'Mobile primary navigation supports 3 to 5 destinations.',
    );
    assert(
      selectedIndex >= 0 && selectedIndex < items.length,
      'selectedIndex must point to an existing destination.',
    );
    assert(
      items[selectedIndex].enabled,
      'The selected destination must be enabled.',
    );

    return NavigationBar(
      selectedIndex: selectedIndex,
      onDestinationSelected: onDestinationSelected,
      destinations: items
          .map(
            (item) => NavigationDestination(
              icon: item.icon,
              selectedIcon: item.selectedIcon,
              label: item.label,
              tooltip: item.tooltip,
              enabled: item.enabled,
            ),
          )
          .toList(growable: false),
    );
  }
}
