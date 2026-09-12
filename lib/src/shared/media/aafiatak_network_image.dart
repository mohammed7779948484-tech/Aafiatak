import 'package:cached_network_image/cached_network_image.dart';
import 'package:aafiatak/l10n/generated/app_localizations.dart';
import 'package:flutter/material.dart';

import '../../design_system/design_system.dart';

/// Cached raster network image with Aafiatak loading and error presentation.
class AafiatakNetworkImage extends StatelessWidget {
  const AafiatakNetworkImage({
    required this.imageUrl,
    super.key,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.alignment = Alignment.center,
    this.borderRadius,
    this.semanticLabel,
    this.cacheKey,
    this.placeholder,
    this.errorWidget,
    this.useSkeleton = true,
  });

  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Alignment alignment;
  final BorderRadius? borderRadius;
  final String? semanticLabel;
  final String? cacheKey;
  final Widget? placeholder;
  final Widget? errorWidget;
  final bool useSkeleton;

  @override
  Widget build(BuildContext context) {
    if (imageUrl.trim().isEmpty) {
      return errorWidget ?? _defaultError(context);
    }

    final disableAnimations = MediaQuery.disableAnimationsOf(context);

    Widget image = CachedNetworkImage(
      imageUrl: imageUrl.trim(),
      cacheKey: cacheKey,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      imageBuilder: (context, imageProvider) => Image(
        image: imageProvider,
        width: width,
        height: height,
        fit: fit,
        alignment: alignment,
        semanticLabel: semanticLabel,
        excludeFromSemantics: semanticLabel == null,
      ),
      fadeInDuration: disableAnimations
          ? Duration.zero
          : AafiatakMotion.standard,
      placeholder: (context, url) =>
          placeholder ?? _defaultPlaceholder(context),
      errorWidget: (context, url, error) =>
          errorWidget ?? _defaultError(context),
    );

    if (borderRadius != null) {
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
      color: scheme.errorContainer,
      child: SizedBox(
        width: width,
        height: height,
        child: Center(
          child: AafiatakIcon.huge(
            AafiatakIcons.imageUnavailable,
            color: scheme.error,
            semanticLabel: semanticLabel == null
                ? null
                : AppLocalizations.of(context).imageLoadFailed(semanticLabel!),
          ),
        ),
      ),
    );
  }
}
