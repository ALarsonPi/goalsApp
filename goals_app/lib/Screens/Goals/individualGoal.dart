import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:goals_app/Screens/ArgumentPassThroughScreens/individualGoalArguments.dart';
import 'package:goals_app/Screens/ArgumentPassThroughScreens/individualPriorityArgumentScreen.dart';
import 'package:goals_app/Screens/Priorities/individualPriority.dart';
import 'package:goals_app/Widgets/Goals/goalProgressWidget.dart';
import 'package:goals_app/Widgets/Priorities/normalPriorityWidget.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

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
  List<GoalDisplayItem> attributesToDisplayForThisGoal =
      List.empty(growable: true);

  late GoalDisplayItem finishByDate;
  late GoalDisplayItem why;
  late GoalDisplayItem when;
  late GoalDisplayItem where;

  @override
  void initState() {
    super.initState();
  }

  List fillListViewWithOptionalFields() {
    finishByDate = GoalDisplayItem(
      const Icon(Icons.watch_later),
      'Trying to finish by: ',
      args.currGoal.completeByDate ?? "null",
    );
    why = GoalDisplayItem(
      const Icon(Icons.info),
      'Remember...',
      args.currGoal.whyToComplete ?? "null",
    );
    when = GoalDisplayItem(
      const Icon(Icons.watch),
      'When',
      args.currGoal.whenToComplete ?? "null",
    );
    where = GoalDisplayItem(
      const Icon(Icons.where_to_vote_outlined),
      'Where',
      args.currGoal.whereToComplete ?? "null",
    );

    attributesToDisplayForThisGoal.clear();
    if (finishByDate.content != "null") {
      attributesToDisplayForThisGoal.add(finishByDate);
    }
    if (why.content != "null") {
      attributesToDisplayForThisGoal.add(why);
    }
    if (when.content != "null") {
      attributesToDisplayForThisGoal.add(when);
    }
    if (where.content != "null") {
      attributesToDisplayForThisGoal.add(where);
    }

    List<ListTile> thingsToAdd = List.empty(growable: true);
    for (int i = 0; i < attributesToDisplayForThisGoal.length; i++) {
      thingsToAdd.add(ListTile(
        leading: attributesToDisplayForThisGoal[i].icon,
        title: Text(attributesToDisplayForThisGoal[i].title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
        subtitle: Text(
          attributesToDisplayForThisGoal[i].content,
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
      currGoalsButtons.add(GoalButton(
          goal, Global.goalButtonsInGridView, args.currPriorityIndex));
    }
    return currGoalsButtons;
  }

  setGoalButtonSize(bool isGridMode) {
    setState(() {
      if (isGridMode) {
        Global.goalButtonsInGridView = true;
      } else {
        Global.goalButtonsInGridView = false;
      }
    });
  }

  checkIfAlertIsNeeded() {
    if (int.parse(args.currGoal.goalProgress) == 0) {
      goToNewGoalScreen();
    } else {
      Alert(
        context: context,
        type: AlertType.warning,
        title: "NEW GOAL ALERT",
        desc: "Making a sub-goal will reset progress on current goal.",
        buttons: [
          DialogButton(
            onPressed: () => {
              Navigator.of(context, rootNavigator: true).pop(),
            },
            gradient: const LinearGradient(colors: [
              Color.fromRGBO(116, 116, 191, 1.0),
              Color.fromRGBO(52, 138, 199, 1.0)
            ]),
            child: const Text(
              "Cancel",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          DialogButton(
            onPressed: () => {
              Navigator.of(context, rootNavigator: true).pop(),
              goToNewGoalScreen(),
            },
            gradient: const LinearGradient(colors: [
              Color.fromRGBO(116, 116, 191, 1.0),
              Color.fromRGBO(52, 138, 199, 1.0)
            ]),
            child: const Text(
              "OK",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ],
      ).show();
    }
  }

  goToNewGoalScreen() {
    Navigator.pushNamed(
      context,
      NewGoalScreen.routeName,
      arguments: NewGoalArguments(args.currPriorityIndex, false,
          currentGoal: args.currGoal),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () => {
                checkIfAlertIsNeeded(),
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
                      padding: EdgeInsets.only(
                          left: (args.currGoal.subGoals.isEmpty) ? 0.0 : 16.0,
                          right: 8.0),
                      child: GoalProgressWidget(
                          args.currGoal.goalProgress,
                          args.currGoal.goalTarget,
                          updateGoalGlobally,
                          setGoalButtonSize,
                          args.currGoal),
                    ),
                    //Additional optional fields
                    if (args.currGoal.subGoals.isEmpty)
                      ...fillListViewWithOptionalFields(),
                  ],
                );
              },
              childCount: 1,
            ),
          ),
          if (args.currGoal.subGoals.isNotEmpty)
            SliverFillRemaining(
              hasScrollBody: true,
              child: Column(
                children: <Widget>[
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

class GoalDisplayItem {
  GoalDisplayItem(this.icon, this.title, this.content);
  Icon icon;
  String title;
  String content;
}
