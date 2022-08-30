import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:goals_app/Screens/ArgumentPassThroughScreens/individualGoalArguments.dart';
import 'package:goals_app/Screens/Goals/individualGoal.dart';
import 'package:goals_app/global.dart';
import 'package:path_provider/path_provider.dart';

import '../../Objects/Goal.dart';
import '../../Objects/Priority.dart';

class PriorityExpandedList extends StatefulWidget {
  bool isInEditMode;
  bool isPriority;
  List<Goal>? currSubGoals;
  PriorityExpandedList(this.isInEditMode, this.isPriority,
      {List<Goal>? currSubGoals, Key? key})
      : super(key: key) {
    if (currSubGoals != null) {
      this.currSubGoals = currSubGoals;
    }
  }

  @override
  State<StatefulWidget> createState() {
    return _PriorityExpandedList();
  }
}

class _PriorityExpandedList extends State<PriorityExpandedList> {
  List<bool> isExpanded = List.empty(growable: true);

  @override
  void initState() {
    for (int i = 0; i < Global.userPriorities.length; i++) {
      if (i == Global.priorityLastOpen) {
        isExpanded.add(true);
      } else {
        isExpanded.add(false);
      }
    }
    super.initState();
  }

  _getExpandableContent(var priorityOrGoal) {
    List<Goal> subGoals = List.empty(growable: true);
    if (priorityOrGoal is Priority) {
      Priority currPriority = priorityOrGoal;
      subGoals = currPriority.goals;
    } else if (priorityOrGoal is Goal) {
      Goal currGoal = priorityOrGoal;
      subGoals = currGoal.subGoals;
    }
    List<Widget> contentToReturn = List.empty(growable: true);
    for (Goal subGoal in subGoals) {
      if (subGoal.subGoals.isNotEmpty) {
        var getNewExpandedList = PriorityExpandedList(
          widget.isInEditMode,
          false,
          currSubGoals: [subGoal],
        );
        contentToReturn.add(getNewExpandedList);
      } else {
        contentToReturn.add(
          ListTile(
              onTap: () => {
                    Global.priorityLastOpen = subGoal.currPriorityIndex,
                    navigateToGoal(subGoal),
                  },
              title: Text(
                "Goal: ${subGoal.name}",
                textAlign: TextAlign.left,
                style: TextStyle(color: Theme.of(context).primaryColor),
              )),
        );
      }
    }
    return contentToReturn;
  }

  navigateToGoal(Goal goalToNavTo) {
    Navigator.pushNamed(
      context,
      IndividualGoal.routeName,
      arguments: IndividualGoalArguments(
        goalToNavTo,
        goalToNavTo.currPriorityIndex,
        true,
      ),
    );
  }

  getCircleIconWidget(
      BuildContext context, Widget child, Color borderColor, priorityOrGoal) {
    return (widget.isPriority)
        ? Padding(
            padding: const EdgeInsets.only(right: 6.0),
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                // Circle shape
                shape: BoxShape.circle,
                color: Colors.black,
                // The border you want
                border: Border.all(
                  width: 1.0,
                  color: borderColor,
                ),
              ),
              child: child,
            ),
          )
        : GestureDetector(
            onTap: () {
              if (priorityOrGoal is Goal) {
                navigateToGoal(priorityOrGoal);
              }
            },
            child: const Icon(Icons.web_rounded));
  }

  Widget _proxyDecorator(Widget child, int index, Animation<double> animation) {
    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, Widget? child) {
        final double animValue = Curves.easeInOut.transform(animation.value);
        final double elevation = lerpDouble(0, 6, animValue)!;
        return Material(
          elevation: elevation,
          color: const Color(0xFF708C8C),
          shadowColor: Colors.grey[300],
          //Colors.black12[300],
          child: child,
        );
      },
      child: child,
    );
  }

  getCurrentColorText(int index) {
    return (!isExpanded[index]) ? Colors.white : Colors.white;
    //: Theme.of(context).colorScheme.primary;
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
    List? listToUse = List.empty(growable: true);
    if (widget.currSubGoals != null) {
      listToUse = widget.currSubGoals;
    } else {
      listToUse = Global.userPriorities;
    }

    return ReorderableListView.builder(
      shrinkWrap: true,
      proxyDecorator: _proxyDecorator,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          elevation: (!widget.isPriority) ? 0 : 2,
          key: ValueKey(listToUse![index]),
          child: ExpansionTile(
            initiallyExpanded: (mounted && isExpanded[index]),
            trailing: getTrailingArrow(index, listToUse[index]),
            leading: getCircleIconWidget(
              context,
              Padding(
                padding: const EdgeInsets.only(right: 0.0),
                child: Center(
                  child: Text(
                    (index + 1).toString(),
                    style: TextStyle(
                      //backgroundColor: Colors.white,
                      color: getCurrentColorText(index),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Colors.white,
              //getCurrentColorText(index),
              //Theme.of(context).colorScheme.primary,
              listToUse[index],
            ),
            onExpansionChanged: (bool expanding) => {
              setState(() {
                isExpanded[index] = !isExpanded[index];
              }),
            },
            title: Text(listToUse[index].name,
                style: const TextStyle(color: Colors.black)),
            children: <Widget>[
              Column(
                children: [..._getExpandableContent(listToUse[index])],
              )
            ],
          ),
        );
      },
      itemCount: listToUse!.length,
      onReorder: (int oldIndex, int newIndex) {
        setState(() {
          if (widget.isPriority) {
            if (newIndex > oldIndex) newIndex--;
            final temp = Global.userPriorities[oldIndex];
            Global.userPriorities[oldIndex] = Global.userPriorities[newIndex];
            Global.userPriorities[newIndex] = temp;

            final temp2 = isExpanded[oldIndex];
            isExpanded[oldIndex] = isExpanded[newIndex];
            isExpanded[newIndex] = temp2;
            Global.updatePriorityIndexes();
          }
        });
      },
    );
  }
}
