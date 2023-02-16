import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

/// A widget that switches it's child out with a nice animation and also
/// animates it's size with sensible default values.
///
/// If [child] is null, this widget takes up as little space as possible.
/// This widget picks up on changes to [child] the same way, [AnimatedSwitcher]
/// does.
class AnimatedSizeSwitcher extends StatelessWidget {
  AnimatedSizeSwitcher({
    super.key,
    required this.child,
    this.alignment = Alignment.center,
    this.curve = Curves.ease,
    this.duration = kThemeAnimationDuration,
    this.clipBehavior = Clip.hardEdge,
    AnimatedSwitcherTransitionBuilder? transitionBuilder,
  }) : transitionBuilder = transitionBuilder ?? fadeTransitionBuilder;

  final Widget? child;
  final Alignment alignment;
  final Curve curve;
  final Duration duration;
  final Clip clipBehavior;
  final AnimatedSwitcherTransitionBuilder transitionBuilder;

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      alignment: alignment,
      duration: duration,
      curve: curve,
      clipBehavior: clipBehavior,
      child: AnimatedSwitcher(
        duration: duration,
        switchInCurve: curve,
        transitionBuilder: transitionBuilder,
        layoutBuilder: (currentChild, previousChildren) => Stack(
          alignment: alignment,
          children: <Widget>[
            ...previousChildren,
            if (currentChild != null) currentChild,
          ],
        ),
        child: child ?? const SizedBox(),
      ),
    );
  }

  static AnimatedSwitcherTransitionBuilder fadeTransitionBuilder =
      (child, animation) => FadeTransition(
            opacity: animation,
            child: child,
          );

  static AnimatedSwitcherTransitionBuilder sizeFadeTransitionBuilder =
      (child, animation) => ScaleTransition(
            scale: animation,
            child: FadeTransition(
              opacity: animation,
              child: child,
            ),
          );
}

/// A widget that switches it's child out with a page animation and also
/// animates it's size with sensible default values.
///
/// If [child] is null, this widget takes up as little space as possible.
/// This widget picks up on changes to [child] the same way, [AnimatedSwitcher]
/// does.
class AnimatedPageSizeSwitcher extends StatelessWidget {
  AnimatedPageSizeSwitcher({
    super.key,
    required this.child,
    this.alignment = Alignment.center,
    this.curve = Curves.ease,
    this.duration = kThemeAnimationDuration,
    this.clipBehavior = Clip.hardEdge,
    this.reverse = false,
    PageTransitionSwitcherTransitionBuilder? transitionBuilder,
  }) : transitionBuilder =
            transitionBuilder ?? horizontalSharedAxisTransitionBuilder;

  final Widget? child;
  final Alignment alignment;
  final Curve curve;
  final Duration duration;
  final Clip clipBehavior;
  final bool reverse;
  final PageTransitionSwitcherTransitionBuilder transitionBuilder;

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      alignment: alignment,
      duration: duration,
      curve: curve,
      clipBehavior: clipBehavior,
      child: PageTransitionSwitcher(
        reverse: reverse,
        duration: duration,
        transitionBuilder: transitionBuilder,
        child: child ?? const SizedBox(),
        layoutBuilder: (entries) => Stack(
          alignment: alignment,
          children: entries,
        ),
      ),
    );
  }

  static PageTransitionSwitcherTransitionBuilder
      horizontalSharedAxisTransitionBuilder =
      (child, animation, secondaryAnimation) => SharedAxisTransition(
            animation: animation,
            secondaryAnimation: secondaryAnimation,
            transitionType: SharedAxisTransitionType.horizontal,
            child: child,
          );

  static PageTransitionSwitcherTransitionBuilder
      verticalSharedAxisTransitionBuilder =
      (child, animation, secondaryAnimation) => SharedAxisTransition(
            animation: animation,
            secondaryAnimation: secondaryAnimation,
            transitionType: SharedAxisTransitionType.horizontal,
            child: child,
          );
}
