import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/responsive.dart';

Future<void> showScreenshotGallery(
  BuildContext context, {
  required List<String> screenshots,
  required int initialIndex,
  required String projectName,
}) {
  return showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: 'Close gallery',
    barrierColor: Colors.black.withValues(alpha: 0.9),
    transitionDuration: const Duration(milliseconds: 250),
    pageBuilder: (_, _, _) => _ScreenshotGallery(
      screenshots: screenshots,
      initialIndex: initialIndex,
      projectName: projectName,
    ),
    transitionBuilder: (_, animation, _, child) => FadeTransition(
      opacity: animation,
      child: ScaleTransition(
        scale: Tween(begin: 0.96, end: 1.0).animate(
          CurvedAnimation(parent: animation, curve: Curves.easeOut),
        ),
        child: child,
      ),
    ),
  );
}

class _ScreenshotGallery extends StatefulWidget {
  const _ScreenshotGallery({
    required this.screenshots,
    required this.initialIndex,
    required this.projectName,
  });

  final List<String> screenshots;
  final int initialIndex;
  final String projectName;

  @override
  State<_ScreenshotGallery> createState() => _ScreenshotGalleryState();
}

class _ScreenshotGalleryState extends State<_ScreenshotGallery> {
  late final PageController _controller =
      PageController(initialPage: widget.initialIndex);
  late int _index = widget.initialIndex;

  bool get _hasPrevious => _index > 0;
  bool get _hasNext => _index < widget.screenshots.length - 1;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _goTo(int index) {
    _controller.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobile;

    return CallbackShortcuts(
      bindings: {
        const SingleActivator(LogicalKeyboardKey.arrowLeft): () {
          if (_hasPrevious) _goTo(_index - 1);
        },
        const SingleActivator(LogicalKeyboardKey.arrowRight): () {
          if (_hasNext) _goTo(_index + 1);
        },
      },
      child: Focus(
        autofocus: true,
        child: SafeArea(
          child: Stack(
            children: [
              PageView.builder(
                controller: _controller,
                itemCount: widget.screenshots.length,
                onPageChanged: (index) => setState(() => _index = index),
                itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.fromLTRB(
                    isMobile ? 16 : 96,
                    64,
                    isMobile ? 16 : 96,
                    isMobile ? 32 : 48,
                  ),
                  child: Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        widget.screenshots[index],
                        fit: BoxFit.contain,
                        semanticLabel:
                            '${widget.projectName} screenshot ${index + 1}',
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 12,
                left: 20,
                right: 12,
                child: Row(
                  children: [
                    Flexible(
                      child: Text(
                        widget.projectName,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      '${_index + 1} / ${widget.screenshots.length}',
                      style: AppTheme.mono(
                        fontSize: 13,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      tooltip: 'Close',
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(
                        Icons.close_rounded,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
              // Swiping covers touch screens; arrows are for mouse users.
              if (!isMobile) ...[
                if (_hasPrevious)
                  _ArrowButton(
                    alignment: Alignment.centerLeft,
                    icon: Icons.chevron_left_rounded,
                    tooltip: 'Previous',
                    onPressed: () => _goTo(_index - 1),
                  ),
                if (_hasNext)
                  _ArrowButton(
                    alignment: Alignment.centerRight,
                    icon: Icons.chevron_right_rounded,
                    tooltip: 'Next',
                    onPressed: () => _goTo(_index + 1),
                  ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _ArrowButton extends StatelessWidget {
  const _ArrowButton({
    required this.alignment,
    required this.icon,
    required this.tooltip,
    required this.onPressed,
  });

  final Alignment alignment;
  final IconData icon;
  final String tooltip;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: IconButton.filled(
          tooltip: tooltip,
          onPressed: onPressed,
          style: IconButton.styleFrom(
            backgroundColor: AppColors.surfaceHigh,
            foregroundColor: AppColors.textPrimary,
            fixedSize: const Size.square(52),
          ),
          icon: Icon(icon, size: 30),
        ),
      ),
    );
  }
}
