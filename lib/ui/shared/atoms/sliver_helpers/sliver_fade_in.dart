import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class SliverFadeIn extends SingleChildRenderObjectWidget {
  const SliverFadeIn({
    super.key,
    super.child,
    this.minOpacity = 0,
    this.maxRelativeOffset = 0.5,
    this.alwaysIncludeSemantics = false,
  });

  final double minOpacity;
  final double maxRelativeOffset;
  final bool alwaysIncludeSemantics;

  @override
  RenderObject createRenderObject(BuildContext context) => RenderSliverFadeIn(
        minOpacity: minOpacity,
        maxRelativeOffset: maxRelativeOffset,
        alwaysIncludeSemantics: alwaysIncludeSemantics,
      );
}

class RenderSliverFadeIn extends RenderProxySliver {
  /// Creates a partially transparent render object.
  ///
  /// The [opacity] argument must be between 0.0 and 1.0, inclusive.
  RenderSliverFadeIn({
    required this.maxRelativeOffset,
    required double minOpacity,
    bool alwaysIncludeSemantics = false,
    RenderSliver? sliver,
  })  : assert(minOpacity >= 0.0 && minOpacity <= 1.0),
        assert(maxRelativeOffset > 0),
        _minOpacity = minOpacity,
        _alwaysIncludeSemantics = alwaysIncludeSemantics,
        _minAlpha = Color.getAlphaFromOpacity(minOpacity) {
    child = sliver;
  }

  final double maxRelativeOffset;

  @override
  bool get alwaysNeedsCompositing => child != null && (_minAlpha > 0);

  final int _minAlpha;

  /// The fraction to scale the child's alpha value.
  ///
  /// An opacity of 1.0 is fully opaque. An opacity of 0.0 is fully transparent
  /// (i.e. invisible).
  ///
  /// The opacity must not be null.
  ///
  /// Values 1.0 and 0.0 are painted with a fast path. Other values
  /// require painting the child into an intermediate buffer, which is
  /// expensive.
  double get opacity => _minOpacity;
  double _minOpacity;
  set opacity(double value) {
    assert(value >= 0.0 && value <= 1.0);
    if (_minOpacity == value) {
      return;
    }
    final bool didNeedCompositing = alwaysNeedsCompositing;
    final bool wasVisible = _minAlpha != 0;
    _minOpacity = value;
    if (didNeedCompositing != alwaysNeedsCompositing) {
      markNeedsCompositingBitsUpdate();
    }
    markNeedsPaint();
    if (wasVisible != (_minAlpha != 0) && !alwaysIncludeSemantics) {
      markNeedsSemanticsUpdate();
    }
  }

  /// Whether child semantics are included regardless of the opacity.
  ///
  /// If false, semantics are excluded when [opacity] is 0.0.
  ///
  /// Defaults to false.
  bool get alwaysIncludeSemantics => _alwaysIncludeSemantics;
  bool _alwaysIncludeSemantics;
  set alwaysIncludeSemantics(bool value) {
    if (value == _alwaysIncludeSemantics) {
      return;
    }
    _alwaysIncludeSemantics = value;
    markNeedsSemanticsUpdate();
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    if (child != null && child!.geometry!.visible) {
      final relativeOffset = (constraints.remainingPaintExtent /
              constraints.viewportMainAxisExtent) /
          maxRelativeOffset;
      final int alpha = (_minAlpha + (255 - _minAlpha) * relativeOffset)
          .clamp(0, 255)
          .round();
      if (alpha == 0) {
        // No need to keep the layer. We'll create a new one if necessary.
        layer = null;
        return;
      }
      layer = context.pushOpacity(
        offset,
        alpha,
        super.paint,
        oldLayer: layer as OpacityLayer?,
      );
      assert(() {
        layer!.debugCreator = debugCreator;
        return true;
      }());
    }
  }

  @override
  void visitChildrenForSemantics(RenderObjectVisitor visitor) {
    if (child != null && (_minAlpha != 0 || alwaysIncludeSemantics)) {
      visitor(child!);
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DoubleProperty('opacity', opacity));
    properties.add(FlagProperty('alwaysIncludeSemantics',
        value: alwaysIncludeSemantics, ifTrue: 'alwaysIncludeSemantics'));
  }
}
