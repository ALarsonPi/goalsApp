import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:goals_app/Objects/CardLabel.dart';
import 'package:goals_app/Objects/Priority.dart';
import 'package:goals_app/Widgets/myPageView.dart';
import 'package:goals_app/Widgets/pageViewCard.dart';
import 'package:goals_app/global.dart';
import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:page_view_indicators/circle_page_indicator.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PriorityCarousel extends StatefulWidget {
  const PriorityCarousel({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _PriorityCarousel();
  }
}

class _PriorityCarousel extends State<PriorityCarousel> {
  List<pageViewCard> pages = List.empty(growable: true);
  List imageUrlList = List.empty(growable: true);
  CarouselController controller = CarouselController();
  int currentPage = 0;
  final _currentPageNotifier = ValueNotifier<int>(0);

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
        pageViewCard(300, 1.0, 0.9, priority.imageUrl, index, priority.name),
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
              })
            },
            enlargeCenterPage: true,
            autoPlay: false,
            aspectRatio: 12 / 9,
            height: 300,
            enableInfiniteScroll: false,
            viewportFraction: 0.75,
          ),
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

    // PageView.builder(
    // itemCount: imageUrlList.length,
    // pageSnapping: true,
    // controller: controller,
    // onPageChanged: (page) {
    //   setState(() {
    //     currentPage = page;
    //   });
    // },
    // itemBuilder: (context, pagePosition) {
    //   return Scaffold(
    //     body: Center(
    //       child: Container(
    //         margin: EdgeInsets.all(10),
    //         child: Image.network(imageUrlList[pagePosition]),
    //       ),
    //     ),
    //   );
    // });
    /*return ListView(
      children: [
        CarouselSlider(
          items: [
            //...pages
            ...images
          ],
          options: CarouselOptions(
            enlargeCenterPage: true,
            autoPlay: false,
            aspectRatio: 12 / 9,
            height: 300,
            enableInfiniteScroll: false,
            viewportFraction: 0.75,
          ),
        ),
      ],
    );*/
  }
}
