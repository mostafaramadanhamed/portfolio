import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/link_launcher.dart';
import '../../core/utils/responsive.dart';
import '../../data/portfolio_data.dart';
import '../../shared/widgets/app_buttons.dart';
import 'nav_section.dart';
import 'sections/about_section.dart';
import 'sections/contact_section.dart';
import 'sections/experience_section.dart';
import 'sections/hero_section.dart';
import 'sections/projects_section.dart';
import 'sections/skills_section.dart';
import 'widgets/nav_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _heroKey = GlobalKey();
  final _sectionKeys = {
    for (final section in NavSection.values) section: GlobalKey(),
  };

  void _scrollToKey(GlobalKey key) {
    final targetContext = key.currentContext;
    if (targetContext == null) return;
    Scrollable.ensureVisible(
      targetContext,
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOutCubic,
    );
  }

  void _onNavTap(NavSection section) {
    if (_scaffoldKey.currentState?.isEndDrawerOpen ?? false) {
      Navigator.of(context).pop();
    }
    _scrollToKey(_sectionKeys[section]!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: context.isDesktop ? null : _MenuDrawer(onTap: _onNavTap),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: NavBar.height),
                HeroSection(
                  key: _heroKey,
                  onViewProjects: () =>
                      _scrollToKey(_sectionKeys[NavSection.projects]!),
                ),
                AboutSection(key: _sectionKeys[NavSection.about]),
                ExperienceSection(key: _sectionKeys[NavSection.experience]),
                ProjectsSection(key: _sectionKeys[NavSection.projects]),
                SkillsSection(key: _sectionKeys[NavSection.skills]),
                ContactSection(key: _sectionKeys[NavSection.contact]),
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: NavBar(
              onLogoTap: () => _scrollToKey(_heroKey),
              onSectionTap: _onNavTap,
              onMenuTap: () => _scaffoldKey.currentState?.openEndDrawer(),
            ),
          ),
        ],
      ),
    );
  }
}

class _MenuDrawer extends StatelessWidget {
  const _MenuDrawer({required this.onTap});

  final ValueChanged<NavSection> onTap;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.surface,
      width: context.isMobile ? context.screenWidth * 0.8 : 320,
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
          children: [
            for (final (i, section) in NavSection.values.indexed)
              ListTile(
                leading: Text(
                  '0${i + 1}.',
                  style: AppTheme.mono(fontSize: 14),
                ),
                title: Text(
                  section.label,
                  style: const TextStyle(fontSize: 18),
                ),
                onTap: () => onTap(section),
              ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: AppButton(
                label: 'Resume',
                onPressed: () => openLink(PortfolioData.cvPath),
                icon: const Icon(Icons.download_rounded, size: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
