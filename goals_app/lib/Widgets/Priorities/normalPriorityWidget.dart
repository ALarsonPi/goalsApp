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
  List<Goal> goals;
  NormalPriorityWidget(this.currentPriorityIndex, this.goals, {Key? key});
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
        this.isGridMode = true;
      } else {
        this.isGridMode = false;
      }
    });
  }

  getCurrentListGridView() {
    return (isGridMode)
        ? GridView.count(
            crossAxisCount: 2,
            children: [
              ...myGoalButtons,
            ],
          )
        : ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.all(0.0),
            children: [
              ...myGoalButtons,
            ],
          );
  }

  @override
  Widget build(BuildContext context) {
    myGoalButtons.clear();
    for (var goal in widget.goals) {
      myGoalButtons.add(GoalButton(goal, isGridMode));
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0, top: 8.0),
          child: Center(
            child: Text(Global.userPriorities[widget.currentPriorityIndex].name,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          child: Divider(thickness: 1, color: Colors.grey),
        ),
        SizedBox(
          height: 30,
          child: GridListIconRow(setGoalButtonSize, IconsEnum.priorityButtons),
        ),
        Expanded(
          child: getCurrentListGridView(),
        ),
      ],
    );
  }
}
