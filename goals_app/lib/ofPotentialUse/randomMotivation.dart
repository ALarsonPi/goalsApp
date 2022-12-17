import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class RandomMotivationWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RandomMotivationWidget();
  }
}

class _RandomMotivationWidget extends State<RandomMotivationWidget> {
  CarouselController controller = CarouselController();
  int currentPage = 0;
  late final _currentPageNotifier = ValueNotifier<int>(currentPage);

  @override
  Widget build(BuildContext context) {
    List<Widget> bunchOfMotivationCards = List.empty(growable: true);
    List<String> motivationalQuotes = List.empty(growable: true);

    motivationalQuotes.add("You are amazing");
    motivationalQuotes.add("Wow you're hot");
    motivationalQuotes.add("Someone is thinking about you right now");
    motivationalQuotes
        .add("Statistically you miss all the shots you don't take");
    motivationalQuotes.add("Hey champ. How's it going?");

    for (String motivationQuote in motivationalQuotes) {
      bunchOfMotivationCards.add(
        SizedBox(
          height: 30,
          width: MediaQuery.of(context).size.width * 0.75,
          child: Card(
            child: ListTile(
              title: Text(motivationQuote),
            ),
          ),
        ),
      );
    }

    return Column(
      children: [
        const Text("Motivational Quote of the Day:",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        SizedBox(
          height: 60,
          width: MediaQuery.of(context).size.width * 0.8,
          child: CarouselSlider(
            carouselController: controller,
            items: [
              ...bunchOfMotivationCards,
            ],
            options: CarouselOptions(
              onPageChanged: (index, reason) => {
                setState(() {
                  _currentPageNotifier.value = index;
                  currentPage = index;
                })
              },
              enlargeCenterPage: false,
              autoPlay: true,
              enableInfiniteScroll: true,
              viewportFraction: 1.0,
              initialPage: currentPage,
            ),
          ),
        ),
      ],
    );
  }
}
