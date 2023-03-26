import 'package:flutter/material.dart';
import 'package:my_guard/screens/splash_screen.dart';

import 'screens/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Guard',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //home: const MyHomePage(),
      //home: const MyLogin(),
      home: const SplashScreen(),
    );
  }
}
