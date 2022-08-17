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
      return Image.network(
        priority.imageUrl,
        fit: BoxFit.cover,
      );
    } else {
      return Image.file(
        File(priority.imageUrl),
        fit: BoxFit.cover,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double _height = 150;
    double _width = MediaQuery.of(context).size.width * 0.5;
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
            padding: EdgeInsets.only(
              //top: MediaQuery.of(context).size.height * 0.06,
              bottom: MediaQuery.of(context).size.height * 0.06,
            ),
            child: FittedBox(
              fit: BoxFit.cover,
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.08,
                        left: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: _height -
                              MediaQuery.of(context).size.height * 0.07,
                          width: _width,
                          child: FittedBox(
                            fit: BoxFit.fill,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20)),
                              child: Align(
                                alignment: const Alignment(-0.0, -0.0),
                                widthFactor: 1.0,
                                heightFactor: 1.0,
                                child: getImage(priority),
                                // Image.network(priority.imageUrl,
                                //     fit: BoxFit.cover),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.27,
                      left: 3,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: _height / 2 -
                              (MediaQuery.of(context).size.height * 0.04),
                          width: _width + 10,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20)),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 0.0),
                              child: Card(
                                borderOnForeground: false,
                                elevation: 2,
                                child: ListTile(
                                  // contentPadding: const EdgeInsets.symmetric(
                                  //     horizontal: 8.0, vertical: 0.0),
                                  //minVerticalPadding: 0.0,
                                  title: AutoSizeText(
                                    textAlign: TextAlign.center,
                                    priority.name,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  subtitle: Padding(
                                    padding: const EdgeInsets.only(top: 3.0),
                                    child: Align(
                                      alignment: Alignment.topCenter,
                                      child: Text(
                                        "Priority ${Global.userPriorities.indexOf(priority) + 1}",
                                        style: const TextStyle(fontSize: 12),
                                      ),
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
                ],
              ),
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
