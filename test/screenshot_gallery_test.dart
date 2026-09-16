import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:protfolio/data/portfolio_data.dart';
import 'package:protfolio/features/home/widgets/project_card.dart';

void main() {
  setUpAll(() => GoogleFonts.config.allowRuntimeFetching = false);

  final ensure = PortfolioData.personalProjects.firstWhere(
    (project) => project.name == 'Ensure',
  );

  Future<void> pumpCard(WidgetTester tester, Size size) async {
    tester.view
      ..physicalSize = size
      ..devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(
            child: SizedBox(width: 360, child: ProjectCard(project: ensure)),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('every screenshot asset is bundled', (tester) async {
    final projects = [
      ...PortfolioData.workProjects,
      ...PortfolioData.personalProjects,
    ];
    for (final project in projects) {
      for (final asset in project.screenshots) {
        final data = await rootBundle.load(asset);
        expect(data.lengthInBytes, greaterThan(0), reason: asset);
      }
    }
  });

  testWidgets('gallery opens, pages with arrows and keys, and closes on desktop',
      (tester) async {
    await pumpCard(tester, const Size(1280, 900));

    await tester.tap(_screenshot('Ensure screenshot 2'));
    await tester.pumpAndSettle();
    expect(find.text('2 / 5'), findsOneWidget);

    await tester.tap(find.byTooltip('Next'));
    await tester.pumpAndSettle();
    expect(find.text('3 / 5'), findsOneWidget);

    await tester.sendKeyEvent(LogicalKeyboardKey.arrowLeft);
    await tester.pumpAndSettle();
    expect(find.text('2 / 5'), findsOneWidget);

    await tester.tap(find.byTooltip('Close'));
    await tester.pumpAndSettle();
    expect(find.text('2 / 5'), findsNothing);
  });

  testWidgets('gallery swipes on phones and hides arrows', (tester) async {
    await pumpCard(tester, const Size(390, 844));

    await tester.tap(_screenshot('Ensure screenshot 1'));
    await tester.pumpAndSettle();
    expect(find.byTooltip('Next'), findsNothing);

    await tester.fling(find.byType(PageView), const Offset(-300, 0), 1000);
    await tester.pumpAndSettle();
    expect(find.text('2 / 5'), findsOneWidget);
  });
}

Finder _screenshot(String label) => find
    .byWidgetPredicate(
      (widget) => widget is Image && widget.semanticLabel == label,
    )
    .first;
