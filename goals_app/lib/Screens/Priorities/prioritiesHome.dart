import 'package:flutter/material.dart';
import 'package:goals_app/Objects/Priority.dart';
import 'package:goals_app/Screens/ArgumentPassThroughScreens/priorityHomeArguments.dart';
import 'package:goals_app/Screens/Priorities/individualPriority.dart';
import 'package:goals_app/Screens/Priorities/reorderScreen.dart';
import 'package:goals_app/Widgets/Priorities/priorityCarousel.dart';
import '../../Objects/CardLabel.dart';
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
  List<CardLabel> labels = List.empty(growable: true);
  List<Priority> priorities = List.empty(growable: true);
  bool isEdit = false;

  @override
  void initState() {
    setCarouselInfo();

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

  void setCarouselInfo() {
    //THIS SHOULD LATER BE ASYNC
    //AND DONE ONLY ONCE
    //PROBABLY IN A DIFFERENT FILE
    //LIKE A SPLASH SCREEN
    Global.getPriorities();
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

  Widget getCurrentWidgetContent(int currentDisplayIndex) {
    if (isEdit) {
      return ReorderScreen(saveAndDelete);
    } else {
      return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(
              (isEdit) ? "Reorder Priorities" : "Priorities",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
            actions: <Widget>[
              IconButton(
                onPressed: () => {
                  setState(() {
                    isEdit = !isEdit;
                  })
                },
                icon: const Icon(
                  Icons.edit,
                ),
              ),
            ]),
        body: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Container(
            color: Colors.transparent,
            height: MediaQuery.of(context).size.height * 0.8,
            child: Column(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 36.0),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: PriorityCarousel(currentDisplayIndex),
                  ),
                ),
              ],
            ),
          ),
        ]),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as PriorityHomeArguments;
    return getCurrentWidgetContent(args.currentIndex);
  }
}
