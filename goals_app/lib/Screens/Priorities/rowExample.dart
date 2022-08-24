import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:goals_app/Objects/Priority.dart';
import 'package:goals_app/Screens/Priorities/individualPriority.dart';
import 'package:goals_app/Widgets/Priorities/priorityCard.dart';
import 'package:goals_app/global.dart';
import 'package:reorderable_grid_view/reorderable_grid_view.dart';

import 'package:reorderables/reorderables.dart';

import '../ArgumentPassThroughScreens/individualPriorityArgumentScreen.dart';
import '../../Widgets/Priorities/priorityCarousel.dart';

class RowExample extends StatefulWidget {
  Function notifyParentOfLongHold;

  RowExample(this.notifyParentOfLongHold);

  @override
  _RowExampleState createState() => _RowExampleState();
}

class _RowExampleState extends State<RowExample> {
  late List<Widget> _columns;

  defaultFunction() {}

  @override
  void initState() {
    super.initState();
  }

  getImage(Priority priority) {
    if (priority.imageUrl.toString().contains("http")) {
      return NetworkImage(
        priority.imageUrl,
      );
    } else {
      return FileImage(
        File(priority.imageUrl),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    int index = 0;
    _columns = <Widget>[
      for (Priority priority in Global.userPriorities)
        GestureDetector(
          onTap: () => {
            Navigator.pushNamed(
              context,
              IndividualPriority.routeName,
              arguments: IndividualPriorityArgumentScreen(
                  Global.userPriorities.indexOf(priority)),
            ),
          },
          key: ValueKey(priority.name),
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 0.0),
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: getImage(priority),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0.0,
                  left: 0.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Card(
                        color: Colors.white,
                        child: Text(
                          "${priority.name} (${++index})",
                          style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
    ];

    void _onReorder(int oldIndex, int newIndex) {
      setState(() {
        Priority currPriority = Global.userPriorities.removeAt(oldIndex);
        Global.userPriorities.insert(newIndex, currPriority);
      });
    }

    return Theme(
      data: ThemeData(canvasColor: Colors.black),
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        child: ReorderableGridView.count(
          crossAxisSpacing: 1,
          mainAxisSpacing: 6,
          crossAxisCount: 2,
          padding: EdgeInsets.zero,
          onReorder: _onReorder,
          children: _columns,
        ),
      ),
    );
  }
}
