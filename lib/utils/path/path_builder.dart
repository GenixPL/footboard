import 'package:flutter/material.dart';

class PathBuilder {
  /// Default page route builder with a platform specific transition.
  ///
  /// Example usage:
  /// ```
  /// class ExampleScreen extends StatelessWidget {
  ///   const ExampleScreen(
  ///     param 1, {
  ///     this.param2,
  ///     this.param3,
  ///   });
  ///
  ///   static const String routeName = 'ExampleScreen';
  ///
  ///   static MaterialPageRoute<ExampleScreen> route(
  ///     T1 param1, {
  ///     T2 param2,
  ///     T3 param3,
  ///   }) {
  ///     return FhRouteBuilder().defaultTransition(
  ///       settings: const RouteSettings(name: routeName),
  ///       screen: ExampleScreen(
  ///         param1,
  ///         param2: param2,
  ///         param3: param3,
  ///       ),
  ///     );
  ///   }
  ///
  ///   ... (other code)
  ///
  /// }
  /// ```
  MaterialPageRoute<Widget> defaultTransition({
    required RouteSettings settings,
    required Widget screen,
  }) {
    return MaterialPageRoute<Widget>(
      settings: settings,
      builder: (BuildContext context) => screen,
    );
  }
}
