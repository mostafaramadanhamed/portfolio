import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/link_launcher.dart';
import '../../../core/utils/responsive.dart';
import '../../../data/portfolio_data.dart';
import '../../../shared/widgets/app_buttons.dart';
import '../../../shared/widgets/link_icon_button.dart';
import '../../../shared/widgets/reveal_on_scroll.dart';
import '../../../shared/widgets/section_container.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobile;
    return Column(
      children: [
        SectionContainer(
          child: RevealOnScroll(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 600),
                child: Column(
                  children: [
                    Text("05. What's next?", style: AppTheme.mono(fontSize: 15)),
                    const SizedBox(height: 16),
                    Text(
                      "Let's build something together",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: context.isCompact
                            ? 28
                            : context.responsive(
                                mobile: 32,
                                tablet: 40,
                                desktop: 48,
                              ),
                        fontWeight: FontWeight.w800,
                        letterSpacing: -1,
                        height: 1.15,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "I'm open to new opportunities and freelance work. "
                      "Whether you have a role, a project, or just a question, "
                      "my inbox is open — I'll get back to you.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: isMobile ? 16 : 17,
                        height: 1.7,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    SizedBox(height: isMobile ? 32 : 40),
                    AppButtonGroup(
                      alignment: WrapAlignment.center,
                      children: [
                        AppButton(
                          label: 'Say hello',
                          onPressed: () =>
                              openLink('mailto:${PortfolioData.email}'),
                          variant: AppButtonVariant.primary,
                          icon: const Icon(Icons.mail_outline_rounded),
                        ),
                        AppButton(
                          label: 'WhatsApp',
                          onPressed: () =>
                              openLink(PortfolioData.whatsAppUrl),
                          icon: const FaIcon(
                            FontAwesomeIcons.whatsapp,
                            size: 18,
                            color: AppColors.whatsApp,
                          ),
                        ),
                        AppButton(
                          label: 'Download CV',
                          onPressed: () => openLink(PortfolioData.cvPath),
                          icon: const Icon(Icons.download_rounded),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    SelectableText(
                      PortfolioData.email,
                      style: AppTheme.mono(
                        fontSize: 13,
                        color: AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        const _Footer(),
      ],
    );
  }
}

class _Footer extends StatelessWidget {
  const _Footer();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: Column(
        children: [
          const Wrap(
            alignment: WrapAlignment.center,
            children: [
              LinkIconButton(
                icon: FontAwesomeIcons.github,
                url: PortfolioData.githubUrl,
                tooltip: 'GitHub',
                size: 18,
              ),
              LinkIconButton(
                icon: FontAwesomeIcons.linkedinIn,
                url: PortfolioData.linkedInUrl,
                tooltip: 'LinkedIn',
                size: 18,
              ),
              LinkIconButton(
                icon: FontAwesomeIcons.envelope,
                url: 'mailto:${PortfolioData.email}',
                tooltip: 'Email',
                size: 18,
              ),
              LinkIconButton(
                icon: FontAwesomeIcons.whatsapp,
                url: PortfolioData.whatsAppUrl,
                tooltip: 'WhatsApp',
                size: 18,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Designed & built with Flutter by ${PortfolioData.name}',
            textAlign: TextAlign.center,
            style: AppTheme.mono(fontSize: 12, color: AppColors.textMuted),
          ),
        ],
      ),
    );
  }
}
