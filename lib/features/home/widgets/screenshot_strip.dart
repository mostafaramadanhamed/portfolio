import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/responsive.dart';
import 'screenshot_gallery.dart';

/// Horizontally scrollable phone screenshots; tapping one opens the gallery.
class ScreenshotStrip extends StatelessWidget {
  const ScreenshotStrip({
    super.key,
    required this.screenshots,
    required this.projectName,
  });

  final List<String> screenshots;
  final String projectName;

  /// Phone screenshots are roughly 9:19.
  static const _aspectRatio = 9 / 19;

  @override
  Widget build(BuildContext context) {
    final height = context.isMobile ? 240.0 : 280.0;
    final width = height * _aspectRatio;
    final pixelRatio = MediaQuery.devicePixelRatioOf(context);

    return SizedBox(
      height: height,
      // Let mouse and trackpad users drag the strip, not only touch.
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
          dragDevices: PointerDeviceKind.values.toSet(),
          scrollbars: false,
        ),
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: screenshots.length,
          separatorBuilder: (_, _) => const SizedBox(width: 12),
          itemBuilder: (context, index) => _Thumbnail(
            asset: screenshots[index],
            width: width,
            cacheWidth: (width * pixelRatio).round(),
            semanticLabel: '$projectName screenshot ${index + 1}',
            onTap: () => showScreenshotGallery(
              context,
              screenshots: screenshots,
              initialIndex: index,
              projectName: projectName,
            ),
          ),
        ),
      ),
    );
  }
}

class _Thumbnail extends StatefulWidget {
  const _Thumbnail({
    required this.asset,
    required this.width,
    required this.cacheWidth,
    required this.semanticLabel,
    required this.onTap,
  });

  final String asset;
  final double width;
  final int cacheWidth;
  final String semanticLabel;
  final VoidCallback onTap;

  @override
  State<_Thumbnail> createState() => _ThumbnailState();
}

class _ThumbnailState extends State<_Thumbnail> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.zoomIn,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: widget.width,
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: _hovered ? AppColors.accent : AppColors.border,
              width: 1.5,
            ),
          ),
          clipBehavior: Clip.antiAlias,
          child: Image.asset(
            widget.asset,
            fit: BoxFit.cover,
            cacheWidth: widget.cacheWidth,
            semanticLabel: widget.semanticLabel,
            frameBuilder: (context, child, frame, wasSynchronouslyLoaded) =>
                AnimatedOpacity(
              opacity: frame == null ? 0 : 1,
              duration: const Duration(milliseconds: 300),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
