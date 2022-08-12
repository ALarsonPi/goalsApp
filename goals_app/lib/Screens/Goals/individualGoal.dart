import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:goals_app/Screens/ArgumentPassThroughScreens/individualGoalArguments.dart';
import 'package:goals_app/Screens/ArgumentPassThroughScreens/individualPriorityArgumentScreen.dart';
import 'package:goals_app/Screens/Priorities/individualPriority.dart';
import 'package:goals_app/Widgets/Goals/goalProgressWidget.dart';
import 'package:goals_app/Widgets/Priorities/normalPriorityWidget.dart';

import '../../Objects/Goal.dart';
import '../../Widgets/Goals/goalButton.dart';
import '../../global.dart';
import '../ArgumentPassThroughScreens/newGoalArguements.dart';
import 'newGoalScreen.dart';

class IndividualGoal extends StatefulWidget {
  static const routeName = "/extractCurrentGoal";

  const IndividualGoal({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _IndividualGoal();
  }
}

class _IndividualGoal extends State<IndividualGoal> {
  late final args =
      ModalRoute.of(context)!.settings.arguments as IndividualGoalArguments;

  var titles = ['Trying to finish by: ', 'Remember...', 'When', 'Where'];
  var icons = [
    const Icon(Icons.watch_later),
    const Icon(Icons.info),
    const Icon(Icons.watch),
    const Icon(Icons.where_to_vote_outlined),
  ];

  //Will be defined in Build
  var content = [];

  removeNullFields() {
    List toRemove = List.empty(growable: true);
    for (var currentField in content) {
      if (currentField == "null") {
        int indexToRemove = content.indexOf(currentField);
        toRemove.add(indexToRemove);
      }
    }
    for (var valueToRemove in toRemove) {
      content.removeAt(valueToRemove);
      titles.removeAt(valueToRemove);
      icons.removeAt(valueToRemove);
    }
  }

  List fillListViewWithOptionalFields() {
    List<ListTile> thingsToAdd = List.empty(growable: true);
    for (int i = 0; i < content.length; i++) {
      thingsToAdd.add(ListTile(
        leading: icons[i],
        title: Text(titles[i],
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
        subtitle: Text(
          content[i],
          // style: const TextStyle(
          //     fontWeight: FontWeight.normal, fontSize: 16),
        ),
      ));
    }
    return thingsToAdd;
  }

  updateGoalGlobally(String newValue) {
    if (!args.currGoal.isChildGoal) {
      int currentGoalIndex = Global.userPriorities[args.currPriorityIndex].goals
          .indexOf(args.currGoal);
      Global.userPriorities[args.currPriorityIndex].goals[currentGoalIndex]
          .goalProgress = newValue;
    } else {
      args.currGoal.goalProgress = newValue;
    }
  }

  navigateBackArrow() {
    if (!args.currGoal.isChildGoal) {
      Navigator.pushNamed(context, IndividualPriority.routeName,
          arguments: IndividualPriorityArgumentScreen(args.currPriorityIndex));
    } else {
      Global.depthStack.pop();
      Goal currParentGoal = Global.depthStack.top;
      Navigator.pushNamed(context, IndividualGoal.routeName,
          arguments:
              IndividualGoalArguments(currParentGoal, args.currPriorityIndex));
    }
  }

  List getSubgoalsButtons() {
    List<GoalButton> currGoalsButtons = List.empty(growable: true);
    for (Goal goal in args.currGoal.subGoals) {
      currGoalsButtons.add(GoalButton(goal, true, args.currPriorityIndex));
    }
    return currGoalsButtons;
  }

  @override
  Widget build(BuildContext context) {
    content = [
      args.currGoal.completeByDate ?? "null",
      args.currGoal.whyToComplete ?? "null",
      args.currGoal.whenToComplete ?? "null",
      args.currGoal.whereToComplete ?? "null",
    ];
    removeNullFields();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () => {
                Navigator.pushNamed(
                  context,
                  NewGoalScreen.routeName,
                  arguments: NewGoalArguments(args.currPriorityIndex, false,
                      currentGoal: args.currGoal),
                ),
              }),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => navigateBackArrow(),
        ),
        centerTitle: true,
        title: const Text(
          "Goal",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Column(
                  children: [
                    //Container with Priority name and Goal name
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 15.0, left: 15.0, right: 15.0, bottom: 4.0),
                      child: Card(
                        elevation: 3,
                        borderOnForeground: true,
                        color: const Color.fromARGB(184, 242, 242, 242),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            title: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Goal - ${args.currGoal.name}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                )),
                            subtitle: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Priority - ${Global.userPriorities[args.currPriorityIndex].name}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      fontStyle: FontStyle.italic),
                                )),
                          ),
                        ),
                      ),
                    ),
                    //Container with Progress / completion
                    Padding(
                      padding: const EdgeInsets.only(left: 0.0, right: 8.0),
                      child: GoalProgressWidget(args.currGoal.goalProgress,
                          args.currGoal.goalTarget, updateGoalGlobally),
                    ),
                    //Additional optional fields
                    if (content.isNotEmpty) ...fillListViewWithOptionalFields(),
                  ],
                );
              },
              childCount: 1, // 1000 list items
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: true,
            child: Column(
              children: <Widget>[
                // Expanded(child: Container(color: Colors.red)),
                Expanded(
                  child: NormalPriorityWidget(
                    args.currPriorityIndex,
                    false,
                    args.currGoal.subGoals,
                    currentGoal: args.currGoal,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
