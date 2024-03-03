import 'package:flutter/material.dart';

import '../../config/log/talker.dart';

// import '../log/talker.dart';

@immutable
class MyNavigatorObserver extends NavigatorObserver {
  MyNavigatorObserver();

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    talker.info('DID-PUSH        ${route.settings.name}');
    super.didPush(route, previousRoute);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    talker.info('DID-POP        ${route.settings.name}');
    super.didPop(route, previousRoute);
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    talker.info('DID-REMOVE        ${route.settings.name}');
    super.didRemove(route, previousRoute);
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    talker.info('DID-REPLACE        ${oldRoute?.settings.name}');
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
  }
}
