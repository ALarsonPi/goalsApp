import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:goals_app/Unused/CardLabel.dart';
import 'package:goals_app/Objects/Priority.dart';
import 'package:goals_app/Unused/myPageView.dart';
import 'package:goals_app/Widgets/Priorities/priorityCard.dart';
import 'package:goals_app/global.dart';
import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:page_view_indicators/circle_page_indicator.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PriorityCarousel extends StatefulWidget {
  Function notifyParentOfSlideChange;
  int currentIndex;
  PriorityCarousel(this.currentIndex, this.notifyParentOfSlideChange,
      {Key? key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _PriorityCarousel();
  }
}

class _PriorityCarousel extends State<PriorityCarousel> {
  List<PriorityCard> pages = List.empty(growable: true);
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

  @override
  Widget build(BuildContext context) {
    List items = List.empty(growable: true);

    int index = 0;
    for (Priority priority in Global.userPriorities) {
      items.add(
        PriorityCard(300, 1.0, 0.9, priority.imageUrl, index, priority.name),
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
            aspectRatio: 12 / 9,
            height: 300,
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
        // AnimatedSmoothIndicator(
        //   activeIndex: currentPage,
        //   count: imageUrlList.length,
        //   effect: const ScrollingDotsEffect(
        //       activeDotColor: Color.fromRGBO(0, 0, 0, 0.9),
        //       dotWidth: 8,
        //       dotHeight: 8),
        // ),
      ],
    );
  }
}
