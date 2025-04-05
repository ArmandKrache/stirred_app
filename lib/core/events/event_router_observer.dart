import 'package:flutter/widgets.dart';
import 'package:stirred_app/core/events/event_manager.dart';
import 'package:stirred_app/presentation/router.dart';

/// NavigatorObserver that triggers events on navigation (push and pop)
class EventGoRouterObserver extends NavigatorObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);

    // The Navigation Event of home tabs is handled in the HomePage
    if (HomeTabConstants.routesName.values.contains(router.currentRoute)) {
      return;
    }

    final args = route.settings.arguments;
    String? accessedFrom;

    if (args != null && args is Map<String, String>) {
      accessedFrom = args['accessedFrom'];
    }
    EventManager.addEnterNavigationEvent(newLocation: router.currentRoute, accessedFrom: accessedFrom);
  }
}
