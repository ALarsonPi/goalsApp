import 'package:flutter/material.dart';
import 'package:goals_app/Objects/IconsEnum.dart';
import 'package:goals_app/Objects/Priority.dart';
import 'package:goals_app/Screens/ArgumentPassThroughScreens/priorityHomeArguments.dart';
import 'package:goals_app/Screens/Priorities/individualPriority.dart';
import 'package:goals_app/Screens/Priorities/reorderScreen.dart';
import 'package:goals_app/Widgets/Priorities/gridListIconRow.dart';
import 'package:goals_app/Widgets/Priorities/priorityCarousel.dart';
import 'package:goals_app/Widgets/Priorities/priorityExpandedList.dart';
import '../../Unused/CardLabel.dart';
import '../../global.dart';

class PriorityHomeScreen extends StatefulWidget {
  PriorityHomeScreen({Key? key}) : super(key: key);

  static const routeName = "/priorityHomeArgs";

  @override
  State<StatefulWidget> createState() {
    return _PriorityHomeScreen();
  }
}

class _PriorityHomeScreen extends State<PriorityHomeScreen> {
  List<String> urls = List.empty(growable: true);
  List<Priority> priorities = List.empty(growable: true);
  bool isEdit = false;
  bool isList = false;

  @override
  void initState() {
    for (Priority priority in Global.userPriorities) {
      priorities.add(priority);
    }
    super.initState();
  }

  @override
  void setState(VoidCallback fn) {
    priorities.clear();
    for (Priority priority in Global.userPriorities) {
      priorities.add(priority);
    }
    super.setState(fn);
  }

  void saveAndDelete(List<Priority> prioritiesToSave) {
    setState(() {
      isEdit = !isEdit;
      Global.userPriorities.clear();
      for (var priority in prioritiesToSave) {
        Global.userPriorities.add(priority);
      }
    });
  }

  setListViewState(bool isList) {
    setState(() {
      this.isList = isList;
    });
  }

  Widget getCurrentWidgetContent(int currentDisplayIndex) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () => {
                Navigator.pushNamed(context, '/new-priority'),
              },
          foregroundColor: Colors.white,
          child: const Icon(Icons.add)),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        bottom: const TabBar(
          tabs: [
            Tab(
              icon: Icon(Icons.account_balance_wallet),
            ),
            Tab(
              icon: Icon(Icons.account_tree),
            ),
            Tab(
              icon: Icon(Icons.edit),
            ),
          ],
        ),
        title: const Text(
          "Priorities",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
      ),
      body: TabBarView(
        children: [
          //Priority Carousel
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child:
              //       GridListIconRow(setListViewState, IconsEnum.priorityHome),
              // ),
              Container(
                color: Colors.transparent,
                height: MediaQuery.of(context).size.height * 0.75,
                child: Column(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 36.0),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.6,
                        child: PriorityCarousel(currentDisplayIndex,
                            getNotificationFromChildOfSlideChange),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          //Priority List
          PriorityExpandedList(priorities),

          //Edit / Reorder List
          ReorderScreen(saveAndDelete),
        ],
      ),
    );
  }

  getNotificationFromChildOfSlideChange(int newSlideIndex) {
    setState(() {
      args.currentIndex = newSlideIndex;
    });
  }

  late final args =
      ModalRoute.of(context)!.settings.arguments as PriorityHomeArguments;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: getCurrentWidgetContent(args.currentIndex),
    );
  }
}
