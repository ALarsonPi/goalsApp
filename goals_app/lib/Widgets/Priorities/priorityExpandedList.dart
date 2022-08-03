import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:goals_app/global.dart';

import '../../Objects/Goal.dart';
import '../../Objects/Priority.dart';

class PriorityExpandedList extends StatefulWidget {
  bool isInEditMode;
  PriorityExpandedList(this.isInEditMode, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _PriorityExpandedList();
  }
}

class _PriorityExpandedList extends State<PriorityExpandedList> {
  List<bool> isExpanded = List.empty(growable: true);

  @override
  void initState() {
    for (var priority in Global.userPriorities) {
      isExpanded.add(false);
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
      contentToReturn.add(
        ListTile(title: Text(subGoal.name)),
      );
    }
    return contentToReturn;
  }

  getCircleIconWidget(BuildContext context, Widget child, Color borderColor) {
    return Padding(
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
    );
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
    return (!isExpanded[index])
        ? Colors.white
        : Theme.of(context).colorScheme.primary;
  }

  @override
  Widget build(BuildContext context) {
    return ReorderableListView.builder(
      shrinkWrap: true,
      proxyDecorator: _proxyDecorator,
      itemBuilder: (BuildContext context, int index) {
        return Card(
            key: ValueKey(Global.userPriorities[index]),
            child: ExpansionTile(
              leading:
                  // (!widget.isInEditMode)
                  //     ?
                  getCircleIconWidget(
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
              ),
              //: const Icon(Icons.swap_vert_circle,
              //         color: Colors.black, size: 30.0),
              onExpansionChanged: (bool expanding) => {
                setState(() {
                  isExpanded[index] = !isExpanded[index];
                }),
              },
              title: Text(Global.userPriorities[index].name),
              children: <Widget>[
                Column(
                  children: [
                    ..._getExpandableContent(Global.userPriorities[index])
                  ],
                )
              ],
            ));
      },
      itemCount: Global.userPriorities.length,
      onReorder: (int oldIndex, int newIndex) {
        setState(() {
          if (newIndex > oldIndex) newIndex--;
          final temp = Global.userPriorities[oldIndex];
          Global.userPriorities[oldIndex] = Global.userPriorities[newIndex];
          Global.userPriorities[newIndex] = temp;

          final temp2 = isExpanded[oldIndex];
          isExpanded[oldIndex] = isExpanded[newIndex];
          isExpanded[newIndex] = temp2;
        });
      },
    );
  }
}
