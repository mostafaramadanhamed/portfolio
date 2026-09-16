import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/responsive.dart';
import '../../../data/portfolio_data.dart';
import '../../../shared/widgets/hover_card.dart';
import '../../../shared/widgets/reveal_on_scroll.dart';
import '../../../shared/widgets/section_container.dart';
import '../../../shared/widgets/section_title.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = context.isDesktop;

    final bio = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final paragraph in PortfolioData.about)
          Padding(
            padding: const EdgeInsets.only(bottom: 18),
            child: Text(
              paragraph,
              style: TextStyle(
                fontSize: context.isMobile ? 16 : 17,
                height: 1.75,
                color: AppColors.textSecondary,
              ),
            ),
          ),
      ],
    );

    final focus = LayoutBuilder(
      builder: (context, constraints) {
        const spacing = 16.0;
        final columns = constraints.maxWidth >= 480 ? 2 : 1;
        final width =
            (constraints.maxWidth - spacing * (columns - 1)) / columns;
        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: [
            for (final (title, body) in PortfolioData.focusAreas)
              SizedBox(
                width: width,
                child: HoverCard(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '// $title',
                        style: AppTheme.mono(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        body,
                        style: const TextStyle(
                          fontSize: 14,
                          height: 1.5,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        );
      },
    );

    return SectionContainer(
      child: RevealOnScroll(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionTitle(index: 1, title: 'About me'),
            if (isDesktop)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: bio),
                  const SizedBox(width: 48),
                  Expanded(child: focus),
                ],
              )
            else ...[
              bio,
              const SizedBox(height: 16),
              focus,
            ],
          ],
        ),
      ),
    );
  }
}
