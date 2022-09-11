import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:goals_app/Screens/ArgumentPassThroughScreens/individualPriorityArgumentScreen.dart';

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
              padding: EdgeInsets.only(
                  bottom: (MediaQuery.of(context).size.height > 900)
                      ? (MediaQuery.of(context).size.height * 0.1)
                      : (MediaQuery.of(context).size.height * 0.12)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.735,
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
              bottom: 5.0,
              right: 0.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.77,
                    height: (MediaQuery.of(context).size.height > 900.0)
                        ? MediaQuery.of(context).size.height * 0.1
                        : MediaQuery.of(context).size.height * 0.125,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20)),
                      child: Card(
                        borderOnForeground: false,
                        elevation: 5,
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: (MediaQuery.of(context).size.height > 900.0)
                                ? 12
                                : 0,
                            left: (MediaQuery.of(context).size.height > 900.0)
                                ? 24
                                : 0,
                          ),
                          child: ListTile(
                            title: AutoSizeText(
                              name,
                              style: TextStyle(
                                  fontSize:
                                      (MediaQuery.of(context).size.height >
                                              900.0)
                                          ? 36
                                          : 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87),
                            ),
                            subtitle: AutoSizeText(
                              "Priority ${index + 1}",
                              style: TextStyle(
                                  fontSize:
                                      (MediaQuery.of(context).size.height >
                                              900.0)
                                          ? 24
                                          : 12,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black45),
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
    );
  }
}
