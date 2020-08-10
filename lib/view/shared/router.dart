import 'package:flutter/material.dart';
import 'package:kickstart/constants/route_names.dart';
import 'package:kickstart/view/home_view/home_view.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case HomeViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: HomeView(),
      );
  }
}

PageRoute _getPageRoute({
  @required String routeName,
  @required Widget viewToShow,
  bool fullscreenDialog = false,
}) {
  return MaterialPageRoute(
    settings: RouteSettings(
      name: routeName,
    ),
    builder: (_) => viewToShow,
    fullscreenDialog: fullscreenDialog,
  );
}
