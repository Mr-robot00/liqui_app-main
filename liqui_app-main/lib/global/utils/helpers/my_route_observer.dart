import 'package:flutter/material.dart';
import 'package:liqui_app/global/analytics/log_events.dart';

class MyRouteObserver extends RouteObserver<PageRoute> {
  void _sendScreenView(PageRoute route) {
    String screenName = route.settings.name ?? " Flutter";
    // printLog('Current Screen: $screenName');
    // do something with it, ie. send it to your analytics service collector
    logEvent.setCurrentScreen(
        screenName: screenName.substring(1), screenClass: screenName);
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    if (route is PageRoute) {
      _sendScreenView(route);
      // printLog('didPush ${route.settings.name}');
    }
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (newRoute is PageRoute) {
      _sendScreenView(newRoute);
      // printLog('didReplace ${newRoute.settings.name}');
    }
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    if (previousRoute is PageRoute && route is PageRoute) {
      _sendScreenView(previousRoute);
      // printLog('didPop ${route.settings.name}');
    }
  }
}
