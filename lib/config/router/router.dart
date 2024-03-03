import 'package:dementia/config/router/anime_route.dart';
import 'package:dementia/config/router/splash_route.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'navigation_observer.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  overridePlatformDefaultLocation: true,
  initialLocation: '/',
  observers: [MyNavigatorObserver()],
  navigatorKey: rootNavigatorKey,
  debugLogDiagnostics: true,
  routes: [$splashRoute, $homeRoute],
);
