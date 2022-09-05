import 'dart:io';

import 'package:flutter/material.dart';
import 'package:goals_app/Objects/Priority.dart';
import 'package:goals_app/Screens/Priorities/individualPriority.dart';
import 'package:goals_app/global.dart';
import 'package:reorderable_grid_view/reorderable_grid_view.dart';

import 'package:reorderables/reorderables.dart';

import '../ArgumentPassThroughScreens/individualPriorityArgumentScreen.dart';

class ReorderableGridOfCards extends StatefulWidget {
  Function notifyParentOfLongHold;

  ReorderableGridOfCards(this.notifyParentOfLongHold);

  @override
  _ReorderableGridOfCardsState createState() => _ReorderableGridOfCardsState();
}

class _ReorderableGridOfCardsState extends State<ReorderableGridOfCards> {
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
    debugPrint("Pixel Ratio, width");
    debugPrint(MediaQuery.of(context).devicePixelRatio.toString());
    debugPrint(MediaQuery.of(context).size.width.toString());
    double mediaPixelVar = MediaQuery.of(context).devicePixelRatio - 1.75;
    if (mediaPixelVar < 1) mediaPixelVar = 1;
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
                  padding: const EdgeInsets.only(
                      left: 4.0, right: 4.0, bottom: 16.0),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5)),
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: getImage(priority),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0.0,
                  left: 0.0,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20)),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width *
                          0.45 *
                          mediaPixelVar,
                      height: 50,
                      child: Card(
                        //elevation: 5,
                        child: ListTile(
                          title: Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, bottom: 8.0),
                            child: Text(
                              "${priority.name} (${++index})",
                              style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87),
                            ),
                          ),
                        ),
                      ),
                    ),
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
        Global.updatePriorityIndexes();
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
