import 'dart:io';
import 'package:flutter/material.dart';
import 'package:goals_app/Screens/ArgumentPassThroughScreens/individualPriorityArgumentScreen.dart';
import 'package:goals_app/global.dart';

import '../../Screens/Priorities/individualPriority.dart';

class PriorityCard extends StatelessWidget {
  final String imageURL;
  final int index;
  final String name;
  Function notifyParentOfLongHold;
  PriorityCard(
      this.imageURL, this.index, this.name, this.notifyParentOfLongHold,
      {Key? key})
      : super(key: key);

  Widget getImageWidget() {
    if (imageURL.contains("http")) {
      return Image.network(imageURL, fit: BoxFit.fitHeight);
    } else {
      return Image.file(
        File(imageURL),
        fit: BoxFit.fitHeight,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget currentImage = getImageWidget();
    return GestureDetector(
      onLongPress: () => {
        notifyParentOfLongHold(),
      },
      onLongPressEnd: (LongPressEndDetails) => {
        notifyParentOfLongHold(),
      },
      onTap: () => {
        Navigator.pushNamed(
          context,
          IndividualPriority.routeName,
          arguments: IndividualPriorityArgumentScreen(index),
        ),
      },
      child: SizedBox(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: FittedBox(
                      fit: BoxFit.fill,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                        child: Align(
                          alignment: const Alignment(0.0, -0.6),
                          widthFactor: 1.0,
                          heightFactor: 1.0,
                          child: currentImage,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0.0,
              right: 3.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.73,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20)),
                      child: Card(
                        borderOnForeground: false,
                        elevation: 5,
                        child: ListTile(
                          title: Text(
                            name,
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87),
                          ),
                          subtitle: Text(
                            "Priority ${index + 1}",
                            style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                                color: Colors.black45),
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
    );
  }
}
