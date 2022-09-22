import 'package:flutter/material.dart';
import 'package:goals_app/Screens/ArgumentPassThroughScreens/individualPriorityArgumentScreen.dart';
import 'package:goals_app/Screens/Goals/individualGoal.dart';
import 'package:goals_app/Screens/Goals/newGoalScreen.dart';
import 'package:goals_app/Screens/Priorities/newPriority.dart';
import 'package:goals_app/Screens/Priorities/individualPriority.dart';
import 'package:goals_app/Screens/browseImages.dart';
import 'package:goals_app/Settings/settingsScreen.dart';
import 'package:goals_app/Screens/splashScreen.dart';
import 'package:goals_app/Screens/ArgumentPassThroughScreens/editPriotitiesArguments.dart';
import 'package:goals_app/Settings/ThemeProvider.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import 'Screens/Priorities/prioritiesHome.dart';
import 'Settings/AppColors.dart';
import 'global.dart';

class AppRouter extends StatelessWidget {
  const AppRouter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(),
        )
      ],
      child: Consumer<ThemeProvider>(
        child: const IndividualPriority(),
        builder: (c, themeProvider, child) {
          return MaterialApp(
            themeMode: Global.globalThemeProvider.selectedThemeMode,
            theme: ThemeData(
              brightness: Brightness.light,
              primarySwatch: AppColors.getMaterialColorFromColor(
                  Global.globalThemeProvider.selectedPrimaryColor),
              primaryColor: Global.globalThemeProvider.selectedPrimaryColor,
            ),
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              primarySwatch: AppColors.getMaterialColorFromColor(
                  Global.globalThemeProvider.selectedPrimaryColor),
              primaryColor: Global.globalThemeProvider.selectedPrimaryColor,
            ),
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
            debugShowCheckedModeBanner: false,
            title: 'Goals App',
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

              SettingsScreen.routeName: ((context) => SettingsScreen()),

              //Priorities
              // Individual Priority is Faded onGenerateRoute above
              NewGoalScreen.routeName: ((context) => NewGoalScreen()),
              BrowseImagesScreen.routeName: (context) => BrowseImagesScreen(),

              //Goals
              IndividualGoal.routeName: ((context) => IndividualGoal()),
            },
          );
        },
      ),
    );
  }
}
