import 'package:flutter/material.dart';

import '../../core/utils/responsive.dart';

class SectionContainer extends StatelessWidget {
  const SectionContainer({super.key, required this.child, this.minHeight});

  final Widget child;
  final double? minHeight;

  static const maxContentWidth = 1100.0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: maxContentWidth,
          minHeight: minHeight ?? 0,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.pageGutter,
            vertical: context.responsive(mobile: 56, tablet: 72, desktop: 88),
          ),
          child: child,
        ),
      ),
    );
  }
}
