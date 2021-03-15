import 'package:flutter/material.dart';

class Pather {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  /// Tries to pop a route.
  ///
  /// Can be stopped by [WillPopScope].
  Future<bool> maybePop() async {
    return await navigatorKey.currentState?.maybePop() ?? false;
  }

  /// Pops a route.
  ///
  /// Can't be stopped by [WillPopScope].
  void pop() {
    navigatorKey.currentState?.pop();
  }

  /// Pushes a new [route].
  ///
  /// Example usage:
  /// ```
  /// locator<FhRouterScreen>().pushRoute(ExampleScreen(
  ///   param1,
  ///   param2: param2,
  ///   param3: param3,
  /// ));
  /// ```
  Future<T?> push<T extends Object>(Route<T> route) async {
    return await navigatorKey.currentState?.push(route);
  }

  /// Pushes new route and removes old ones.
  ///
  /// Pushes [newRoute] and removes routes from previous (not updated)
  /// stack until [untilRouteName] is detected.
  Future<T?> pushAndRemoveUntil<T extends Object>(
    Route<T> newRoute,
    String untilRouteName,
  ) async {
    return navigatorKey.currentState?.pushAndRemoveUntil(
      newRoute,
      (Route<dynamic> route) => untilRouteName == route.settings.name,
    );
  }

  /// Pops current route stack until [routeName] is detected;
  void popUntil<T extends Object>(String routeName) {
    navigatorKey.currentState?.popUntil(
      (Route<dynamic> route) => route.settings.name == routeName,
    );
  }
}
