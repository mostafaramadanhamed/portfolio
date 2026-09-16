import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/responsive.dart';
import '../../../data/portfolio_data.dart';
import '../../../shared/widgets/reveal_on_scroll.dart';
import '../../../shared/widgets/section_container.dart';
import '../../../shared/widgets/section_title.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final items = PortfolioData.experience;
    return SectionContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const RevealOnScroll(
            child: SectionTitle(index: 2, title: 'Experience'),
          ),
          for (final (i, item) in items.indexed)
            RevealOnScroll(
              child: _TimelineEntry(
                experience: item,
                isCurrent: i == 0,
                isLast: i == items.length - 1,
              ),
            ),
        ],
      ),
    );
  }
}

class _TimelineEntry extends StatelessWidget {
  const _TimelineEntry({
    required this.experience,
    required this.isCurrent,
    required this.isLast,
  });

  final Experience experience;
  final bool isCurrent;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: 24,
            child: Column(
              children: [
                const SizedBox(height: 6),
                Container(
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isCurrent ? AppColors.accent : AppColors.background,
                    border: Border.all(color: AppColors.accent, width: 2),
                    boxShadow: [
                      if (isCurrent)
                        BoxShadow(
                          color: AppColors.accent.withValues(alpha: 0.5),
                          blurRadius: 12,
                        ),
                    ],
                  ),
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      color: AppColors.border,
                    ),
                  ),
              ],
            ),
          ),
          SizedBox(width: context.isMobile ? 12 : 20),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                bottom: isLast ? 0 : (context.isMobile ? 36 : 48),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(text: experience.role),
                        TextSpan(
                          text: ' @ ${experience.company}',
                          style: const TextStyle(color: AppColors.accent),
                        ),
                      ],
                    ),
                    style: TextStyle(
                      fontSize: context.isMobile ? 18 : 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '${experience.period}  ·  ${experience.location}',
                    style: AppTheme.mono(
                      fontSize: 13,
                      color: AppColors.textMuted,
                    ),
                  ),
                  if (experience.project != null) ...[
                    const SizedBox(height: 10),
                    Text(
                      'Project: ${experience.project}',
                      style: const TextStyle(
                        fontSize: 15,
                        fontStyle: FontStyle.italic,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                  const SizedBox(height: 16),
                  for (final highlight in experience.highlights)
                    _Bullet(highlight),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Bullet extends StatelessWidget {
  const _Bullet(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Text('▹', style: AppTheme.mono(fontSize: 14)),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 15,
                height: 1.6,
                color: AppColors.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
