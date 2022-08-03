import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:goals_app/Unused/CardLabel.dart';
import 'package:goals_app/Objects/Priority.dart';
import 'package:goals_app/Unused/PriorityCardWithReorder.dart';
import 'package:goals_app/Unused/myPageView.dart';
import 'package:goals_app/Widgets/Priorities/priorityCard.dart';
import 'package:goals_app/global.dart';
import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:page_view_indicators/circle_page_indicator.dart';
import 'package:reorderable_carousel/reorderable_carousel.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PriorityCarouselWithReorder extends StatefulWidget {
  Function notifyParentOfSlideChange;
  int currentIndex;
  bool isEditMode;
  PriorityCarouselWithReorder(
      this.currentIndex, this.notifyParentOfSlideChange, this.isEditMode,
      {Key? key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _PriorityCarouselWithReorder();
  }
}

//Maybe worth just starting over and
//trying again on the Carousel with Reorder
//just try doing it without 'instructions'
//Just build a component and try and
//get it to look like the normal Carousel?

class _PriorityCarouselWithReorder extends State<PriorityCarouselWithReorder> {
  List imageUrlList = List.empty(growable: true);
  CarouselController controller = CarouselController();
  int currentPage = 0;
  late final _currentPageNotifier = ValueNotifier<int>(widget.currentIndex);

  @override
  void initState() {
    for (Priority priority in Global.userPriorities) {
      imageUrlList.add(priority.imageUrl);
    }

    super.initState();
  }

  defaultFunction() {}

  getWidgetContent() {
    List items = List.empty(growable: true);

    int index = 0;
    for (Priority priority in Global.userPriorities) {
      double widthMultiplier = (!widget.isEditMode) ? 0.9 : 0.9;
      double heightMultiplier = (!widget.isEditMode) ? 1.0 : 0.8;
      double cardHeight = (!widget.isEditMode) ? 300 : 200;
      items.add(
        (!widget.isEditMode)
            ? PriorityCard(cardHeight, heightMultiplier, widthMultiplier,
                priority.imageUrl, index, priority.name, defaultFunction)
            : Card(
                child: PriorityCardWithReorder(
                    cardHeight,
                    heightMultiplier,
                    widthMultiplier,
                    priority.imageUrl,
                    index,
                    priority.name,
                    widget.isEditMode),
              ),
      );
      index++;
    }
    List<Widget> contents = List.empty(growable: true);
    if (!widget.isEditMode) {
      contents.add(
        CarouselSlider(
          carouselController: controller,
          items: [
            ...items,
          ],
          options: CarouselOptions(
            onPageChanged: (index, reason) => {
              setState(() {
                _currentPageNotifier.value = index;
                currentPage = index;
                widget.notifyParentOfSlideChange(currentPage);
              })
            },
            enlargeCenterPage: true,
            autoPlay: false,
            aspectRatio: 12 / 9,
            //width: 300,
            height: 300,
            enableInfiniteScroll: false,
            viewportFraction: 0.75,
            initialPage: widget.currentIndex,
          ),
        ),
      );
      contents.add(
        const SizedBox(
          height: 20,
        ),
      );
      contents.add(
        CirclePageIndicator(
          itemCount: Global.userPriorities.length,
          currentPageNotifier: _currentPageNotifier,
          dotColor: Colors.black45,
          selectedDotColor: Colors.black26,
        ),
      );
      // AnimatedSmoothIndicator(
      //   activeIndex: currentPage,
      //   count: imageUrlList.length,
      //   effect: const ScrollingDotsEffect(
      //       activeDotColor: Color.fromRGBO(0, 0, 0, 0.9),
      //       dotWidth: 8,
      //       dotHeight: 8),
      // ),);
    } else {
      List<Color> colors = [Colors.blue];

      contents.add(
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.37,
          width: double.infinity,
          child: ReorderableCarousel(
            numItems: items.length,
            maxNumberItems: items.length,
            itemWidthFraction: 1.75,

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
              return Expanded(
                child: items[index],
              );
            },
            draggedItemBuilder: (itemWidth, index) {
              return Expanded(child: items[index]);
            },
            onReorder: (oldIndex, newIndex) {
              // items have be reordered, update our list
              setState(() {
                Priority temp = Global.userPriorities[oldIndex];
                Global.userPriorities[oldIndex] =
                    Global.userPriorities[newIndex];
                Global.userPriorities[newIndex] = temp;
                //Color swap = colors.removeAt(oldIndex);
                //colors.insert(newIndex, swap);
              });
            },
            onItemSelected: (int selectedIndex) {
              // a new item has been selected
              setState(() {
                //selectedColor = colors[selectedIndex];
              });
            },
          ),
        ),
      );
      // CarouselSlider(
      //   carouselController: controller,
      //   items: [
      //     ...items,
      //   ],
      //   options: CarouselOptions(
      //     onPageChanged: (index, reason) => {
      //       setState(() {
      //         _currentPageNotifier.value = index;
      //         currentPage = index;
      //         widget.notifyParentOfSlideChange(currentPage);
      //       })
      //     },
      //     enlargeCenterPage: true,
      //     autoPlay: false,
      //     aspectRatio: 12 / 9,
      //     height: 300,
      //     enableInfiniteScroll: false,
      //     viewportFraction: 0.75,
      //     initialPage: widget.currentIndex,
      //   ),
      // );

    }
    return contents;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: Row(
          children: [
            ...getWidgetContent(),
          ],
        )),
      ],
    );
  }
}
