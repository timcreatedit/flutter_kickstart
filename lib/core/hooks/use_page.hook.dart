import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

/// Returns the current page of the given [pageController] and null if no page
/// is built yet.
double? usePage(PageController pageController) {
  final pc = useListenable(pageController);
  return pc.hasClients && pc.position.haveDimensions ? pc.page : null;
}
