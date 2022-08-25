import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:goals_app/Screens/ArgumentPassThroughScreens/individualGoalArguments.dart';
import 'package:goals_app/Screens/ArgumentPassThroughScreens/individualPriorityArgumentScreen.dart';
import 'package:goals_app/Screens/ArgumentPassThroughScreens/priorityHomeArguments.dart';
import 'package:goals_app/Screens/Priorities/individualPriority.dart';
import 'package:goals_app/Screens/Priorities/prioritiesHome.dart';
import 'package:goals_app/Widgets/Goals/goalProgressWidget.dart';
import 'package:goals_app/Widgets/Priorities/normalPriorityWidget.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:intl/intl.dart';

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

  late String originalName;
  late GoalDisplayItem finishByDate;
  late GoalDisplayItem why;
  late GoalDisplayItem when;
  late GoalDisplayItem where;

  bool isInEditMode = false;
  int newCurrentAmount = -1;
  int newGoalAmount = -1;
  String newWhy = "";
  String newWhen = "";
  String newWhere = "";

  @override
  void initState() {
    super.initState();
  }

  DateTime? currentDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  DateTime todaysDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  showFlutterDatePicker() async {
    DateTime? newDate = await showDatePicker(
      context: context,
      initialDate: todaysDate,
      firstDate: todaysDate,
      lastDate: DateTime(2100),
    );
    setState(() {
      currentDate = newDate;
      currentDate ??= todaysDate;
      args.currGoal.completeByDate = DateFormat.yMMMEd().format(currentDate!);
    });
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
      'When/Where',
      args.currGoal.whenToComplete ?? "null",
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

    List<ListTile> thingsToAdd = List.empty(growable: true);
    for (int i = 0; i < attributesToDisplayForThisGoal.length; i++) {
      thingsToAdd.add(ListTile(
        leading: attributesToDisplayForThisGoal[i].icon,
        title: Text(
            (attributesToDisplayForThisGoal[i].title == "Remember..." &&
                    isInEditMode)
                ? "Why"
                : attributesToDisplayForThisGoal[i].title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
        subtitle: (attributesToDisplayForThisGoal[i].title ==
                    "Trying to finish by: " &&
                isInEditMode)
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ElevatedButton(
                      onPressed: () => {
                            showFlutterDatePicker(),
                            // setState(() {
                            //   if (showFlutterDatePicker() != null) {
                            //     currentDate = showFlutterDatePicker();
                            //   }
                            // }),
                          },
                      child: const Text("Select Date")),
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: Text(DateFormat.yMMMEd().format(currentDate!),
                        style: const TextStyle(fontStyle: FontStyle.italic)),
                  ),
                ],
              )
            : (!isInEditMode)
                ? Text(
                    attributesToDisplayForThisGoal[i].content,
                    // style: const TextStyle(
                    //     fontWeight: FontWeight.normal, fontSize: 16),
                  )
                : TextField(
                    onChanged: (currValue) => {
                      setState(() {
                        if (currValue != "") {
                          if (attributesToDisplayForThisGoal[i].title ==
                              "Remember...") {
                            args.currGoal.whyToComplete = currValue;
                          } else if (attributesToDisplayForThisGoal[i].title ==
                              "When/Where") {
                            args.currGoal.whenToComplete = currValue;
                          }
                        } else {
                          if (attributesToDisplayForThisGoal[i].title ==
                              "Remember...") {
                            args.currGoal.whyToComplete = originalName;
                          } else if (attributesToDisplayForThisGoal[i].title ==
                              "When/Where") {
                            args.currGoal.whenToComplete = originalName;
                          }
                        }
                      }),
                    },
                    decoration: InputDecoration(
                      hintText: attributesToDisplayForThisGoal[i].content,
                      hintStyle: const TextStyle(fontStyle: FontStyle.italic),
                    ),
                    minLines: 1,
                    maxLines: 3,
                    keyboardType: TextInputType.number,
                  ),
      ));
    }
    return thingsToAdd;
  }

  updateGoalGlobally(String newValue) {
    setState(() {
      args.currGoal.goalProgress = newValue;
    });
  }

  updateGoalTargetGlobally(String newValue) {
    setState(() {
      args.currGoal.goalTarget = newValue;
    });
  }

  navigateHome() {
    Navigator.pushNamed(context, PriorityHomeScreen.routeName,
        arguments: PriorityHomeArguments(args.currPriorityIndex));
    return;
  }

  navigateBackArrow() {
    if (args.comingFromListView) {
      navigateHome();
    }
    if (!args.currGoal.isChildGoal) {
      Navigator.pushNamed(context, IndividualPriority.routeName,
          arguments: IndividualPriorityArgumentScreen(args.currPriorityIndex));
    } else {
      Global.depthStack.pop();
      Goal currParentGoal = Global.depthStack.top;
      Navigator.pushNamed(context, IndividualGoal.routeName,
          arguments: IndividualGoalArguments(
              currParentGoal, args.currPriorityIndex, args.comingFromListView));
    }
  }

  List getSubgoalsButtons() {
    List<GoalButton> currGoalsButtons = List.empty(growable: true);
    for (Goal goal in args.currGoal.subGoals) {
      currGoalsButtons.add(GoalButton(goal, Global.goalButtonsInGridView,
          args.currPriorityIndex, args.comingFromListView));
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
  void didChangeDependencies() {
    originalName = args.currGoal.name;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    args.setComingFromListView(false);
    bool isInTopLevel;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () => {
                checkIfAlertIsNeeded(),
              }),
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: GestureDetector(
              onTap: () => {
                setState(() {
                  isInEditMode = !isInEditMode;
                  if (!isInEditMode) {}
                }),
              },
              child: Icon(
                (!isInEditMode) ? Icons.edit : Icons.save,
                color: (!isInEditMode) ? Colors.white : Colors.yellowAccent,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 24.0),
            child: GestureDetector(
              onTap: () => {
                isInTopLevel =
                    Global.removeGoal(args.currPriorityIndex, args.currGoal),
                if (isInTopLevel)
                  {
                    Navigator.pushNamed(context, IndividualPriority.routeName,
                        arguments: IndividualPriorityArgumentScreen(
                            args.currPriorityIndex)),
                  }
                else
                  {
                    Global.depthStack.pop(),
                    Navigator.pushNamed(
                      context,
                      IndividualGoal.routeName,
                      arguments: IndividualGoalArguments(Global.depthStack.top,
                          args.currPriorityIndex, args.comingFromListView),
                    ),
                  }
              },
              child: const Icon(Icons.delete, size: 22.0, color: Colors.white),
            ),
          ),
        ],
        titleSpacing: 0.0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Visibility(
              visible: !args.comingFromListView,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => navigateBackArrow(),
              ),
            ),
            //before
            Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Padding(
                  padding: (args.comingFromListView)
                      ? const EdgeInsets.only(left: 24.0, right: 48.0)
                      : const EdgeInsets.only(left: 8.0, right: 24.0),
                  child: GestureDetector(
                    child: const Icon(Icons.home),
                    onTap: () => navigateHome(),
                  ),
                ),
              ],
            ),
            const Expanded(
              child: Center(
                child: Text(
                  "Goal",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
              ),
            ),
            //after
          ],
        ),
      ),
      body: CustomScrollView(
        shrinkWrap: false,
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
                        color: (args.currGoal.goalProgress !=
                                args.currGoal.goalTarget)
                            ? const Color.fromARGB(184, 242, 242, 242)
                            : Theme.of(context).secondaryHeaderColor,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            title: Align(
                              alignment: Alignment.centerLeft,
                              child: (!isInEditMode)
                                  ? Text(
                                      "Goal - ${args.currGoal.name}",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    )
                                  : TextField(
                                      onChanged: (currValue) => {
                                        setState(() {
                                          if (currValue != "") {
                                            args.currGoal.name = currValue;
                                          } else {
                                            args.currGoal.name = originalName;
                                          }
                                        }),
                                      },
                                      decoration: InputDecoration(
                                        hintText: "Goal: ${args.currGoal.name}",
                                        hintStyle: const TextStyle(
                                            fontStyle: FontStyle.italic),
                                      ),
                                      minLines: 1,
                                      maxLines: 3,
                                      keyboardType: TextInputType.number,
                                    ),
                            ),
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
                          args.currGoal,
                          isInEditMode,
                          updateGoalTargetGlobally),
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
                      args.comingFromListView,
                    ),
                  ),
                ],
              ),
            ),
          if (args.currGoal.goalProgress == '0' &&
              args.currGoal.subGoals.isEmpty)
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return const Text(
                    "Press the '+' at the bottom \nto add a subgoal!",
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                    ),
                    textAlign: TextAlign.center,
                  );
                },
                childCount: 1,
                semanticIndexOffset: 1,
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
