import 'package:flutter/material.dart';

class GoalSliver extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _GoalSliver();
  }
}

class _GoalSliver extends State<GoalSliver> {
  bool checkboxValue = false;

  clickCheckBox(bool value) {
    setState(() {
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
                  })),
          Text("HI"),
          Text("HELLO THERE"),
        ],
      ),
    );
  }
}
