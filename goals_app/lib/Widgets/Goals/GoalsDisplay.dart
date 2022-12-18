import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:goals_app/Providers/PriorityProvider.dart';
import 'package:goals_app/Widgets/Goals/CustomInput.dart';
import 'package:provider/provider.dart';

import '../../Models/Goal.dart';
import '../../Models/Priority.dart';
import '../../Settings/global.dart';

class GoalsDisplay extends StatefulWidget {
  Priority currPriority;
  GoalsDisplay(this.currPriority, {super.key});

  @override
  State<StatefulWidget> createState() {
    return _GoalsDisplay();
  }
}

class _GoalsDisplay extends State<GoalsDisplay> {
  List<bool> isExpanded = List.empty(growable: true);

  @override
  void initState() {
    for (int i = 0; i < widget.currPriority.goals.length; i++) {
      isExpanded.add(false);
    }
    super.initState();
  }

  getTrailingArrow(int index, priorityOrGoal) {
    List listOfSubGoals = List.empty(growable: true);
    if (priorityOrGoal is Priority) {
      listOfSubGoals = priorityOrGoal.goals;
    } else if (priorityOrGoal is Goal) {
      listOfSubGoals = priorityOrGoal.subGoals;
    }
    if (listOfSubGoals.isNotEmpty) {
      return (isExpanded[index])
          ? const Icon(Icons.arrow_drop_down_circle)
          : const Icon(Icons.arrow_drop_down);
    } else {
      return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return (widget.currPriority.goals.isEmpty)
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // shrinkWrap: true,
            children: [
              const Padding(
                padding: EdgeInsets.only(
                  top: 0.0,
                  left: 18.0,
                ),
                child: Text(
                  "What would you like to do?",
                  textAlign: TextAlign.start,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 12.0,
                  left: 12.0,
                  bottom: 0,
                  right: 12.0,
                ),
                child: CustomInput(
                  controller: Global.textWatcher,
                  inputBorder: const OutlineInputBorder(),
                  label: "Description",
                ),
              ),
              Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: ElevatedButton(
                          onPressed: () => {
                                debugPrint(
                                    "HEY" + Global.textWatcher.value.text),
                                Provider.of<PriorityProvider>(context,
                                        listen: false)
                                    .addGoalToPriority(
                                        widget.currPriority,
                                        Goal(Global.textWatcher.value.text, 0,
                                            "", "", "", "", true)),
                              },
                          child: const Text("Create"))))
            ],
          )
        : ListView(
            shrinkWrap: true,
            children: [
              for (int i = 0; i < widget.currPriority.goals.length; i++)
                ExpansionTile(
                  initiallyExpanded: (mounted && isExpanded[i]),
                  trailing: getTrailingArrow(i, widget.currPriority.goals[i]),
                  leading: GestureDetector(
                    child: Text("HI"),
                  ),
                  onExpansionChanged: (bool expanding) => {
                    setState(() {
                      isExpanded[i] = !isExpanded[i];
                    }),
                  },
                  title: Text(
                    "Hi",
                    style: (Global.isPhone)
                        ? Theme.of(context).textTheme.displaySmall
                        : Theme.of(context).textTheme.displayMedium,
                  ),
                  children: <Widget>[
                    Column(
                      children: [
                        Text("THING"),
                        // ..._getExpandableContent(listToUse[i]),
                      ],
                    )
                  ],
                ),
            ],
          );
  }
}
