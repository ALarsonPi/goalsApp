import 'package:flutter/material.dart';

import '../../Objects/Goal.dart';
import '../../Objects/Priority.dart';

class PriorityExpandedList extends StatefulWidget {
  List<Priority> priorities = List.empty(growable: true);
  PriorityExpandedList(this.priorities, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _PriorityExpandedList();
  }
}

class _PriorityExpandedList extends State<PriorityExpandedList> {
  _getExpandableContent(var priorityOrGoal) {
    List<Goal> subGoals = List.empty(growable: true);
    if (priorityOrGoal is Priority) {
      Priority currPriority = priorityOrGoal as Priority;
      subGoals = currPriority.goals;
    } else if (priorityOrGoal is Goal) {
      Goal currGoal = priorityOrGoal as Goal;
      subGoals = currGoal.subGoals;
    }

    List<Widget> contentToReturn = List.empty(growable: true);
    for (Goal subGoal in subGoals) {
      contentToReturn.add(
        ListTile(title: Text(subGoal.name)),
      );
    }
    return contentToReturn;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return Card(
              child: ExpansionTile(
            title: Text(widget.priorities[index].name),
            children: <Widget>[
              Column(
                children: [..._getExpandableContent(widget.priorities[index])],
              )
            ],
          ));
        },
        itemCount: widget.priorities.length);
  }
}
