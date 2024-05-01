import 'dart:async';
import 'package:calculator/screen/main_page.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MainPage(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final ScreenHeight = MediaQuery.of(context).size.height;
    final QScreenHeight = .3 * ScreenHeight;
    return Scaffold(
      backgroundColor: Colors.black, // Set the background color to indigo
      body: Stack(
        fit: StackFit.expand,
        children: [
          SizedBox(
            height: QScreenHeight,
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'CalcPlus',
                style: TextStyle(
                  fontSize: 70,
                  fontFamily: 'Jersey10-Regular',
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
