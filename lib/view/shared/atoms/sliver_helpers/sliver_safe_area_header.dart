import 'dart:math';

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

/// This widgets takes up the size of MediaQuery.padding at the beginning of the
/// scroll view, but only once it's pinned to the top of the screen.
///
/// This is helpful if you have a pinned header coming right after, but don't
/// want your top view padding to take up any space in your scroll view until
/// it needs to fill the top padding for real.
class SafeAreaPinnedHeader extends SingleChildRenderObjectWidget {
  const SafeAreaPinnedHeader({
    super.key,
    required Widget super.child,
  });

  @override
  RenderObject createRenderObject(BuildContext context) =>
      RenderSafeAreaPinnedHeader(
        MediaQuery.of(context),
      );
}

class RenderSafeAreaPinnedHeader extends RenderSliverSingleBoxAdapter {
  RenderSafeAreaPinnedHeader(this.mediaQuery);

  final MediaQueryData mediaQuery;

  @override
  void performLayout() {
    final sliverConstraints = constraints.asBoxConstraints();
    final layoutConstraints = sliverConstraints.tighten(
      height:
          constraints.axis == Axis.horizontal ? null : mediaQuery.padding.top,
      width: constraints.axis == Axis.vertical ? null : mediaQuery.padding.left,
    );
    child!.layout(layoutConstraints, parentUsesSize: true);

    double childExtent;
    switch (constraints.axis) {
      case Axis.horizontal:
        childExtent = child!.size.width;
        break;
      case Axis.vertical:
        childExtent = child!.size.height;
        break;
    }

    final paintedChildExtent = min(
      childExtent,
      constraints.remainingPaintExtent - constraints.overlap,
    );
    final spaceLeft =
        constraints.viewportMainAxisExtent - constraints.remainingPaintExtent;
    geometry = SliverGeometry(
      paintExtent: childExtent,
      maxPaintExtent: childExtent,
      // Move the sliver down once it touches the start of the viewport so it stays attached
      paintOrigin: max(-childExtent, -spaceLeft),
      maxScrollObstructionExtent: 0,
      scrollExtent: 0,
      layoutExtent: 0,
      hitTestExtent: 0,
      hasVisualOverflow: paintedChildExtent < childExtent,
    );
  }

  @override
  double childMainAxisPosition(RenderBox child) {
    return 0;
  }
}
