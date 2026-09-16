import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'core/theme/app_theme.dart';
import 'features/home/home_page.dart';

void main() {
  // Fonts are bundled in assets/google_fonts.
  GoogleFonts.config.allowRuntimeFetching = false;
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mostafa Ramadan · Flutter Developer',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      home: const HomePage(),
    );
  }
}
