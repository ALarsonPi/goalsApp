import 'package:flutter/material.dart';
import 'package:goals_app/Widgets/Goals/goalButton.dart';
import 'package:goals_app/Widgets/Priorities/gridListIconRow.dart';
import '../Objects/Goal.dart';

class GoalsList extends StatefulWidget {
  int currentPriorityIndex;
  List<Goal> goals;
  GoalsList(this.currentPriorityIndex, this.goals, {Key? key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _GoalsList();
  }
}

class _GoalsList extends State<GoalsList> {
  List<GoalButton> myGoalButtons = List.empty(growable: true);
  @override
  void initState() {
    for (var goal in widget.goals) {
      myGoalButtons.add(GoalButton(goal, false));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...myGoalButtons,
      ],
    );
  }
}
