import 'package:calculator/features/splash/SplashScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(calculator());
}

class calculator extends StatelessWidget {
  const calculator({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}