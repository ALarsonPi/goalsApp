import 'package:flutter/material.dart';

class GoalsList extends StatefulWidget {
  int currentPriorityIndex;
  GoalsList(this.currentPriorityIndex, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _GoalsList();
  }
}

class _GoalsList extends State<GoalsList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text("data"),
            Text("I also data"),
          ],
        ),
        Expanded(
            child: ListView(
          children: const [
            Text("buttons"),
          ],
        )),
      ],
    );
  }
}
