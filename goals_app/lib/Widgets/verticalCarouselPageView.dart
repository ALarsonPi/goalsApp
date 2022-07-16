import 'package:flutter/material.dart';
import 'package:goals_app/Widgets/imageCarousel.dart';

class VerticalCarouselPageView extends StatefulWidget {
  VerticalCarouselPageView(this.imageCarousels, this.desiredHeight, {Key? key})
      : super(key: key);
  List<ImageCarousel> imageCarousels;
  double desiredHeight;

  @override
  State<StatefulWidget> createState() {
    return _VerticalCarouselPageView();
  }
}

class _VerticalCarouselPageView extends State<VerticalCarouselPageView> {
  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    debugPrint(widget.imageCarousels.length.toString());
    return Container(
      color: Colors.transparent,
      height: widget.desiredHeight,
      child: PageView(
        scrollDirection: Axis.vertical,
        children: [...widget.imageCarousels],
      ),
    );
  }
}
