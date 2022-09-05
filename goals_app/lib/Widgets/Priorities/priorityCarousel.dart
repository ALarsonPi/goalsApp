import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:goals_app/Objects/Priority.dart';
import 'package:goals_app/Widgets/Priorities/priorityCard.dart';
import 'package:goals_app/global.dart';
import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:page_view_indicators/circle_page_indicator.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PriorityCarousel extends StatefulWidget {
  Function notifyParentOfSlideChange;
  Function notifyParentOfLongHold;
  int currentIndex;
  PriorityCarousel(this.currentIndex, this.notifyParentOfSlideChange,
      this.notifyParentOfLongHold,
      {Key? key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _PriorityCarousel();
  }
}

class _PriorityCarousel extends State<PriorityCarousel> {
  List<PriorityCard> pages = List.empty(growable: true);
  CarouselController controller = CarouselController();
  int currentPage = 0;
  late final _currentPageNotifier = ValueNotifier<int>(widget.currentIndex);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Set items = {};
    int index = 0;
    for (Priority priority in Global.userPriorities) {
      items.add(
        PriorityCard(priority.imageUrl, index, priority.name,
            widget.notifyParentOfLongHold),
      );
      index++;
    }
    return Column(
      children: [
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
            aspectRatio: 10.5 / 9,
            //height: 275,
            enableInfiniteScroll: false,
            viewportFraction: 0.75,
            initialPage: widget.currentIndex,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        CirclePageIndicator(
          itemCount: Global.userPriorities.length,
          currentPageNotifier: _currentPageNotifier,
          dotColor: Colors.black45,
          selectedDotColor: Colors.black26,
        ),
      ],
    );
  }
}
