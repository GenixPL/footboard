import 'package:flutter/material.dart';
import 'package:footboard/screens/home/home_screen.dart';
import 'package:footboard/utils/service_locator.dart';

void main() {
  setupSl();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp();

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}
