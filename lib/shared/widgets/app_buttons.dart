import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/utils/responsive.dart';

enum AppButtonVariant { primary, secondary }

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.variant = AppButtonVariant.secondary,
  });

  final String label;
  final VoidCallback onPressed;
  final Widget? icon;
  final AppButtonVariant variant;

  @override
  Widget build(BuildContext context) {
    final padding = EdgeInsets.symmetric(
      horizontal: 28,
      vertical: context.isMobile ? 18 : 22,
    );
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    );
    final text = Text(
      label,
      style: TextStyle(
        fontWeight: variant == AppButtonVariant.primary
            ? FontWeight.w600
            : FontWeight.w500,
      ),
    );

    return switch (variant) {
      AppButtonVariant.primary => FilledButton.icon(
          onPressed: onPressed,
          icon: icon,
          label: text,
          style: FilledButton.styleFrom(
            backgroundColor: AppColors.accent,
            foregroundColor: AppColors.background,
            padding: padding,
            shape: shape,
          ),
        ),
      AppButtonVariant.secondary => OutlinedButton.icon(
          onPressed: onPressed,
          icon: icon,
          label: text,
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.textPrimary,
            side: const BorderSide(color: AppColors.border),
            padding: padding,
            shape: shape,
          ),
        ),
    };
  }
}

/// Lays buttons out in a row on wide screens and stacks them full-width on
/// phones, where side-by-side buttons would wrap unevenly.
class AppButtonGroup extends StatelessWidget {
  const AppButtonGroup({
    super.key,
    required this.children,
    this.alignment = WrapAlignment.start,
  });

  final List<Widget> children;
  final WrapAlignment alignment;

  @override
  Widget build(BuildContext context) {
    if (context.isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (final (i, child) in children.indexed) ...[
            if (i > 0) const SizedBox(height: 12),
            child,
          ],
        ],
      );
    }
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      alignment: alignment,
      children: children,
    );
  }
}
