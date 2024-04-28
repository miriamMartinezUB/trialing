import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:trialing/features/main/main_page.dart';
import 'package:trialing/resoruces/routes.dart';

List<RouteBase> routes = [
  GoRoute(
    path: Routes.initialRoute,
    builder: (BuildContext context, GoRouterState state) {
      return const MainPage();
    },
    routes: <RouteBase>[
      GoRoute(
        path: Routes.home,
        builder: (BuildContext context, GoRouterState state) {
          return const Scaffold();
        },
      ),
      GoRoute(
        path: Routes.history,
        builder: (BuildContext context, GoRouterState state) {
          return const Scaffold();
        },
      ),
      GoRoute(
        path: Routes.settings,
        builder: (BuildContext context, GoRouterState state) {
          return const Scaffold();
        },
      ),
    ],
  ),
];
