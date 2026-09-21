import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../data/portfolio_data.dart';
import '../../../shared/widgets/hover_card.dart';
import '../../../shared/widgets/link_icon_button.dart';
import '../../../shared/widgets/tech_chip.dart';
import 'screenshot_strip.dart';

class ProjectCard extends StatelessWidget {
  const ProjectCard({super.key, required this.project});

  final Project project;

  @override
  Widget build(BuildContext context) {
    return HoverCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.folder_open_rounded,
                color: AppColors.accent,
                size: 34,
              ),
              const Spacer(),
              if (project.githubUrl case final url?)
                LinkIconButton(
                  icon: FontAwesomeIcons.github,
                  url: url,
                  tooltip: 'Source code',
                ),
              if (project.storeUrl case final url?)
                LinkIconButton(
                  icon: FontAwesomeIcons.googlePlay,
                  url: url,
                  tooltip: 'Store listing',
                ),
              if (project.caseStudyUrl case final url?)
                LinkIconButton(
                  icon: FontAwesomeIcons.newspaper,
                  url: url,
                  tooltip: 'Case study',
                  size: 18,
                ),
              if (project.demoUrl case final url?)
                LinkIconButton(
                  icon: FontAwesomeIcons.arrowUpRightFromSquare,
                  url: url,
                  tooltip: 'Live demo',
                  size: 18,
                ),
            ],
          ),
          const SizedBox(height: 18),
          if (project.screenshots.isNotEmpty) ...[
            ScreenshotStrip(
              screenshots: project.screenshots,
              projectName: project.name,
            ),
            const SizedBox(height: 20),
          ],
          Row(
            children: [
              Flexible(
                child: Text(
                  project.name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              if (project.status case final status?) ...[
                const SizedBox(width: 10),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.accentSecondary.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    status,
                    style: AppTheme.mono(
                      fontSize: 11,
                      color: AppColors.accentSecondary,
                    ),
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 10),
          Text(
            project.summary,
            style: const TextStyle(
              fontSize: 15,
              height: 1.55,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 14),
          for (final highlight in project.highlights)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('▹ ', style: AppTheme.mono(fontSize: 13)),
                  Expanded(
                    child: Text(
                      highlight,
                      style: const TextStyle(
                        fontSize: 14,
                        height: 1.55,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [for (final tech in project.tech) TechChip(tech)],
          ),
        ],
      ),
    );
  }
}
