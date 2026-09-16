import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:protfolio/main.dart';
import 'package:visibility_detector/visibility_detector.dart';

const _sizes = {
  'small phone': Size(320, 640),
  'phone': Size(390, 844),
  'large phone landscape': Size(844, 390),
  'tablet portrait': Size(768, 1024),
  'tablet landscape': Size(1024, 768),
  'laptop': Size(1280, 800),
  'desktop': Size(1920, 1080),
};

void main() {
  setUpAll(() {
    GoogleFonts.config.allowRuntimeFetching = false;
    VisibilityDetectorController.instance.updateInterval = Duration.zero;
  });

  for (final MapEntry(key: name, value: size) in _sizes.entries) {
    testWidgets('renders without overflow on $name (${size.width}x${size.height})',
        (tester) async {
      tester.view
        ..physicalSize = size
        ..devicePixelRatio = 1;
      addTearDown(tester.view.reset);

      await tester.pumpWidget(const PortfolioApp());
      // Measure with the real bundled fonts, not the default test font.
      await tester.runAsync(GoogleFonts.pendingFonts);
      await tester.pump(const Duration(seconds: 2));

      // Scroll through the whole page so every section lays out.
      final scrollable = find.byType(Scrollable).first;
      for (var i = 0; i < 40; i++) {
        await tester.drag(scrollable, Offset(0, -size.height * 0.8));
        await tester.pump(const Duration(milliseconds: 700));
      }

      // Compact layouts expose the drawer instead of inline nav links.
      final menu = find.byTooltip('Menu');
      expect(menu, size.width < 1024 ? findsOneWidget : findsNothing);
      if (size.width < 1024) {
        await tester.tap(menu);
        await tester.pumpAndSettle();
        expect(find.text('Resume'), findsOneWidget);
      }
    });
  }
}
