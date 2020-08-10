import 'package:catcher/catcher.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:kickstart/services/navigation_service.dart';

import 'locator.dart';

CatcherOptions debugOptions = CatcherOptions(
  SilentReportMode(),
  [
    ConsoleHandler(),
  ],
);

void runAppWithCatcherAndLocalization(Widget appRoot) {
  Catcher(
    EasyLocalization(
      path: 'assets/lang',
      supportedLocales: [Locale('en', 'US')],
      child: appRoot,
    ),
    debugConfig: debugOptions,
    enableLogger: true,
    navigatorKey: locator<NavigationService>().navigationKey,
  );
}
