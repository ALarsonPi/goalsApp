import 'package:flutter/material.dart';
import 'package:goals_app/Screens/ArgumentPassThroughScreens/individualPriorityArgumentScreen.dart';
import 'package:goals_app/Screens/Goals/individualGoal.dart';
import 'package:goals_app/Screens/Goals/newGoalScreen.dart';
import 'package:goals_app/Screens/Priorities/newPriority.dart';
import 'package:goals_app/Screens/Priorities/individualPriority.dart';
import 'package:goals_app/Screens/browseImages.dart';
import 'package:goals_app/Screens/optionsScreen.dart';
import 'package:goals_app/Screens/splashScreen.dart';
import 'package:goals_app/Screens/ArgumentPassThroughScreens/editPriotitiesArguments.dart';
import 'package:page_transition/page_transition.dart';

import 'Screens/Priorities/prioritiesHome.dart';
import 'global.dart';

class AppRouter extends StatelessWidget {
  const AppRouter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: (settings) {
        if (settings.name == IndividualPriority.routeName) {
          return PageRouteBuilder(
            settings: settings,
            transitionDuration: const Duration(milliseconds: 250),
            pageBuilder: (context, animation, secondaryAnimation) =>
                const IndividualPriority(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    FadeTransition(opacity: animation, child: child),
          );
        }
      },

      //(settings) => PageRouteBuilder(pageBuilder: (context) => routes[settings.name](context), settings: settings, transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(opacity: animation1, child: child),),
      // onGenerateRoute: ((settings) {
      //   switch (settings.name) {
      //     case IndividualPriority.routeName:
      //       final args = settings.arguments as IndividualPriorityArgumentScreen;
      //       return MaterialPageRoute(
      //         builder: (context) {
      //           return IndividualPriorityArgumentScreen(args.index);
      //         },
      //       );
      //     // PageTransition(
      //     //     child: const IndividualPriority(),
      //     //     type: PageTransitionType.bottomToTop,
      //     //     settings: settings);
      //     case IndividualGoal.routeName:
      //       return PageTransition(
      //           child: const IndividualGoal(),
      //           type: PageTransitionType.bottomToTop,
      //           settings: settings);
      //     default:
      //       return null;
      //   }
      // }),
      debugShowCheckedModeBanner: false,
      title: 'Goals App',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      themeMode: ThemeMode.light,
      //darkTheme: ThemeData.dark(),
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
        '/priority-home': (context) => PriorityHomeScreen(),
        '/new-priority': (context) => NewPriorityScreen(),

        OptionsScreen.routeName: ((context) => OptionsScreen()),

        //Priorities
        // IndividualPriority.routeName: (context) => const IndividualPriority(),
        NewGoalScreen.routeName: ((context) => NewGoalScreen()),
        BrowseImagesScreen.routeName: (context) => BrowseImagesScreen(),

        //Goals
        IndividualGoal.routeName: ((context) => IndividualGoal()),
      },
    );
  }
}
