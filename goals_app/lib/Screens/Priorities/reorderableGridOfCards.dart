import 'dart:io';

import 'package:flutter/material.dart';
import 'package:goals_app/Objects/Priority.dart';
import 'package:goals_app/Screens/Priorities/individualPriority.dart';
import 'package:goals_app/Widgets/Priorities/roundedCard.dart';
import 'package:goals_app/global.dart';
import 'package:reorderable_grid_view/reorderable_grid_view.dart';

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
      return Image.network(
        priority.imageUrl,
        fit: BoxFit.fill,
      );
    } else {
      return Image.file(
        File(priority.imageUrl),
        fit: BoxFit.fill,
      );
    }
  }

  getImageObject(Priority priority) {
    if (priority.imageUrl.toString().contains("http")) {
      return NetworkImage(
        priority.imageUrl,
        // fit: BoxFit.fill,
      );
    } else {
      return Image.file(
        File(priority.imageUrl),
        // fit: BoxFit.fill,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: constraints.constrainHeight() * 0.15),
                    child: Card(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: 5,
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: getImageObject(priority),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0.0,
                    left: 0.0,
                    child: SizedBox(
                      width: constraints.maxWidth,
                      height: constraints.constrainHeight() * 0.35,
                      child: Card(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10.0),
                            bottomRight: Radius.circular(10.0),
                          ),
                        ),
                        elevation: 5,
                        child: ListTile(
                          title: Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, bottom: 8.0),
                            child: Text(
                              "${priority.name} (${priority.priorityIndex + 1})",
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
                ],
              );
            },
          ),
        )
      // RoundedCard(
      //   currImage: getImage(priority),
      //   name: priority.name,
      //   index: priority.priorityIndex,
      //   isSmall: true,
      // ),
    ];

    void _onReorder(int oldIndex, int newIndex) {
      if (oldIndex != newIndex) {
        setState(() {
          Priority currPriority = Global.userPriorities.removeAt(oldIndex);
          Global.userPriorities.insert(newIndex, currPriority);
          Global.updatePriorityIndexes();
        });
      }
    }

    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
      child: ReorderableGridView.count(
        shrinkWrap: true,
        cacheExtent: 5,
        crossAxisSpacing: 1,
        mainAxisSpacing: 6,
        crossAxisCount: 2,
        padding: EdgeInsets.zero,
        onReorder: _onReorder,
        children: _columns,
      ),
    );
  }
}
