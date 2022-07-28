import 'dart:io';
import 'package:flutter/material.dart';
import 'package:goals_app/Screens/ArgumentPassThroughScreens/individualPriorityArgumentScreen.dart';

import '../../Screens/Priorities/individualPriority.dart';

class PriorityCardWithReorder extends StatelessWidget {
  final double _boxHeight;
  final double heightMultiplier;
  final double widthMultiplier;
  final String imageURL;
  final int index;
  final String name;
  final bool isEditMode;
  const PriorityCardWithReorder(
      this._boxHeight,
      this.heightMultiplier,
      this.widthMultiplier,
      this.imageURL,
      this.index,
      this.name,
      this.isEditMode,
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

  getCardContents(BuildContext context) {
    Widget currentImage = getImageWidget();
    List<Widget> contents = List.empty(growable: true);
    Row firstRow = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(top: (!isEditMode) ? 16.0 : 0.0),
          child: SizedBox(
            height: _boxHeight * (heightMultiplier - 0.3),
            width: (!isEditMode)
                ? MediaQuery.of(context).size.width *
                    (0.8 - (1 - widthMultiplier))
                : 200,
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
    );
    Row secondRow = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(
              top: (!isEditMode)
                  ? MediaQuery.of(context).size.height * 0.38 * heightMultiplier
                  : 0),
          child: SizedBox(
            width: (!isEditMode)
                ? MediaQuery.of(context).size.width *
                    (0.83 - (1 - widthMultiplier))
                : 200,
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
    );

    contents
        .add((!isEditMode) ? firstRow : SizedBox(child: firstRow, width: 100));

    contents.add(
        (!isEditMode) ? secondRow : SizedBox(child: secondRow, width: 100));

    return contents;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        Navigator.pushNamed(
          context,
          IndividualPriority.routeName,
          arguments: IndividualPriorityArgumentScreen(index),
        ),
      },
      child: SizedBox(
        height: (!isEditMode)
            ? (_boxHeight * (heightMultiplier - 0.3))
            : double.infinity,
        child: (!isEditMode)
            ? Stack(
                children: [
                  ...getCardContents(context),
                ],
              )
            : Column(
                children: [...getCardContents(context)],
              ),
      ),
    );
  }
}
