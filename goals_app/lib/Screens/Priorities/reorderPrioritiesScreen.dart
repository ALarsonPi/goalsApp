import 'dart:io';

import 'package:flutter/material.dart';
import 'package:goals_app/Models/Priority.dart';
import 'package:goals_app/Providers/PriorityProvider.dart';
import 'package:goals_app/Screens/Priorities/individualPriority.dart';
import 'package:provider/provider.dart';
import 'package:reorderable_grid_view/reorderable_grid_view.dart';

import '../ArgumentPassThroughScreens/individualPriorityArgumentScreen.dart';

class ReorderableGridOfCards extends StatefulWidget {
  Function notifyParentOfLongHold;

  ReorderableGridOfCards(this.notifyParentOfLongHold, {super.key});

  @override
  _ReorderableGridOfCardsState createState() => _ReorderableGridOfCardsState();
}

class _ReorderableGridOfCardsState extends State<ReorderableGridOfCards> {
  late List<Widget> _columns;

  getImageObject(Priority priority) {
    if (priority.imageUrl.toString().contains("http")) {
      return NetworkImage(
        priority.imageUrl,
      );
    } else {
      return Image.file(
        File(priority.imageUrl),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    _columns = <Widget>[
      for (Priority priority
          in Provider.of<PriorityProvider>(context, listen: false).priorities)
        GestureDetector(
          onTap: () => {
            Navigator.pushNamed(
              context,
              IndividualPriority.routeName,
              arguments: IndividualPriorityArgumentScreen(
                  Provider.of<PriorityProvider>(context, listen: false)
                      .priorities
                      .indexOf(priority)),
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
                              ),
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
    ];

    void _onReorder(int oldIndex, int newIndex) {
      if (oldIndex != newIndex) {
        setState(() {
          // Priority currPriority = Global.userPriorities.removeAt(oldIndex);
          // Global.userPriorities.insert(newIndex, currPriority);
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
