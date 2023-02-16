import 'dart:math';

import 'package:flutter/rendering.dart';

import 'package:flutter/widgets.dart';

/// [SliverPinnedViewportHeader] keeps its child pinned to the leading edge of the viewport.
class SliverPinnedViewportHeader extends SingleChildRenderObjectWidget {
  const SliverPinnedViewportHeader({
    Key? key,
    required Widget child,
    this.viewportFraction = 1,
    this.minExtent,
  }) : super(key: key, child: child);

  final double viewportFraction;
  final double? minExtent;

  @override
  RenderSliverPinnedViewportHeader createRenderObject(BuildContext context) {
    return RenderSliverPinnedViewportHeader()
      ..viewportFraction = viewportFraction
      ..minExtent = minExtent;
  }

  @override
  void updateRenderObject(
    BuildContext context,
    covariant RenderSliverPinnedViewportHeader renderObject,
  ) {
    renderObject
      ..viewportFraction = viewportFraction
      ..minExtent = minExtent;
    super.updateRenderObject(context, renderObject);
  }
}

class RenderSliverPinnedViewportHeader extends RenderSliverSingleBoxAdapter {
  RenderSliverPinnedViewportHeader();
  double _viewportFraction = 1;
  double _minExtent = 0;

  set viewportFraction(double v) {
    _viewportFraction = v;
    markNeedsLayout();
  }

  set minExtent(double? v) {
    _minExtent = v ?? 0;
    markNeedsLayout();
  }

  @override
  void performLayout() {
    final size =
        max(_minExtent, constraints.viewportMainAxisExtent * _viewportFraction);
    child!.layout(
      constraints.asBoxConstraints(maxExtent: size),
      parentUsesSize: true,
    );
    final paintedChildExtent = min(
      size,
      constraints.remainingPaintExtent - constraints.overlap,
    );
    geometry = SliverGeometry(
      paintExtent: paintedChildExtent,
      maxPaintExtent: size,
      maxScrollObstructionExtent: size,
      paintOrigin: constraints.overlap,
      scrollExtent: size,
      layoutExtent: max(0.0, paintedChildExtent - constraints.scrollOffset),
      hasVisualOverflow: paintedChildExtent < size,
    );
  }

  @override
  double childMainAxisPosition(RenderBox child) {
    return 0;
  }
}
