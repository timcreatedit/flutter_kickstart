import 'package:flutter/material.dart';
import 'package:flutter_kickstart/ui/routing/observers/debug_route_observer.dart';
import 'package:flutter_kickstart/ui/routing/router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends HookConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    return MaterialApp.router(
      title: L10n.of(context)!.appName,
      routerDelegate: router.delegate(
        initialDeepLink: "/",
        navigatorObservers: () => [DebugRouteObserver()],
      ),
      routeInformationParser: router.defaultRouteParser(),
      localizationsDelegates: L10n.localizationsDelegates,
      supportedLocales: L10n.supportedLocales,
      theme: ThemeData(

      ),
    );
  }
}
