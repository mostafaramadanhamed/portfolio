import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../core/theme/app_colors.dart';
import '../../core/utils/link_launcher.dart';

class LinkIconButton extends StatelessWidget {
  const LinkIconButton({
    super.key,
    required this.icon,
    required this.url,
    required this.tooltip,
    this.size = 20,
  });

  final FaIconData icon;
  final String url;
  final String tooltip;
  final double size;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: tooltip,
      onPressed: () => openLink(url),
      hoverColor: AppColors.accent.withValues(alpha: 0.1),
      icon: FaIcon(icon, size: size, color: AppColors.textSecondary),
    );
  }
}
