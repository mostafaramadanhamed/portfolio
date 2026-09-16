import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

/// Fades and slides its child in the first time it scrolls into view.
class RevealOnScroll extends StatefulWidget {
  const RevealOnScroll({
    super.key,
    required this.child,
    this.delay = Duration.zero,
  });

  final Widget child;
  final Duration delay;

  @override
  State<RevealOnScroll> createState() => _RevealOnScrollState();
}

class _RevealOnScrollState extends State<RevealOnScroll> {
  final _detectorKey = UniqueKey();
  bool _visible = false;

  void _onVisibilityChanged(VisibilityInfo info) {
    if (_visible || info.visibleFraction < 0.1) return;
    Future.delayed(widget.delay, () {
      if (mounted) setState(() => _visible = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: _detectorKey,
      onVisibilityChanged: _onVisibilityChanged,
      child: AnimatedOpacity(
        opacity: _visible ? 1 : 0,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeOut,
        child: AnimatedSlide(
          offset: _visible ? Offset.zero : const Offset(0, 0.08),
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeOutCubic,
          child: widget.child,
        ),
      ),
    );
  }
}
