// import 'package:animated_splash_screen/animated_splash_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
// import 'package:water_tracker/widgets/pages/home/homepage/home_pageui.dart';
// import 'package:water_tracker/widgets/pages/home/side_bar.dart';

// class MySplash extends StatefulWidget {
//   const MySplash({super.key});

//   @override
//   State<MySplash> createState() => _MySplashState();
// }

// class _MySplashState extends State<MySplash> {
//   @override
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         title: 'Clean Code',
//         home: AnimatedSplashScreen(
//             duration: 100,
//             splash: Icons.home,
//             nextScreen: const MyHome(),
//             splashTransition: SplashTransition.fadeTransition,
//             backgroundColor: Colors.blue));
//   }
// }
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:water_tracker/widgets/pages/home/side_bar.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MyHome()),
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
