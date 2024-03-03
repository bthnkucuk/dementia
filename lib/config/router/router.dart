import 'package:dementia/config/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'navigation_observer.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  overridePlatformDefaultLocation: true,
  initialLocation: '/home',
  observers: [MyNavigatorObserver()],
  navigatorKey: rootNavigatorKey,
  debugLogDiagnostics: true,
  routes: [$homeRoute],
);
