import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/splash/screen/splash_screen.dart';

part 'splash_route.g.dart';

@TypedGoRoute<SplashRoute>(
  path: '/',
  name: 'Splash',
)
class SplashRoute extends GoRouteData {
  const SplashRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SplashScreen();
  }
}
