import 'dart:io';
import 'package:flutter/material.dart';
import 'package:goals_app/Screens/ArgumentPassThroughScreens/individualPriorityArgumentScreen.dart';

import '../../Screens/Priorities/individualPriority.dart';

class pageViewCard extends StatelessWidget {
  final double _boxHeight;
  final double heightMultiplier;
  final double widthMultiplier;
  final String imageURL;
  final int index;
  final String name;
  const pageViewCard(this._boxHeight, this.heightMultiplier,
      this.widthMultiplier, this.imageURL, this.index, this.name,
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
      onTap: () => {
        Navigator.pushNamed(
          context,
          IndividualPriority.routeName,
          arguments: IndividualPriorityArgumentScreen(index),
        ),
      },
      child: SizedBox(
        height: _boxHeight * (heightMultiplier - 0.3),
        child: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: SizedBox(
                    height: _boxHeight * (heightMultiplier - 0.3),
                    width: MediaQuery.of(context).size.width *
                        (0.8 - (1 - widthMultiplier)),
                    child: FittedBox(
                      fit: BoxFit.fill,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)),
                        child: Align(
                          alignment: const Alignment(-0.0, -0.4),
                          widthFactor: 1.0,
                          heightFactor: 1.0,
                          child: currentImage,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.38) *
                      heightMultiplier,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width *
                        (0.83 - (1 - widthMultiplier)),
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
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
