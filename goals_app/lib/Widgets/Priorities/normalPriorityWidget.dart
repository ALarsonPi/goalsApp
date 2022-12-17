import 'package:flutter/material.dart';
import 'package:goals_app/Models/Goal.dart';
import 'package:goals_app/Models/IconsEnum.dart';
import 'package:goals_app/Widgets/Priorities/noGoalsPrompt.dart';

import '../../Settings/global.dart';
import 'gridListIconRow.dart';

class NormalPriorityWidget extends StatefulWidget {
  int currentPriorityIndex;
  bool isPriority;
  bool isComingFromListView;
  late Goal currGoal;
  List<Goal>? goals;
  NormalPriorityWidget(this.currentPriorityIndex, this.isPriority, this.goals,
      this.isComingFromListView,
      {Goal? currentGoal, Key? key})
      : super(key: key) {
    if (currentGoal != null) {
      currGoal = currentGoal;
    }
  }
  @override
  State<StatefulWidget> createState() {
    return _NormalPriorityWidget();
  }
}

class _NormalPriorityWidget extends State<NormalPriorityWidget> {
  bool isGridMode = false;

  @override
  Widget build(BuildContext context) {
    int numSubGoalsCompleted = 0;
    if (widget.goals != null) {
      int? numGoals = widget.goals?.length;
      Goal? currGoalThing;
      for (int i = 0; i < numGoals!; i++) {
        currGoalThing = widget.goals?.elementAt(i);
        if (currGoalThing!.goalProgress == currGoalThing.goalTarget) {
          numSubGoalsCompleted++;
        }
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (widget.isPriority)
          Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 8.0),
            child: Center(
              child: Text(
                Global.userPriorities[widget.currentPriorityIndex].name,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
          ),
        if (widget.isPriority)
          const Padding(
            padding: EdgeInsets.only(left: 24.0, right: 24.0),
            child: Divider(thickness: 1, color: Colors.grey),
          ),
        Expanded(
          child: Text("Where buttons would be"),
        ),
      ],
    );
  }
}
