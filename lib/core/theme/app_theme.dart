import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

abstract final class AppTheme {
  static TextStyle mono({
    double fontSize = 14,
    Color color = AppColors.accent,
    FontWeight fontWeight = FontWeight.w400,
    double? height,
  }) =>
      GoogleFonts.jetBrainsMono(
        fontSize: fontSize,
        color: color,
        fontWeight: fontWeight,
        height: height,
      );

  static ThemeData get dark {
    final base = ThemeData(
      brightness: Brightness.dark,
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.accent,
        secondary: AppColors.accentSecondary,
        surface: AppColors.surface,
        onSurface: AppColors.textPrimary,
      ),
    );

    return base.copyWith(
      textTheme: GoogleFonts.interTextTheme(base.textTheme).apply(
        bodyColor: AppColors.textPrimary,
        displayColor: AppColors.textPrimary,
      ),
      dividerColor: AppColors.border,
      tooltipTheme: const TooltipThemeData(
        decoration: BoxDecoration(
          color: AppColors.surfaceHigh,
          borderRadius: BorderRadius.all(Radius.circular(6)),
        ),
        textStyle: TextStyle(color: AppColors.textPrimary, fontSize: 12),
      ),
    );
  }
}
