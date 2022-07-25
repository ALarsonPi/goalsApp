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
        Container(
          height: 30,
          child: Row(
            children: [
              Text("data"),
              Text("I also data"),
            ],
          ),
        ),
        Flexible(
            child: ListView(
          //physics: const ClampingScrollPhysics(),
          shrinkWrap: true,
          children: const [
            Text("buttons"),
          ],
        )),
      ],
    );
  }
}
