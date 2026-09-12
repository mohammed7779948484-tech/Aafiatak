import 'package:aafiatak/l10n/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../design_system/design_system.dart';
import 'aafiatak_network_image.dart';

/// Cross-feature image renderer for raster/SVG assets and HTTP(S) resources.
///
/// Keep feature-specific image composition (avatars, doctor cards, facility
/// galleries, etc.) inside the owning feature or future domain-pattern layer.
class AafiatakImage extends StatelessWidget {
  const AafiatakImage({
    required this.source,
    super.key,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.alignment = Alignment.center,
    this.borderRadius,
    this.semanticLabel,
    this.placeholder,
    this.errorWidget,
    this.useSkeleton = true,
  });

  final String source;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Alignment alignment;
  final BorderRadius? borderRadius;
  final String? semanticLabel;
  final Widget? placeholder;
  final Widget? errorWidget;
  final bool useSkeleton;

  String get _normalizedSource => source.trim();

  bool get _isSvg {
    final uri = Uri.tryParse(_normalizedSource);
    final path = uri?.path ?? _normalizedSource;
    return path.toLowerCase().endsWith('.svg');
  }

  bool get _isNetwork {
    final uri = Uri.tryParse(_normalizedSource);
    return uri != null && (uri.scheme == 'http' || uri.scheme == 'https');
  }

  @override
  Widget build(BuildContext context) {
    if (source.trim().isEmpty) {
      return errorWidget ?? _defaultError(context);
    }

    Widget image;

    if (_isNetwork && _isSvg) {
      image = SvgPicture.network(
        _normalizedSource,
        width: width,
        height: height,
        fit: fit,
        alignment: alignment,
        semanticsLabel: semanticLabel,
        excludeFromSemantics: semanticLabel == null,
        placeholderBuilder: (context) =>
            placeholder ?? _defaultPlaceholder(context),
        errorBuilder: (context, error, stackTrace) =>
            errorWidget ?? _defaultError(context),
      );
    } else if (_isNetwork) {
      image = AafiatakNetworkImage(
        imageUrl: _normalizedSource,
        width: width,
        height: height,
        fit: fit,
        alignment: alignment,
        borderRadius: borderRadius,
        semanticLabel: semanticLabel,
        placeholder: placeholder,
        errorWidget: errorWidget,
        useSkeleton: useSkeleton,
      );
    } else if (_isSvg) {
      image = SvgPicture.asset(
        _normalizedSource,
        width: width,
        height: height,
        fit: fit,
        alignment: alignment,
        semanticsLabel: semanticLabel,
        excludeFromSemantics: semanticLabel == null,
        placeholderBuilder: (context) =>
            placeholder ?? _defaultPlaceholder(context),
        errorBuilder: (context, error, stackTrace) =>
            errorWidget ?? _defaultError(context),
      );
    } else {
      image = Image.asset(
        _normalizedSource,
        width: width,
        height: height,
        fit: fit,
        alignment: alignment,
        semanticLabel: semanticLabel,
        excludeFromSemantics: semanticLabel == null,
        errorBuilder: (context, error, stackTrace) =>
            errorWidget ?? _defaultError(context),
      );
    }

    if (borderRadius != null && !(_isNetwork && !_isSvg)) {
      image = ClipRRect(borderRadius: borderRadius!, child: image);
    }

    return image;
  }

  Widget _defaultPlaceholder(BuildContext context) {
    if (!useSkeleton) {
      return SizedBox(
        width: width,
        height: height,
        child: const Center(child: AafiatakLoading(compact: true)),
      );
    }

    return AafiatakSkeleton(
      child: ColoredBox(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        child: SizedBox(width: width, height: height),
      ),
    );
  }

  Widget _defaultError(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return ColoredBox(
      color: scheme.surfaceContainerHigh,
      child: SizedBox(
        width: width,
        height: height,
        child: Center(
          child: AafiatakIcon.huge(
            AafiatakIcons.imageUnavailable,
            semanticLabel: semanticLabel == null
                ? null
                : AppLocalizations.of(context).imageUnavailable(semanticLabel!),
          ),
        ),
      ),
    );
  }
}
