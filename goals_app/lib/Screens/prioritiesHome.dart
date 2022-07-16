import 'package:flutter/material.dart';
import 'package:goals_app/Objects/Priority.dart';
import 'package:goals_app/Widgets/priorityCarousel.dart';
import '../Objects/CardLabel.dart';
import '../global.dart';
import '../Widgets/myPageView.dart';
import 'reorderPriorities.dart';

class PriorityHomeScreen extends StatefulWidget {
  PriorityHomeScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _PriorityHomeScreen();
  }
}

class _PriorityHomeScreen extends State<PriorityHomeScreen> {
  List<String> urls = List.empty(growable: true);
  List<CardLabel> labels = List.empty(growable: true);
  List<Priority> priorities = List.empty(growable: true);

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

  @override
  Widget build(BuildContext context) {
    int i = 1;
    for (Priority currentPriority in priorities) {
      urls.add(currentPriority.imageUrl);
      CardLabel currentLabel = CardLabel("Priority $i", currentPriority.name);
      i++;
      labels.add(currentLabel);
    }
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(
            "Priorities",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
          ),
          actions: <Widget>[
            IconButton(
              onPressed: () => {
                Navigator.pushNamed(context, '/reorder-priorities'),
              },
              icon: const Icon(
                Icons.edit,
              ),
            ),
          ]),
      body: Column(
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 36.0),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.6,
              //height: MediaQuery.of(context).size.height * 0.75,

              //PAGE VIEW OPTION
              //child: MyPageView(1.0),

              //CAROUSEL OPTION
              child: const PriorityCarousel(),

              //child: FullCarousel(urls, true, false, labels),
            ),
          ),
          const Text("sup"),
        ],
      ),
    );
  }
}
