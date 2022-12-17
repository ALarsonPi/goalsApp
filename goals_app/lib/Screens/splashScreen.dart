import 'package:flutter/material.dart';
import 'package:goals_app/Screens/Priorities/prioritiesHome.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

import 'package:page_transition/page_transition.dart';
import '../Settings/global.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SplashScreen();
  }
}

class _SplashScreen extends State<SplashScreen> {
  @override
  void initState() {
    getUserPriorities();
    super.initState();
  }

  getUserPriorities() async {
    await Global.getPriorities();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: AnimatedSplashScreen(
          splash: 'assets/icon/TheAlpsCreations.png',
          pageTransitionType: PageTransitionType.fade,
          nextScreen: PriorityHomeScreen(),
          duration: 2200,
          splashIconSize: 500,
          splashTransition: SplashTransition.fadeTransition),
    );
  }
}
