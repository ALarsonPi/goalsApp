import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:goals_app/Objects/CardLabel.dart';
import '../global.dart';

class ImageCarousel extends StatelessWidget {
  final List<String> urlList;
  final bool endless;
  final double desiredHeight;
  final String carouselTitle;
  const ImageCarousel(
      this.urlList, this.carouselTitle, this.desiredHeight, this.endless,
      {Key? key})
      : super(key: key);

  Container createContainer(String url) {
    return Container(
      margin: const EdgeInsets.all(6.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        image: DecorationImage(
          image: NetworkImage(url),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Container> imagePages = List.empty(growable: true);
    for (String url in urlList) {
      imagePages.add(createContainer(url));
    }

    return SizedBox(
      height: desiredHeight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text(
              carouselTitle,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w100,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          CarouselSlider(
            items: [
              ...imagePages,
            ],
            options: CarouselOptions(
              enlargeCenterPage: true,
              autoPlay: false,
              aspectRatio: 12 / 9,
              height: desiredHeight,
              enableInfiniteScroll: endless,
              viewportFraction: 0.8,
            ),
          ),
        ],
      ),
    );
  }
}
