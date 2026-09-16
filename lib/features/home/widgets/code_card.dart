import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';

/// Editor-style card shown next to the hero intro on wide screens.
class CodeCard extends StatelessWidget {
  const CodeCard({super.key});

  @override
  Widget build(BuildContext context) {
    TextSpan span(String text, Color color) => TextSpan(
          text: text,
          style: AppTheme.mono(fontSize: 14, color: color, height: 1.9),
        );
    const plain = AppColors.textSecondary;

    final lines = <List<TextSpan>>[
      [
        span('class ', AppColors.codeKeyword),
        span('Mostafa ', AppColors.codeClass),
        span('extends ', AppColors.codeKeyword),
        span('Developer', AppColors.codeClass),
        span(' {', plain),
      ],
      [
        span('  final ', AppColors.codeKeyword),
        span('role', AppColors.codeField),
        span(' = ', plain),
        span("'Flutter Developer'", AppColors.codeString),
        span(';', plain),
      ],
      [
        span('  final ', AppColors.codeKeyword),
        span('stack', AppColors.codeField),
        span(' = [', plain),
      ],
      [
        span("    'Dart'", AppColors.codeString),
        span(', ', plain),
        span("'BLoC'", AppColors.codeString),
        span(', ', plain),
        span("'Riverpod'", AppColors.codeString),
        span(',', plain),
      ],
      [
        span("    'Firebase'", AppColors.codeString),
        span(', ', plain),
        span("'Supabase'", AppColors.codeString),
        span(',', plain),
      ],
      [span('  ];', plain)],
      [span('', plain)],
      [
        span('  @override', AppColors.codeClass),
      ],
      [
        span('  String ', AppColors.codeClass),
        span('get ', AppColors.codeKeyword),
        span('motto', AppColors.codeField),
        span(' =>', plain),
      ],
      [
        span("    'Clean code, smooth UI.'", AppColors.codeString),
        span(';', plain),
      ],
      [span('}', plain)],
    ];

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: AppColors.accent.withValues(alpha: 0.07),
            blurRadius: 60,
            offset: const Offset(0, 20),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: AppColors.border)),
            ),
            child: Row(
              children: [
                for (final color in const [
                  Color(0xFFFF5F57),
                  Color(0xFFFEBC2E),
                  Color(0xFF28C840),
                ]) ...[
                  CircleAvatar(radius: 6, backgroundColor: color),
                  const SizedBox(width: 8),
                ],
                const SizedBox(width: 8),
                Text(
                  'mostafa.dart',
                  style: AppTheme.mono(
                    fontSize: 12,
                    color: AppColors.textMuted,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (final (i, line) in lines.indexed)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 28,
                        child: Text(
                          '${i + 1}',
                          style: AppTheme.mono(
                            fontSize: 14,
                            color: AppColors.textMuted,
                            height: 1.9,
                          ),
                        ),
                      ),
                      Flexible(child: Text.rich(TextSpan(children: line))),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
