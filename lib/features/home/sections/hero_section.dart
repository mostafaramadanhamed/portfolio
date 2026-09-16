import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/link_launcher.dart';
import '../../../core/utils/responsive.dart';
import '../../../data/portfolio_data.dart';
import '../../../shared/widgets/app_buttons.dart';
import '../../../shared/widgets/link_icon_button.dart';
import '../../../shared/widgets/section_container.dart';
import '../widgets/code_card.dart';
import '../widgets/nav_bar.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key, required this.onViewProjects});

  final VoidCallback onViewProjects;

  @override
  Widget build(BuildContext context) {
    final intro = _Intro(onViewProjects: onViewProjects);

    // Fill the first screen on larger viewports, but never force a height on
    // short landscape screens where the content is already taller.
    final fillHeight = context.screenHeight - NavBar.height;
    final minHeight =
        !context.isMobile && context.screenHeight >= 600 ? fillHeight : null;

    return SectionContainer(
      minHeight: minHeight,
      child: Center(
        child: switch (context) {
          _ when context.isDesktop => Row(
              children: [
                Expanded(flex: 6, child: intro),
                const SizedBox(width: 48),
                const Expanded(flex: 5, child: CodeCard()),
              ],
            ),
          _ when context.isTablet => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                intro,
                const SizedBox(height: 48),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 560),
                  child: const CodeCard(),
                ),
              ],
            ),
          _ => intro,
        },
      ),
    );
  }
}

class _Intro extends StatelessWidget {
  const _Intro({required this.onViewProjects});

  final VoidCallback onViewProjects;

  @override
  Widget build(BuildContext context) {
    final nameSize = context.isCompact
        ? 36.0
        : context.responsive(mobile: 42.0, tablet: 56.0, desktop: 64.0);
    final headlineSize = context.isCompact
        ? 28.0
        : context.responsive(mobile: 32.0, tablet: 44.0, desktop: 52.0);

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: const Duration(milliseconds: 900),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) => Opacity(
        opacity: value,
        child: Transform.translate(
          offset: Offset(0, 24 * (1 - value)),
          child: child,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('> Hi, my name is', style: AppTheme.mono(fontSize: 16)),
          const SizedBox(height: 16),
          Text(
            PortfolioData.name,
            style: TextStyle(
              fontSize: nameSize,
              fontWeight: FontWeight.w800,
              height: 1.1,
              letterSpacing: nameSize * -0.02,
            ),
          ),
          const SizedBox(height: 8),
          ShaderMask(
            shaderCallback: (bounds) => const LinearGradient(
              colors: [AppColors.accent, AppColors.accentSecondary],
            ).createShader(bounds),
            child: Text(
              'I build Flutter apps.',
              style: TextStyle(
                fontSize: headlineSize,
                fontWeight: FontWeight.w800,
                height: 1.15,
                letterSpacing: headlineSize * -0.02,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 24),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 540),
            child: Text(
              PortfolioData.tagline,
              style: TextStyle(
                fontSize: context.isMobile ? 16 : 18,
                height: 1.6,
                color: AppColors.textSecondary,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(
                Icons.location_on_outlined,
                size: 16,
                color: AppColors.textMuted,
              ),
              const SizedBox(width: 6),
              Flexible(
                child: Text(
                  '${PortfolioData.role} · ${PortfolioData.location}',
                  style: AppTheme.mono(
                    fontSize: 13,
                    color: AppColors.textMuted,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: context.isMobile ? 28 : 36),
          AppButtonGroup(
            children: [
              AppButton(
                label: 'View my work',
                onPressed: onViewProjects,
                variant: AppButtonVariant.primary,
                icon: const Icon(Icons.arrow_downward_rounded, size: 18),
              ),
              AppButton(
                label: 'Download CV',
                onPressed: () => openLink(PortfolioData.cvPath),
                icon: const Icon(Icons.download_rounded, size: 18),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const _SocialLinks(),
        ],
      ),
    );
  }
}

class _SocialLinks extends StatelessWidget {
  const _SocialLinks();

  @override
  Widget build(BuildContext context) {
    return const Wrap(
      spacing: 4,
      children: [
        LinkIconButton(
          icon: FontAwesomeIcons.github,
          url: PortfolioData.githubUrl,
          tooltip: 'GitHub',
        ),
        LinkIconButton(
          icon: FontAwesomeIcons.linkedinIn,
          url: PortfolioData.linkedInUrl,
          tooltip: 'LinkedIn',
        ),
        LinkIconButton(
          icon: FontAwesomeIcons.whatsapp,
          url: PortfolioData.whatsAppUrl,
          tooltip: 'WhatsApp',
        ),
        LinkIconButton(
          icon: FontAwesomeIcons.envelope,
          url: 'mailto:${PortfolioData.email}',
          tooltip: 'Email',
        ),
      ],
    );
  }
}
