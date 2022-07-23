import 'package:flutter/material.dart';
import 'package:goals_app/Screens/browseImages.dart';
import 'package:goals_app/Screens/Priorities/editPriority.dart';
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
          '/': (context) => PriorityHomeScreen(),
          '/reorder-priorities': (context) => ReorderPrioritiesScreen(),
          EditPriorityScreen.routeName: (context) => EditPriorityScreen(),
          BrowseImagesScreen.routeName: (context) => BrowseImagesScreen(),
        });
  }
}
