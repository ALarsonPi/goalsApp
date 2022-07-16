import 'package:flutter/material.dart';
import 'package:goals_app/Screens/editPriority.dart';

import '../Objects/Priority.dart';
import '../Screens/editPriotitiesArguments.dart';

class DraggableCard extends StatelessWidget {
  Priority currPriority;
  int index;
  bool visibilityStatus;
  DraggableCard(this.currPriority, this.index, this.visibilityStatus,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double sizeFactor = 1.0;
    return SizedBox(
      width: MediaQuery.of(context).size.width * (1.0 - (1 - sizeFactor)),
      child: Card(
        color: Colors.white,
        elevation: 5,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Visibility(
                      visible: visibilityStatus,
                      child: const Icon(Icons.menu, size: 32)),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 0.0),
                  child: MaterialButton(
                    onPressed: null,
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(
                              left: 0, top: 10, bottom: 10),
                          width: MediaQuery.of(context).size.width *
                              (0.55 - (1 - sizeFactor)),
                          child: Visibility(
                            visible: visibilityStatus,
                            child: Text(
                              currPriority.name,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 16.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Visibility(
                visible: visibilityStatus,
                child: GestureDetector(
                    child: const Icon(Icons.edit, color: Colors.black38),
                    onTap: () => {
                          Navigator.pushNamed(
                            context,
                            EditPriorityScreen.routeName,
                            arguments: PriorityScreenArguments(
                              currPriority,
                              index,
                            ),
                          ),
                        }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
