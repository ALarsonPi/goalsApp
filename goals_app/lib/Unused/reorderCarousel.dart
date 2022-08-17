import 'package:flutter/material.dart';
import 'package:goals_app/Widgets/Priorities/priorityCard.dart';
import 'package:reorderable_carousel/reorderable_carousel.dart';

import '../global.dart';

class ReorderCarousel extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ReorderCarousel();
  }
}

defaultFunction() {}

class _ReorderCarousel extends State<ReorderCarousel> {
  @override
  Widget build(BuildContext context) {
    return ReorderableCarousel(
      numItems: 5,
      maxNumberItems: 5,
      itemWidthFraction: 1,

      addItemAt: (index) {},
      // addItemAt: (index) {
      //   setState(() {
      //     colors.insert(
      //         index,
      //         Color((Random().nextDouble() * 0xFFFFFF).toInt())
      //             .withOpacity(1.0));
      //   });
      // },
      itemBuilder: (boxSize, index, isSelected) {
        return PriorityCard(boxSize, 1.0, 1.0,
            Global.userPriorities[index].name, index, "sup", defaultFunction);
      },
      draggedItemBuilder: (itemWidth, index) {
        return PriorityCard(itemWidth, 1.0, 1.0,
            Global.userPriorities[index].name, index, "sup", defaultFunction);
      },
      onReorder: (oldIndex, newIndex) {
        // items have be reordered, update our list
        setState(() {
          //Priority temp = Global.userPriorities[oldIndex];
          // Global.userPriorities[oldIndex] =
          //     Global.userPriorities[newIndex];
          // Global.userPriorities[newIndex] = temp;
          //Color swap = colors.removeAt(oldIndex);
          //colors.insert(newIndex, swap);
        });
      },
      onItemSelected: (int selectedIndex) {
        // a new item has been selected
        // setState(() {
        //   //selectedColor = colors[selectedIndex];
        // });
      },
    );
  }
}
