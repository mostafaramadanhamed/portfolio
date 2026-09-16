import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../data/portfolio_data.dart';
import '../../../shared/widgets/hover_card.dart';
import '../../../shared/widgets/reveal_on_scroll.dart';
import '../../../shared/widgets/section_container.dart';
import '../../../shared/widgets/section_title.dart';
import '../../../shared/widgets/tech_chip.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const RevealOnScroll(
            child: SectionTitle(index: 4, title: 'Skills & Education'),
          ),
          LayoutBuilder(
            builder: (context, constraints) {
              const spacing = 20.0;
              final columns = constraints.maxWidth >= 960
                  ? 3
                  : constraints.maxWidth >= 620
                      ? 2
                      : 1;
              final width =
                  (constraints.maxWidth - spacing * (columns - 1)) / columns;

              return Wrap(
                spacing: spacing,
                runSpacing: spacing,
                children: [
                  for (final (i, group) in PortfolioData.skills.indexed)
                    SizedBox(
                      width: width,
                      child: RevealOnScroll(
                        delay: Duration(milliseconds: 80 * (i % columns)),
                        child: HoverCard(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                group.title,
                                style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: [
                                  for (final skill in group.skills)
                                    TechChip(skill),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
          const SizedBox(height: 40),
          const RevealOnScroll(child: _EducationCard()),
        ],
      ),
    );
  }
}

class _EducationCard extends StatelessWidget {
  const _EducationCard();

  @override
  Widget build(BuildContext context) {
    return HoverCard(
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.accent.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.school_outlined,
              color: AppColors.accent,
              size: 28,
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  PortfolioData.degree,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 4),
                const Text(
                  PortfolioData.school,
                  style: TextStyle(
                    fontSize: 15,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  PortfolioData.educationPeriod,
                  style: AppTheme.mono(
                    fontSize: 13,
                    color: AppColors.textMuted,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
