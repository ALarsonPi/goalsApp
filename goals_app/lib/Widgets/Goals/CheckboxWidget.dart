import 'dart:ffi';

import 'package:flutter/material.dart';

import '../../Models/Goal.dart';
import '../../Screens/ArgumentPassThroughScreens/individualGoalArguments.dart';
import '../../Settings/global.dart';

class CheckBoxWidget extends StatefulWidget {
  Goal currGoal;
  CheckBoxWidget(this.currGoal, {super.key});

  @override
  State<StatefulWidget> createState() {
    return _CheckBoxWidget();
  }
}

class _CheckBoxWidget extends State<CheckBoxWidget> {
  late bool currCheckedValue = widget.currGoal.goalProgress == "1";

  updateParent() {
    Global.correctPriorityProgressInTree(
        widget.currGoal.currPriorityIndex, true);

    // Navigator.pushNamed(
    //   context,
    //   IndividualGoal.routeName,
    //   arguments: IndividualGoalArguments(
    //       Global.depthStack.top,
    //       Global.depthStack.top.currPriorityIndex,
    //       Global.depthStack.top.isChildGoal),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: currCheckedValue,
      onChanged: (value) => {
        setState(() {
          widget.currGoal.goalProgress = (value as bool) ? "1" : "0";
          currCheckedValue = value as bool;
        }),
        updateParent(),
      },
    );
  }
}
