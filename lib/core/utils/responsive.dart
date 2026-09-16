import 'package:flutter/widgets.dart';

abstract final class Breakpoints {
  static const compact = 400.0;
  static const tablet = 700.0;
  static const desktop = 1024.0;
}

extension ResponsiveContext on BuildContext {
  double get screenWidth => MediaQuery.sizeOf(this).width;
  double get screenHeight => MediaQuery.sizeOf(this).height;

  /// Narrow phones such as the iPhone SE.
  bool get isCompact => screenWidth < Breakpoints.compact;
  bool get isMobile => screenWidth < Breakpoints.tablet;
  bool get isTablet => !isMobile && !isDesktop;
  bool get isDesktop => screenWidth >= Breakpoints.desktop;

  /// Horizontal page padding that scales with the screen.
  double get pageGutter => isCompact
      ? 16
      : isMobile
          ? 20
          : isTablet
              ? 32
              : 40;

  /// Picks a value for the current breakpoint; [tablet] falls back to [mobile].
  T responsive<T>({required T mobile, T? tablet, required T desktop}) {
    if (isDesktop) return desktop;
    if (isTablet) return tablet ?? mobile;
    return mobile;
  }
}
