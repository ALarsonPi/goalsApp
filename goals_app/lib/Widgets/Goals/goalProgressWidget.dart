import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../Models/Goal.dart';
import '../../Models/IconsEnum.dart';
import '../../Settings/global.dart';
import '../Priorities/gridListIconRow.dart';

class GoalProgressWidget extends StatefulWidget {
  String currentAmount;
  String goalAmount;
  Function updateGoal;
  Function updateGoalTarget;
  Function changeButtonSize;
  Goal currGoal;
  bool isInEditMode;
  GoalProgressWidget(
      this.currentAmount,
      this.goalAmount,
      this.updateGoal,
      this.changeButtonSize,
      this.currGoal,
      this.isInEditMode,
      this.updateGoalTarget,
      {Key? key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _GoalProgressWidget();
  }
}

class _GoalProgressWidget extends State<GoalProgressWidget> {
  int currentProgress = 0;
  bool hasSubGoals = false;
  int numSubGoalsComplete = 0;

  String currentProgressString = "";
  String currentTargetString = "";

  final _controllerCurrent = TextEditingController();
  final TextEditingController _controllerGoal = TextEditingController();

  @override
  void initState() {
    currentProgressString = widget.currentAmount;
    currentTargetString = widget.currGoal.goalTarget;
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
      child: Column(children: [
        Icon(Icons.check,
            color: Colors.greenAccent, size: (Global.isPhone) ? 48 : 84),
        Text(
          "Finished",
          style: TextStyle(
              fontStyle: FontStyle.italic,
              fontSize: (Global.isPhone) ? 18 : 24,
              color: Colors.grey),
        )
      ]),
    );
  }

  setGoalButtonSize(bool isGridMode) {
    widget.changeButtonSize(isGridMode);
  }

  @override
  Widget build(BuildContext context) {
    currentProgress = int.parse(currentProgressString);

    String currentNumToDisplay = currentProgress.toString();
    String goalNumToDisplay = currentTargetString.toString();

    if (hasSubGoals) {
      widget.currGoal.goalProgress =
          Global.getSumOfChildrenProgress(widget.currGoal).toString();
      widget.currGoal.goalTarget =
          Global.getSumOfChildrenTarget(widget.currGoal).toString();
      currentNumToDisplay = widget.currGoal.goalProgress;
      goalNumToDisplay = widget.currGoal.goalTarget;
    }

    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, right: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: ListTile(
              leading: Icon(Icons.flag, size: (Global.isPhone) ? 35 : 55),
              title: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  "Progress:",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              subtitle: (!widget.isInEditMode ||
                      widget.currGoal.subGoals.isNotEmpty)
                  ? Text(
                      "Current: $currentNumToDisplay\nGoal: $goalNumToDisplay",
                      style: Theme.of(context).textTheme.displaySmall,
                    )
                  : Column(
                      children: [
                        TextField(
                          onChanged: (currValue) => {
                            if (currValue == "")
                              {
                                widget.updateGoal(widget.currentAmount),
                                currentProgressString = widget.currentAmount,
                              }
                            else
                              {
                                widget.updateGoal(currValue),
                                currentProgressString = currValue,
                              }
                          },
                          controller: _controllerCurrent,
                          decoration: InputDecoration(
                            hintText: "Current: ${widget.currentAmount}",
                            hintStyle:
                                const TextStyle(fontStyle: FontStyle.italic),
                          ),
                          minLines: 1,
                          maxLines: 1,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            FilteringTextInputFormatter.allow(
                                RegExp(r'^[0-9][0-9]*')),
                          ], // Only numbers can be entered),
                          maxLengthEnforcement: MaxLengthEnforcement.none,
                        ),
                        TextField(
                          onChanged: (currValue) => {
                            if (currValue == "")
                              {
                                widget.updateGoalTarget(
                                    widget.currGoal.goalTarget),
                                currentTargetString =
                                    widget.currGoal.goalTarget,
                              }
                            else
                              {
                                widget.updateGoalTarget(currValue),
                                currentTargetString = currValue,
                              }
                          },
                          controller: _controllerGoal,
                          decoration: InputDecoration(
                            hintText: "Goal: ${widget.currGoal.goalTarget}",
                            hintStyle:
                                const TextStyle(fontStyle: FontStyle.italic),
                          ),
                          minLines: 1,
                          maxLines: 1,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ], // Only numbers can be entered),
                        ),
                      ],
                    ),
            ),
          ),
          Visibility(
            visible: (!widget.isInEditMode &&
                    hasSubGoals &&
                    numSubGoalsComplete != widget.currGoal.subGoals.length) ||
                widget.currGoal.subGoals.isNotEmpty,
            child: SizedBox(
              height: 30,
              width: 100,
              child:
                  GridListIconRow(setGoalButtonSize, IconsEnum.priorityButtons),
            ),
          ),
          if (!hasSubGoals && !widget.isInEditMode)
            Padding(
              padding: const EdgeInsets.only(
                  top: 8.0, left: 12.0, right: 12.0, bottom: 8.0),
              child: Stack(
                children: [
                  (currentProgress < int.parse(widget.currGoal.goalTarget))
                      ? ButtonTheme(
                          height: 1,
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          child: TextButton(
                            onPressed: () => {
                              setState(() {
                                currentProgress++;
                                currentProgressString =
                                    currentProgress.toString();
                                widget.updateGoal(currentProgress.toString());
                                Global.correctPriorityProgressInTree(
                                    widget.currGoal.currPriorityIndex, true);
                                Global.writePrioritiesToMemory();
                              }),
                            },
                            child: Text(
                              "+",
                              style: TextStyle(
                                  height: 1,
                                  fontSize: (Global.isPhone) ? 48 : 64),
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
