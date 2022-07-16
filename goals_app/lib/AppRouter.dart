import 'package:flutter/material.dart';
import 'package:goals_app/Screens/editPriority.dart';
import 'package:goals_app/Screens/editPriotitiesArguments.dart';
import 'package:goals_app/Screens/reorderPriorities.dart';

import 'Objects/Priority.dart';
import 'Screens/prioritiesHome.dart';

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
          '/': (context) => PriorityHomeScreen(),
          '/reorder-priorities': (context) => ReorderPrioritiesScreen(),
          EditPriorityScreen.routeName: (context) => EditPriorityScreen(),
          //'/edit-priority' : (context) => Priority currentPriority, int currentIndex) => EditPictureScreen(currentPriority, currentIndex)
        });
  }
}
