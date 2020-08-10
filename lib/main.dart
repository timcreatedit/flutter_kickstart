import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kickstart/catcher.dart';
import 'package:kickstart/locator.dart';
import 'package:kickstart/services/dialog_service.dart';
import 'package:kickstart/services/navigation_service.dart';
import 'package:kickstart/view/shared/router.dart';
import 'package:kickstart/view/shared/theme/theme.dart';

import 'managers/dialog_manager.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Register all the models and services before the app starts
  setupLocator();
  runAppWithCatcherAndLocalization(App());
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'app-name'.tr(),
      builder: (context, child) => Navigator(
        key: locator<DialogService>().dialogNavigationKey,
        onGenerateRoute: (settings) => MaterialPageRoute(
          builder: (context) => DialogManager(child: child),
        ),
      ),
      navigatorKey: locator<NavigationService>().navigationKey,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      onGenerateRoute: generateRoute,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
    );
  }
}
