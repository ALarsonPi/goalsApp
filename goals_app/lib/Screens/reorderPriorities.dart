import 'package:flutter/material.dart';
import 'package:goals_app/Objects/Priority.dart';
import 'package:goals_app/Widgets/draggableCard.dart';
import 'package:goals_app/global.dart';

class ReorderPrioritiesScreen extends StatefulWidget {
  ReorderPrioritiesScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ReorderPrioritiesScreen();
  }
}

class _ReorderPrioritiesScreen extends State<ReorderPrioritiesScreen> {
  String acceptedData = "h";
  List<Color> backgroundColors = List.empty(growable: true);

  @override
  void initState() {
    backgroundColors.add(const Color(0xFFD8EDF3));
    backgroundColors.add(const Color(0xFFDBF2D8));
    backgroundColors.add(const Color(0xFFFFDAC1));
    backgroundColors.add(const Color(0xFFF2B3B3));
    backgroundColors.add(const Color.fromARGB(255, 229, 200, 240));
    super.initState();
  }

  Padding makePriorityCard(Color cardBackgroundColor, int index) {
    return Padding(
      padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
      child: Card(
        color: backgroundColors[index % backgroundColors.length],
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, left: 16.0),
                    child: Text("Priority ${index + 1}",
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ],
              ),
              DragTarget<String>(
                builder: (
                  BuildContext context,
                  List<dynamic> accepted,
                  List<dynamic> rejected,
                ) {
                  return Stack(
                    children: [
                      //const Divider(thickness: 2.0),
                      Draggable<String>(
                        // Data is the value this Draggable stores.
                        data: "$index",
                        //Running
                        feedback: DraggableCard(
                            Global.userPriorities[index], index, true),
                        //Stay Still / Left behind
                        childWhenDragging: DraggableCard(
                            Global.userPriorities[index], index, false),
                        //Default
                        child: DraggableCard(
                            Global.userPriorities[index], index, true),
                      ),
                      //const Divider(thickness: 2),
                    ],
                  );
                },
                onAccept: (String data) {
                  setState(() {
                    int recievedFromIndex = int.parse(data);
                    if (recievedFromIndex != index) {
                      Priority temp = Global.userPriorities[index];
                      Global.userPriorities[index] =
                          Global.userPriorities[int.parse(data)];
                      Global.userPriorities[int.parse(data)] = temp;
                      debugPrint("Recieved $index");
                      debugPrint("Recieved from " + data);
                      acceptedData += data;
                    }
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Padding> priorityCards = List.empty(growable: true);

    int index = 0;
    for (Priority priority in Global.userPriorities) {
      priorityCards.add(makePriorityCard(Colors.red, index));
      index++;
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pushNamed(context, '/'),
        ),
        title: const Text(
          "Priorities",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: ListView(
          children: <Widget>[
            ...priorityCards,
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.25,
                  right: MediaQuery.of(context).size.width * 0.25),
              child: ElevatedButton(
                onPressed: () => {},
                child: const Text("Add new priority"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
