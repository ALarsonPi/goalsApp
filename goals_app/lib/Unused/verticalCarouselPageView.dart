import 'package:flutter/material.dart';
import 'package:goals_app/Widgets/Priorities/imageCarousel.dart';

class VerticalCarouselPageView extends StatefulWidget {
  VerticalCarouselPageView(
      this.imageCarousels, this.desiredHeight, this.resetParentUrl,
      {Key? key})
      : super(key: key);
  List<ImageCarousel> imageCarousels;
  double desiredHeight;
  Function resetParentUrl;

  @override
  State<StatefulWidget> createState() {
    return _VerticalCarouselPageView();
  }
}

class _VerticalCarouselPageView extends State<VerticalCarouselPageView> {
  final _pageController = PageController();

  defaultFunction() {}

  @override
  Widget build(BuildContext context) {
    debugPrint(widget.imageCarousels.length.toString());
    return Column(
      children: [
        const Text(
          "Swipe up to see another image list",
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
        Container(
          color: Colors.transparent,
          height: widget.desiredHeight,
          child: PageView(
            onPageChanged: (index) => {
              widget.resetParentUrl("None", index, defaultFunction),
            },
            scrollDirection: Axis.vertical,
            children: [...widget.imageCarousels],
          ),
        ),
      ],
    );
  }
}
