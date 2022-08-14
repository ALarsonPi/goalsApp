import 'package:flutter/material.dart';
import 'package:goals_app/Objects/Goal.dart';
import 'package:goals_app/Objects/IconsEnum.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../Screens/ArgumentPassThroughScreens/browseImageArguments.dart';
import '../../Screens/browseImages.dart';
import '../../global.dart';
import '../Goals/goalButton.dart';
import '../../Unused/goalsList.dart';
import 'gridListIconRow.dart';

class NormalPriorityWidget extends StatefulWidget {
  int currentPriorityIndex;
  bool isPriority;
  late Goal currGoal;
  List<Goal>? goals;
  NormalPriorityWidget(this.currentPriorityIndex, this.isPriority, this.goals,
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
  List<GoalButton> myGoalButtons = List.empty(growable: true);

  @override
  void initState() {
    super.initState();
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

  getCurrentListGridView() {
    var physicsType = (widget.isPriority)
        ? const AlwaysScrollableScrollPhysics()
        : const NeverScrollableScrollPhysics();
    return (Global.goalButtonsInGridView)
        ? GridView.count(
            physics: physicsType,
            crossAxisCount: 2,
            children: [
              ...myGoalButtons,
            ],
          )
        : ListView(
            shrinkWrap: true,
            physics: physicsType,
            padding: const EdgeInsets.all(0.0),
            children: [
              ...myGoalButtons,
            ],
          );
  }

  @override
  Widget build(BuildContext context) {
    myGoalButtons.clear();
    int numSubGoalsCompleted = 0;
    if (widget.goals != null) {
      int? numGoals = widget.goals?.length;
      Goal? currGoalThing;
      for (int i = 0; i < numGoals!; i++) {
        currGoalThing = widget.goals?.elementAt(i);
        if (currGoalThing!.goalProgress == currGoalThing.goalTarget) {
          numSubGoalsCompleted++;
        }
        myGoalButtons.add(GoalButton(currGoalThing!,
            Global.goalButtonsInGridView, widget.currentPriorityIndex));
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
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold)),
            ),
          ),
        if (widget.isPriority)
          const Padding(
            padding: EdgeInsets.only(left: 24.0, right: 24.0),
            child: Divider(thickness: 1, color: Colors.grey),
          ),
        if (widget.isPriority ||
            (!widget.isPriority &&
                widget.currGoal.subGoals.length == numSubGoalsCompleted))
          SizedBox(
            height: 30,
            child:
                GridListIconRow(setGoalButtonSize, IconsEnum.priorityButtons),
          ),
        Expanded(
          child: getCurrentListGridView(),
        ),
      ],
    );
  }
}
