import 'package:flutter/material.dart';

import 'screens/home_screen.dart';
import 'utils/service_locator.dart';

void main() {
  setupSl();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp();

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}
