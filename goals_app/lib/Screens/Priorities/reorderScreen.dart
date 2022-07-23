import 'package:flutter/material.dart';
import 'package:goals_app/Widgets/Priorities/draggableCard.dart';
import 'package:goals_app/global.dart';

import '../../Objects/Priority.dart';

class ReorderScreen extends StatefulWidget {
  ReorderScreen({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _ReorderScreen();
  }
}

class _ReorderScreen extends State<ReorderScreen> {
  List<DraggableCard> cards = List.empty(growable: true);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ReorderableListView(
      onReorder: (int oldIndex, int newIndex) {
        setState(() {
          if (newIndex > oldIndex) newIndex--;
          final item = Global.userPriorities.removeAt(oldIndex);
          Global.userPriorities.insert(newIndex, item);
        });
      },
      children: [
        for (final priority in Global.userPriorities)
          Padding(
            padding: const EdgeInsets.only(left: 40, right: 40),
            key: ValueKey(priority),
            child: DraggableCard(
              priority,
              Global.userPriorities.indexOf(priority),
              true,
            ),
          ),
      ],
    );
  }
}
