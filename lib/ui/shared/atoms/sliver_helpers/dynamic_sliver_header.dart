import 'package:flutter/widgets.dart';

typedef SliverHeaderBuilder = Widget Function(
    BuildContext context, double shrinkProgress, bool overlapsContent);

class DynamicSliverHeaderDelegate extends SliverPersistentHeaderDelegate {
  DynamicSliverHeaderDelegate({
    required Widget this.child,
    required double maxExtent,
    required double minExtent,
  })  : builder = null,
        _maxExtent = maxExtent,
        _minExtent = minExtent;

  DynamicSliverHeaderDelegate.builder({
    required SliverHeaderBuilder this.builder,
    required double maxExtent,
    required double minExtent,
  })  : child = null,
        _maxExtent = maxExtent,
        _minExtent = minExtent;

  final SliverHeaderBuilder? builder;
  final Widget? child;
  final double _maxExtent;
  final double _minExtent;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return builder?.call(
            context,
            (shrinkOffset / (maxExtent - minExtent)).clamp(0, 1),
            overlapsContent) ??
        child ??
        const SizedBox();
  }

  @override
  double get maxExtent => _maxExtent;

  @override
  double get minExtent => _minExtent;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return oldDelegate.maxExtent != maxExtent ||
        oldDelegate.minExtent != minExtent ||
        oldDelegate is! DynamicSliverHeaderDelegate ||
        oldDelegate.builder != builder;
  }
}
