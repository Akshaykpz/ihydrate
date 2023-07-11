import 'dart:async';
import 'package:flutter/material.dart';
import 'package:water_tracker/pages/view/home/side_bar.dart';
import 'package:water_tracker/pages/view/onbording/onbording.dart';

class SplashReset extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashReset> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const OnBoard()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
          Colors.purple,
          Colors.blue,
        ])),
        child: Scaffold(
            // By defaut, Scaffold background is white
            // Set its value to transparent
            backgroundColor: Colors.transparent,
            body: Center(
              child: Container(
                width: 500,
                height: 500,
                child: Image.asset('lib/assets/images/waternewicon.png'),
              ),
            )),
      ),
    );
  }
}
