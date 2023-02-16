import 'package:flutter/material.dart';

/// A widget that switches it's child out with a nice animation and also
/// animates it's size with sensible default values along [axis].
///
/// If [child] is null, this widget takes up as little space as possible.
/// This widget picks up on changes to [child] the same way, [AnimatedSwitcher]
/// does.
class AnimatedExpanded extends StatelessWidget {
  AnimatedExpanded({
    super.key,
    required this.child,
    this.axis = Axis.vertical,
    this.alignToAxisEnd = false,
    this.curve = Curves.ease,
    this.duration = kThemeAnimationDuration,
    this.clipBehavior = Clip.hardEdge,
    AnimatedSwitcherTransitionBuilder? transitionBuilder,
  }) : transitionBuilder = transitionBuilder ?? fadeTransitionBuilder;

  final Widget? child;
  final Axis axis;
  final bool alignToAxisEnd;
  final Curve curve;
  final Duration duration;
  final Clip clipBehavior;
  final AnimatedSwitcherTransitionBuilder transitionBuilder;

  Alignment _resolveAlignment(bool rtl) {
    if (axis == Axis.vertical) {
      return alignToAxisEnd ? Alignment.bottomCenter : Alignment.topCenter;
    } else {
      return rtl ^ alignToAxisEnd
          ? Alignment.centerRight
          : Alignment.centerLeft;
    }
  }

  @override
  Widget build(BuildContext context) {
    final rtl = Directionality.of(context) == TextDirection.rtl;

    final alignment = _resolveAlignment(rtl);

    return AnimatedSwitcher(
      duration: duration,
      switchInCurve: curve,
      transitionBuilder: transitionBuilder,
      layoutBuilder: (currentChild, previousChildren) => Stack(
        alignment: alignment,
        children: <Widget>[
          for (final c in previousChildren)
            Positioned.fill(
              top: 0,
              left: 0,
              right: axis == Axis.vertical ? 0 : null,
              bottom: axis == Axis.vertical ? null : 0,
              child: FocusScope(
                canRequestFocus: false,
                child: c,
              ),
            ),
          if (currentChild != null)
            AnimatedSize(
              alignment: alignment,
              duration: duration,
              curve: curve,
              clipBehavior: clipBehavior,
              child: currentChild,
            ),
        ],
      ),
      child: child ??
          (axis == Axis.vertical
              ? const SizedBox(width: double.infinity)
              : const SizedBox(height: double.infinity)),
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
