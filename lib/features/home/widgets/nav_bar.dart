import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/link_launcher.dart';
import '../../../core/utils/responsive.dart';
import '../../../data/portfolio_data.dart';
import '../../../shared/widgets/section_container.dart';
import '../nav_section.dart';

class NavBar extends StatelessWidget {
  const NavBar({
    super.key,
    required this.onLogoTap,
    required this.onSectionTap,
    required this.onMenuTap,
  });

  static const height = 72.0;

  final VoidCallback onLogoTap;
  final ValueChanged<NavSection> onSectionTap;
  final VoidCallback onMenuTap;

  @override
  Widget build(BuildContext context) {
    // Inline links need desktop width; smaller screens use the drawer.
    final useMenu = !context.isDesktop;
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          height: height,
          decoration: BoxDecoration(
            color: AppColors.background.withValues(alpha: 0.75),
            border: const Border(bottom: BorderSide(color: AppColors.border)),
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: SectionContainer.maxContentWidth,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: context.pageGutter),
                child: Row(
                  children: [
                    InkWell(
                      onTap: onLogoTap,
                      borderRadius: BorderRadius.circular(6),
                      child: Padding(
                        padding: const EdgeInsets.all(4),
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: '<',
                                style: AppTheme.mono(fontSize: 18),
                              ),
                              TextSpan(
                                text: 'Mostafa',
                                style: AppTheme.mono(
                                  fontSize: 18,
                                  color: AppColors.textPrimary,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              TextSpan(
                                text: ' />',
                                style: AppTheme.mono(fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    if (useMenu)
                      IconButton(
                        tooltip: 'Menu',
                        onPressed: onMenuTap,
                        icon: const Icon(Icons.menu, color: AppColors.accent),
                      )
                    else ...[
                      for (final (i, section) in NavSection.values.indexed)
                        _NavLink(
                          index: i + 1,
                          label: section.label,
                          onTap: () => onSectionTap(section),
                        ),
                      const SizedBox(width: 12),
                      OutlinedButton(
                        onPressed: () => openLink(PortfolioData.cvPath),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.accent,
                          side: const BorderSide(color: AppColors.accent),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text('Resume'),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavLink extends StatefulWidget {
  const _NavLink({
    required this.index,
    required this.label,
    required this.onTap,
  });

  final int index;
  final String label;
  final VoidCallback onTap;

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: '0${widget.index}. ',
                  style: AppTheme.mono(fontSize: 13),
                ),
                TextSpan(
                  text: widget.label,
                  style: TextStyle(
                    fontSize: 14,
                    color: _hovered
                        ? AppColors.accent
                        : AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
