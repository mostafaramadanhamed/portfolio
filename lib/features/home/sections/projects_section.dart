import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../data/portfolio_data.dart';
import '../../../shared/widgets/reveal_on_scroll.dart';
import '../../../shared/widgets/section_container.dart';
import '../../../shared/widgets/section_title.dart';
import '../widgets/project_card.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const RevealOnScroll(
            child: SectionTitle(index: 3, title: 'Projects'),
          ),
          const _GroupLabel('Professional work · Dinotik'),
          _ProjectGrid(projects: PortfolioData.workProjects, maxColumns: 3),
          const SizedBox(height: 56),
          const _GroupLabel('Personal projects'),
          _ProjectGrid(projects: PortfolioData.personalProjects, maxColumns: 3),
        ],
      ),
    );
  }
}

class _GroupLabel extends StatelessWidget {
  const _GroupLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Text(
        text.toUpperCase(),
        style: AppTheme.mono(
          fontSize: 13,
          color: AppColors.textMuted,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _ProjectGrid extends StatelessWidget {
  const _ProjectGrid({required this.projects, required this.maxColumns});

  final List<Project> projects;
  final int maxColumns;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const spacing = 20.0;
        final fit = constraints.maxWidth >= 960
            ? 3
            : constraints.maxWidth >= 620
                ? 2
                : 1;
        final columns = fit < maxColumns ? fit : maxColumns;
        final width =
            (constraints.maxWidth - spacing * (columns - 1)) / columns;

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: [
            for (final (i, project) in projects.indexed)
              SizedBox(
                width: width,
                child: RevealOnScroll(
                  delay: Duration(milliseconds: 100 * (i % columns)),
                  child: ProjectCard(project: project),
                ),
              ),
          ],
        );
      },
    );
  }
}
