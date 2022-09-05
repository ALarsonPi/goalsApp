import 'package:flutter/material.dart';
import '../Objects/Priority.dart';

class DraggableCard extends StatelessWidget {
  Priority currPriority;
  int index;
  DraggableCard(this.currPriority, this.index, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double sizeFactor = 1.0;
    return SizedBox(
      width: MediaQuery.of(context).size.width * (1.0 - (1 - sizeFactor)),
      child: Card(
        color: Colors.transparent,
        elevation: 0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.menu, size: 32)),
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
                          child: Text(
                            currPriority.name,
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                                fontSize: 20.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            // Padding(
            //   padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
            //   child: Visibility(
            //     visible: visibilityStatus,
            //     child: GestureDetector(
            //         child: const Icon(Icons.edit, color: Colors.black38),
            //         onTap: () => {
            //               Navigator.pushNamed(
            //                 context,
            //                 EditPriorityScreen.routeName,
            //                 arguments: PriorityScreenArguments(
            //                   currPriority,
            //                   index,
            //                 ),
            //               ),
            //             }),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
