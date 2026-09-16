import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/responsive.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({super.key, required this.index, required this.title});

  final int index;
  final String title;

  @override
  Widget build(BuildContext context) {
    final fontSize = context.isCompact
        ? 22.0
        : context.responsive(mobile: 24.0, tablet: 28.0, desktop: 30.0);
    return Padding(
      padding: EdgeInsets.only(bottom: context.isMobile ? 28 : 40),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [
          Text(
            '${index.toString().padLeft(2, '0')}.',
            style: AppTheme.mono(fontSize: fontSize * 0.7),
          ),
          const SizedBox(width: 10),
          Flexible(
            child: Text(
              title,
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          // The decorative rule only shows when there is room for it.
          if (!context.isCompact) ...[
            const SizedBox(width: 20),
            Expanded(
              child: Align(
                alignment: AlignmentDirectional.centerStart,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 280),
                  child: Container(height: 1, color: AppColors.border),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
