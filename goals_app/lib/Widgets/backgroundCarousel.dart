import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:goals_app/global.dart';

class BackgroundCarousel extends StatefulWidget {
  List<String> urls;
  double desiredHeight;
  bool shouldBeEndless;
  Function updateParentImage;
  BackgroundCarousel(this.urls, this.desiredHeight, this.shouldBeEndless,
      this.updateParentImage,
      {Key? key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _BackgroundCarousel();
  }
}

class _BackgroundCarousel extends State<BackgroundCarousel> {
  List imagePages = List.empty(growable: true);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    for (String url in widget.urls) {
      imagePages.add(
        GestureDetector(
          onTap: () => {
            setState(
              () => {
                widget.updateParentImage(),
                Global.currentBackgroundImage = url,
              },
            ),
          },
          child: Container(
            margin: const EdgeInsets.all(6.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(
                width: 0.0,
              ),
              image: DecorationImage(
                image: NetworkImage(url),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.desiredHeight + MediaQuery.of(context).size.height * 0.05,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CarouselSlider(
            items: [
              ...imagePages,
            ],
            options: CarouselOptions(
              onPageChanged: (index, reason) => {
                setState(() {}),
              },
              enlargeCenterPage: true,
              autoPlay: false,
              aspectRatio: 12 / 9,
              height: widget.desiredHeight,
              enableInfiniteScroll: widget.shouldBeEndless,
              viewportFraction: 0.8,
            ),
          ),
        ],
      ),
    );
  }
}
