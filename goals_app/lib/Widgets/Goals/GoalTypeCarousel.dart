import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:goals_app/Widgets/Goals/GoalTypesAndControllers.dart';

class GoalTypeCarousel extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _GoalTypeCarousel();
  }
}

class _GoalTypeCarousel extends State<GoalTypeCarousel> {
  CarouselController controller = CarouselController();
  int currentPage = 0;
  late final _currentPageNotifier = ValueNotifier<int>(currentPage);

  @override
  Widget build(BuildContext context) {
    List<Widget> goalTypeList = List.empty(growable: true);

    goalTypeList.add(GoalTypesAndControllers.getSingleValueGoalType());
    goalTypeList.add(GoalTypesAndControllers.getUntilEventGoalType());
    goalTypeList.add(GoalTypesAndControllers.getType3());

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Text(
          "Type:",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Text(
          "(scroll to see more)",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.normal,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: CarouselSlider(
            carouselController: controller,
            items: [
              ...goalTypeList,
            ],
            options: CarouselOptions(
              onPageChanged: (index, reason) => {
                setState(() {
                  _currentPageNotifier.value = index;
                  currentPage = index;
                })
              },
              enlargeCenterPage: false,
              autoPlay: false,
              enableInfiniteScroll: true,
              height: MediaQuery.of(context).size.height * 0.4,
              viewportFraction: 1.0,
              initialPage: currentPage,
            ),
          ),
        ),
      ],
    );
  }
}
