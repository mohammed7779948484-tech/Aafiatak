import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../foundations/foundations.dart';

enum AafiatakIconSize { inline, standard, large, hero }

enum _AafiatakIconKind { material, huge }

/// Standardized renderer for Material icons and the approved Hugeicons set.
class AafiatakIcon extends StatelessWidget {
  const AafiatakIcon.material(
    IconData icon, {
    super.key,
    this.size = AafiatakIconSize.standard,
    this.color,
    this.semanticLabel,
  }) : _kind = _AafiatakIconKind.material,
       _materialIcon = icon,
       _hugeIcon = null,
       strokeWidth = null;

  const AafiatakIcon.huge(
    List<List<dynamic>> icon, {
    super.key,
    this.size = AafiatakIconSize.standard,
    this.color,
    this.semanticLabel,
    this.strokeWidth,
  }) : _kind = _AafiatakIconKind.huge,
       _materialIcon = null,
       _hugeIcon = icon;

  final _AafiatakIconKind _kind;
  final IconData? _materialIcon;
  final List<List<dynamic>>? _hugeIcon;
  final AafiatakIconSize size;
  final Color? color;
  final String? semanticLabel;
  final double? strokeWidth;

  double get _resolvedSize => switch (size) {
    AafiatakIconSize.inline => AafiatakSizes.iconInline,
    AafiatakIconSize.standard => AafiatakSizes.iconDefault,
    AafiatakIconSize.large => AafiatakSizes.iconLarge,
    AafiatakIconSize.hero => AafiatakSizes.iconHero,
  };

  @override
  Widget build(BuildContext context) {
    final resolvedColor = color ?? IconTheme.of(context).color;
    final Widget icon = switch (_kind) {
      _AafiatakIconKind.material => Icon(
        _materialIcon,
        size: _resolvedSize,
        color: resolvedColor,
      ),
      _AafiatakIconKind.huge => HugeIcon(
        icon: _hugeIcon!,
        size: _resolvedSize,
        color: resolvedColor,
        strokeWidth: strokeWidth,
      ),
    };

    if (semanticLabel == null) return ExcludeSemantics(child: icon);
    return Semantics(
      image: true,
      label: semanticLabel,
      child: ExcludeSemantics(child: icon),
    );
  }
}
