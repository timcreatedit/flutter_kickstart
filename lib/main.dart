import 'package:flutter/material.dart';
import 'package:flutter_kickstart/lang/localization/localizations.dart';
import 'package:flutter_kickstart/view/design/theme/theme.dart';
import 'package:flutter_kickstart/view/routing/router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends HookConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      theme: ref.watch(themeProvider(brightness: Brightness.light)),
      darkTheme: ref.watch(themeProvider(brightness: Brightness.dark)),
      routerConfig: router,
      localizationsDelegates: L10n.localizationsDelegates,
      supportedLocales: L10n.supportedLocales,
    );
  }
}
