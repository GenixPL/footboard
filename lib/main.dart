import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:footboard/screens/home/home_screen.dart';
import 'package:footboard/utils/path/pather.dart';
import 'package:footboard/utils/service_locator.dart';

void main() {
  setupSl();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.grey.shade900,
    ));

    return MaterialApp(
      navigatorKey: sl<Pather>().navigatorKey,
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        brightness: Brightness.dark,
        primaryColor: Colors.grey.shade900,
      ),
      home: const HomeScreen(),
    );
  }
}
