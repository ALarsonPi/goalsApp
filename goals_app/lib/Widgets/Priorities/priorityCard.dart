import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:goals_app/Screens/ArgumentPassThroughScreens/individualPriorityArgumentScreen.dart';
import 'package:goals_app/Widgets/Priorities/roundedCard.dart';

import '../../Screens/Priorities/individualPriority.dart';
import '../../global.dart';

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
      return Image.network(
        imageURL,
        fit: BoxFit.cover,
      );
    } else {
      return Image.file(
        File(imageURL),
        fit: BoxFit.cover,
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
      child: RoundedCard(
        currImage: currentImage,
        name: name,
        index: index,
      ),
    );
  }
}
