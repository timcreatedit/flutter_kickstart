import 'package:auto_route/auto_route.dart';
import 'package:flutter_kickstart/ui/home/home.page.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';

part 'router.gr.dart';

@MaterialAutoRouter(
  routes: [
    AutoRoute(
      page: HomePage
    ),
  ],
)
class AppRouter extends _$AppRouter {}

final routerProvider = Provider((ref) => AppRouter());