import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Renders an asset image that can be either SVG or raster (PNG/JPG/JPEG).
class AssetImageOrSvg extends StatelessWidget {
  const AssetImageOrSvg(
    this.asset, {
    super.key,
    this.fit,
    this.width,
    this.height,
    this.alignment = Alignment.center,
  });

  final String asset;
  final BoxFit? fit;
  final double? width;
  final double? height;
  final Alignment alignment;

  bool get _isSvg => asset.toLowerCase().endsWith('.svg');

  @override
  Widget build(BuildContext context) {
    if (_isSvg) {
      return SvgPicture.asset(
        asset,
        fit: fit ?? BoxFit.contain,
        width: width,
        height: height,
        alignment: alignment,
      );
    }
    return Image.asset(
      asset,
      fit: fit,
      width: width,
      height: height,
      alignment: alignment,
      errorBuilder: (context, error, stackTrace) => Container(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        alignment: Alignment.center,
        child: const Icon(Icons.broken_image_outlined),
      ),
    );
  }
}
