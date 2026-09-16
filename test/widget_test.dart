import 'package:flutter_test/flutter_test.dart';
import 'package:protfolio/data/portfolio_data.dart';

void main() {
  test('personal projects all link to GitHub', () {
    for (final project in PortfolioData.personalProjects) {
      expect(project.githubUrl, isNotNull, reason: project.name);
    }
  });

  test('every experience entry has highlights', () {
    for (final experience in PortfolioData.experience) {
      expect(experience.highlights, isNotEmpty, reason: experience.company);
    }
  });
}
