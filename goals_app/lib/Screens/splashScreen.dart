import 'package:flutter/material.dart';
import 'package:goals_app/Screens/ArgumentPassThroughScreens/priorityHomeArguments.dart';
import 'package:goals_app/Screens/Priorities/prioritiesHome.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

import 'package:page_transition/page_transition.dart';
import '../global.dart';

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
    return MaterialApp(
      home: Scaffold(
        appBar: null,
        body: AnimatedSplashScreen(
            splash: 'assets/icon/targetIcon.png',
            pageTransitionType: PageTransitionType.fade,
            nextScreen: PriorityHomeScreen.fromSplashScreen(true),
            duration: 2500,
            splashIconSize: 200,
            splashTransition: SplashTransition.scaleTransition),
      ),
    );
  }
}
