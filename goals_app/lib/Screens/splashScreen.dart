import 'package:flutter/material.dart';
import 'package:goals_app/Screens/ArgumentPassThroughScreens/priorityHomeArguments.dart';
import 'package:goals_app/Screens/Priorities/prioritiesHome.dart';

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
    //Eventually this will be async
    Global.getPriorities();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, PriorityHomeScreen.routeName,
              arguments: PriorityHomeArguments(0));
        },
        child: const Text("The App just started"));
  }
}
