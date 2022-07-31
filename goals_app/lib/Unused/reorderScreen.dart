import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:goals_app/Unused/draggableCard.dart';
import 'package:goals_app/global.dart';

import '../Objects/Priority.dart';

class ReorderScreen extends StatefulWidget {
  Function changeScreens;
  ReorderScreen(this.changeScreens, {Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _ReorderScreen();
  }
}

class _ReorderScreen extends State<ReorderScreen> {
  List<DraggableCard> cards = List.empty(growable: true);

  @override
  void initState() {
    for (var priority in Global.userPriorities) {
      currentPriorities.add(priority);
    }
    super.initState();
  }

  List<Priority> currentPriorities = List.empty(growable: true);
  List<Priority> deletedPriorities = List.empty(growable: true);

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

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text("HOLD and DRAG to reorder",
              style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic)),
        ),
        Expanded(
          child: ReorderableListView(
            proxyDecorator: _proxyDecorator,
            shrinkWrap: true,
            onReorder: (int oldIndex, int newIndex) {
              setState(() {
                if (newIndex > oldIndex) newIndex--;
                final item = currentPriorities.removeAt(oldIndex);
                currentPriorities.insert(newIndex, item);
                widget.changeScreens(currentPriorities);
              });
            },
            children: [
              for (final priority in currentPriorities)
                Card(
                  key: ValueKey(priority),
                  color: Colors.white,
                  elevation: 2,
                  child: ListTile(
                      leading: const Icon(Icons.swap_vert_circle),
                      title: Text((priority.name))),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
