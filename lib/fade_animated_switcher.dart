import 'package:flutter/material.dart';

class FadeAnimatedSwitcher extends StatelessWidget {
  const FadeAnimatedSwitcher({
    required this.child,
    super.key,
    this.fadeDuration = kThemeAnimationDuration,
    this.fadeInCurve = Curves.easeInOut,
    this.fadeOutCurve = Curves.easeInOut,
  });

  final Widget child;
  final Duration fadeDuration;
  final Curve fadeInCurve;
  final Curve fadeOutCurve;

  @override
  Widget build(BuildContext context) => AnimatedSwitcher(
    duration: fadeDuration,
    switchInCurve: fadeInCurve,
    switchOutCurve: fadeOutCurve,
    transitionBuilder: (child, animation) => FadeTransition(opacity: animation, child: child),
    child: child,
  );
}

extension FadeAnimatedSwitcherX on Widget {
  Widget withAnimation({
    Duration fadeDuration = kThemeAnimationDuration,
    Curve fadeInCurve = Curves.easeInOut,
    Curve fadeOutCurve = Curves.easeInOut,
    Key? key,
  }) => FadeAnimatedSwitcher(
    fadeDuration: fadeDuration,
    fadeInCurve: fadeInCurve,
    fadeOutCurve: fadeOutCurve,
    key: key,
    child: this,
  );
}
