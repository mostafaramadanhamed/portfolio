import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/utils/responsive.dart';

/// A surface card that lifts and highlights its border on hover.
class HoverCard extends StatefulWidget {
  const HoverCard({
    super.key,
    required this.child,
    this.padding,
  });

  final Widget child;
  /// Defaults to 24 on larger screens and 20 on phones.
  final EdgeInsetsGeometry? padding;

  @override
  State<HoverCard> createState() => _HoverCardState();
}

class _HoverCardState extends State<HoverCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        transform: Matrix4.translationValues(0, _hovered ? -4 : 0, 0),
        padding: widget.padding ??
            EdgeInsets.all(context.isMobile ? 20 : 24),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: _hovered
                ? AppColors.accent.withValues(alpha: 0.5)
                : AppColors.border,
          ),
          boxShadow: [
            if (_hovered)
              BoxShadow(
                color: AppColors.accent.withValues(alpha: 0.08),
                blurRadius: 30,
                offset: const Offset(0, 12),
              ),
          ],
        ),
        child: widget.child,
      ),
    );
  }
}
