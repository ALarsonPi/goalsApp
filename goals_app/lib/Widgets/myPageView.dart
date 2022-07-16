import 'package:flutter/material.dart';
import 'package:goals_app/Widgets/pageViewCard.dart';
import 'package:page_view_indicators/circle_page_indicator.dart';
import '../global.dart';

class MyPageView extends StatefulWidget {
  final double multiplier;
  const MyPageView(this.multiplier, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _PageView();
  }
}

class _PageView extends State<MyPageView> {
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Stack(
        children: <Widget>[
          _buildPageView(context),
          _buildCircleIndicator(),
        ],
      ),
    ]);
  }

  final _pageController = PageController();
  final _currentPageNotifier = ValueNotifier<int>(0);
  final _boxHeight = 300.0;

  _buildPageView(BuildContext context) {
    return Container(
      color: Colors.transparent,
      height: _boxHeight * widget.multiplier,
      //width: MediaQuery.of(context).size.width * 0.5,
      child: PageView.builder(
          itemCount: Global.userPriorities.length,
          controller: _pageController,
          itemBuilder: (BuildContext context, int index) {
            return pageViewCard(
                _boxHeight,
                widget.multiplier,
                1.0,
                Global.userPriorities[index].imageUrl,
                index,
                Global.userPriorities[index].name);
          },
          onPageChanged: (int index) {
            _currentPageNotifier.value = index;
          }),
    );
  }

  _buildCircleIndicator() {
    return Positioned(
      left: 0.0,
      right: 0.0,
      bottom: 0.0,
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: CirclePageIndicator(
          itemCount: Global.userPriorities.length,
          currentPageNotifier: _currentPageNotifier,
          dotColor: Colors.black45,
          selectedDotColor: Colors.black26,
        ),
      ),
    );
  }
}
