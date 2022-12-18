import 'package:flutter/material.dart';

import '../../Models/Goal.dart';

class GoalSliver extends StatefulWidget {
  Goal currGoal;
  GoalSliver(this.currGoal, {super.key});

  @override
  State<StatefulWidget> createState() {
    return _GoalSliver();
  }
}

class _GoalSliver extends State<GoalSliver> {
  bool checkboxValue = false;

  @override
  void initState() {
    super.initState();
    checkboxValue = widget.currGoal.isComplete;
  }

  clickCheckBox(bool value) {
    setState(() {
      widget.currGoal.isComplete = value;
      checkboxValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.04,
      child: Row(
        children: [
          Checkbox(
            value: checkboxValue,
            onChanged: ((value) => {
                  clickCheckBox(value as bool),
                }),
          ),
          Text(widget.currGoal.name),
        ],
      ),
    );
  }
}
