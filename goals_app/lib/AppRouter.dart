import 'package:flutter/material.dart';
import 'package:goals_app/Screens/ArgumentPassThroughScreens/individualPriorityArgumentScreen.dart';
import 'package:goals_app/Screens/ArgumentPassThroughScreens/newGoalArguements.dart';
import 'package:goals_app/Screens/Goals/individualGoal.dart';
import 'package:goals_app/Screens/Goals/newGoalScreen.dart';
import 'package:goals_app/Screens/Goals/newPriority.dart';
import 'package:goals_app/Screens/Priorities/individualPriority.dart';
import 'package:goals_app/Screens/browseImages.dart';
import 'package:goals_app/Screens/optionsScreen.dart';
import 'package:goals_app/Screens/splashScreen.dart';
import 'package:goals_app/Unused/editPriority.dart';
import 'package:goals_app/Screens/ArgumentPassThroughScreens/editPriotitiesArguments.dart';
import 'package:goals_app/Unused/reorderPriorities.dart';

import 'Objects/Priority.dart';
import 'Screens/Priorities/prioritiesHome.dart';

class AppRouter extends StatelessWidget {
  const AppRouter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Goals App',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        darkTheme: ThemeData.dark(),
        builder: (context, widget) => Navigator(
              onGenerateRoute: (RouteSettings settings) => MaterialPageRoute(
                builder: (ctx) {
                  return Container(
                    child: widget,
                  );
                },
              ),
            ),
        initialRoute: '/',
        routes: {
          //Global
          '/': (context) => SplashScreen(),
          OptionsScreen.routeName: ((context) => OptionsScreen()),

          //Priorities
          '/new-priority': (context) => NewPriorityScreen(),
          NewGoalScreen.routeName: ((context) => NewGoalScreen()),
          PriorityHomeScreen.routeName: ((context) => PriorityHomeScreen()),
          BrowseImagesScreen.routeName: (context) => BrowseImagesScreen(),
          IndividualPriority.routeName: (context) => const IndividualPriority(),

          //Goals
          IndividualGoal.routeName: ((context) => IndividualGoal()),
        });
  }
}
