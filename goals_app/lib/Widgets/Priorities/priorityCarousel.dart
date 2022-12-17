import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:goals_app/Models/Priority.dart';
import 'package:goals_app/Providers/PriorityProvider.dart';
import 'package:goals_app/Widgets/Priorities/priorityCard.dart';
import 'package:goals_app/Settings/global.dart';
import 'package:page_view_indicators/circle_page_indicator.dart';
import 'package:provider/provider.dart';

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
    for (Priority priority
        in Provider.of<PriorityProvider>(context, listen: false).priorities) {
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
            height: !Global.isPhone
                ? MediaQuery.of(context).size.height * 0.55
                : Device.devicePixelRatio > 2.75
                    ? MediaQuery.of(context).size.height * 0.45
                    : Device.screenHeight > 900
                        ? MediaQuery.of(context).size.height * 0.40
                        : MediaQuery.of(context).size.height * 0.45,
            enableInfiniteScroll: false,
            viewportFraction: 0.75,
            initialPage: widget.currentIndex,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        CirclePageIndicator(
          itemCount: Provider.of<PriorityProvider>(context, listen: false)
              .priorities
              .length,
          currentPageNotifier: _currentPageNotifier,
          dotColor: Theme.of(context)
              .textTheme
              .displaySmall
              ?.color
              ?.withOpacity(0.12),
          selectedDotColor: Theme.of(context)
              .textTheme
              .displaySmall
              ?.color
              ?.withOpacity(0.88),
          size: (Global.isPhone) ? 10 : 15,
          selectedSize: (Global.isPhone) ? 10 : 15,
        ),
      ],
    );
  }
}
