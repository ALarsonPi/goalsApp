import 'package:flutter/material.dart';
import '../../Objects/Goal.dart';
import '../../Objects/IconsEnum.dart';
import '../../global.dart';
import '../Priorities/gridListIconRow.dart';

class GoalProgressWidget extends StatefulWidget {
  String currentAmount;
  String goalAmount;
  Function updateGoal;
  Function changeButtonSize;
  Goal currGoal;
  GoalProgressWidget(this.currentAmount, this.goalAmount, this.updateGoal,
      this.changeButtonSize, this.currGoal);

  @override
  State<StatefulWidget> createState() {
    return _GoalProgressWidget();
  }
}

class _GoalProgressWidget extends State<GoalProgressWidget> {
  int currentProgress = 0;
  bool hasSubGoals = false;
  int numSubGoalsComplete = 0;

  @override
  void initState() {
    currentProgress = int.parse(widget.currentAmount);
    hasSubGoals = widget.currGoal.subGoals.isNotEmpty;

    //if we have subgoals, check them and count how many completed
    if (hasSubGoals) {
      for (Goal currSubGoal in widget.currGoal.subGoals) {
        if (currSubGoal.goalProgress == currSubGoal.goalTarget) {
          numSubGoalsComplete++;
        }
      }
    }

    super.initState();
  }

  getFinishedCheckmark() {
    return Padding(
      padding: const EdgeInsets.only(right: 20.0),
      child: Column(children: const [
        Icon(Icons.check, size: 45, color: Colors.greenAccent),
        Text(
          "Finished",
          style: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey),
        )
      ]),
    );
  }

  setGoalButtonSize(bool isGridMode) {
    widget.changeButtonSize(isGridMode);
  }

  @override
  Widget build(BuildContext context) {
    String currentNumToDisplay = (hasSubGoals)
        ? numSubGoalsComplete.toString()
        : currentProgress.toString();
    String goalNumToDisplay = (hasSubGoals)
        ? widget.currGoal.subGoals.length.toString()
        : widget.goalAmount.toString();

    if (hasSubGoals) {
      widget.currGoal.goalProgress = currentNumToDisplay;
      widget.currGoal.goalTarget = goalNumToDisplay;
    }

    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, right: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: ListTile(
              leading: const Icon(Icons.flag),
              title: Text(
                (!hasSubGoals) ? "Progress:" : "Subgoals",
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              subtitle: Text(
                "Current: $currentNumToDisplay\nGoal: $goalNumToDisplay",
              ),
            ),
          ),
          Visibility(
            visible: hasSubGoals &&
                numSubGoalsComplete != widget.currGoal.subGoals.length,
            child: SizedBox(
              height: 30,
              width: 100,
              child:
                  GridListIconRow(setGoalButtonSize, IconsEnum.priorityButtons),
            ),
          ),
          if (!hasSubGoals)
            Padding(
              padding: const EdgeInsets.only(
                  top: 8.0, left: 12.0, right: 12.0, bottom: 8.0),
              child: Stack(
                children: [
                  (currentProgress < int.parse(widget.goalAmount))
                      ? ButtonTheme(
                          height: 1,
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          child: TextButton(
                            onPressed: () => {
                              setState(() {
                                currentProgress++;
                                widget.updateGoal(currentProgress.toString());
                              }),
                            },
                            child: const Text(
                              "+",
                              style: TextStyle(height: 1, fontSize: 48),
                            ),
                          ),
                        )
                      : getFinishedCheckmark(),
                ],
              ),
            ),
          if (hasSubGoals && currentNumToDisplay == goalNumToDisplay)
            getFinishedCheckmark(),
        ],
      ),
    );
  }
}
