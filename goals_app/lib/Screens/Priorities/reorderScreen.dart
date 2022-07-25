import 'package:flutter/material.dart';
import 'package:goals_app/Unused/draggableCard.dart';
import 'package:goals_app/global.dart';

import '../../Objects/Priority.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(
            "Priorities",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
          ),
          actions: <Widget>[
            IconButton(
              onPressed: () => {
                setState(() {
                  widget.changeScreens(currentPriorities);
                })
              },
              icon: const Icon(Icons.save),
            ),
          ]),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("HOLD and DRAG to reorder",
                style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic)),
          ),
          Container(
              color: Colors.transparent,
              height: MediaQuery.of(context).size.height * 0.8,
              child: Column(
                children: [
                  ReorderableListView(
                    shrinkWrap: true,
                    onReorder: (int oldIndex, int newIndex) {
                      setState(() {
                        if (newIndex > oldIndex) newIndex--;
                        final item = currentPriorities.removeAt(oldIndex);
                        currentPriorities.insert(newIndex, item);
                      });
                    },
                    children: [
                      for (final priority in currentPriorities)
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          key: ValueKey(priority),
                          child: ListTile(
                            leading: const Icon(Icons.swap_vert_circle),
                            title: Text(
                                ("${currentPriorities.indexOf(priority) + 1}. ${priority.name}")),
                            trailing: IconButton(
                                onPressed: () => {
                                      setState(
                                        () => {
                                          currentPriorities.remove(priority),
                                          deletedPriorities.add(priority),
                                        },
                                      ),
                                    },
                                icon: const Icon(Icons.delete),
                                color: Colors.redAccent),
                          ),
                        ),
                    ],
                  ),
                  Expanded(
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        for (var deletedItem in deletedPriorities)
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: ListTile(
                              leading: const Icon(Icons.circle),
                              title: Text(
                                (deletedItem.name),
                                style: const TextStyle(
                                    decoration: TextDecoration.lineThrough),
                              ),
                              trailing: IconButton(
                                onPressed: () => {
                                  setState(
                                    () => {
                                      deletedPriorities.remove(deletedItem),
                                      currentPriorities.add(deletedItem),
                                    },
                                  ),
                                },
                                icon: const Icon(Icons.restore_from_trash,
                                    color: Colors.greenAccent),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
