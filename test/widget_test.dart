import 'package:flutter_test/flutter_test.dart';
import 'package:protfolio/data/portfolio_data.dart';

void main() {
  test('every project has something to show or a link to follow', () {
    for (final project in [
      ...PortfolioData.workProjects,
      ...PortfolioData.personalProjects,
    ]) {
      final hasLink = project.githubUrl != null ||
          project.demoUrl != null ||
          project.storeUrl != null;
      final isWork = PortfolioData.workProjects.contains(project);
      expect(
        hasLink || project.screenshots.isNotEmpty || isWork,
        isTrue,
        reason: '${project.name} has no screenshots and no link',
      );
    }
  });

  test('every experience entry has highlights', () {
    for (final experience in PortfolioData.experience) {
      expect(experience.highlights, isNotEmpty, reason: experience.company);
    }
  });
}
