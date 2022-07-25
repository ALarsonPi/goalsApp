import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:goals_app/Objects/CardLabel.dart';
import 'package:goals_app/Widgets/Priorities/clickableHighlightImage.dart';
import '../../global.dart';

class ImageCarousel extends StatefulWidget {
  final List<String> urlList;
  final bool endless;
  final double desiredHeight;
  final String carouselTitle;
  final Function updateParent;
  final int index;
  final Function checkParent;
  final Function clearParents;
  final shouldHighlightValue;
  ImageCarousel(
      this.urlList,
      this.carouselTitle,
      this.desiredHeight,
      this.endless,
      this.updateParent,
      this.index,
      this.checkParent,
      this.clearParents,
      this.shouldHighlightValue,
      {Key? key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ImageCarousel();
  }
}

class _ImageCarousel extends State<ImageCarousel> {
  List<ClickableHighlightImage> imagePages = List.empty(growable: true);
  String selectedImage = "None";

  void selectImage(String selectedUrl, Function tapSelectedChildMethod) {
    widget.updateParent(selectedUrl, widget.index, tapSelectedChildMethod);
    setState(() {
      selectedImage = selectedUrl;
    });
  }

  defaultFunction() {}

  ClickableHighlightImage createContainer(String url, int localIndex) {
    return ClickableHighlightImage(
      url,
      selectImage,
      widget.checkParent,
      widget.clearParents,
      widget.index,
      widget.shouldHighlightValue[1] == widget.index && localIndex == 0,
    );
  }

  @override
  void initState() {
    int i = 0;
    for (String url in widget.urlList) {
      imagePages.add(createContainer(url, i));
      i++;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.desiredHeight + MediaQuery.of(context).size.height * 0.05,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text(
              widget.carouselTitle,
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
              onPageChanged: (index, reason) => {
                setState(() {
                  selectedImage = "None";
                  if (widget.checkParent()[1] == widget.index) {
                    widget.updateParent(
                        selectedImage, widget.index, defaultFunction);
                  }
                  ClickableHighlightImage currentPage = imagePages[index];
                  for (int i = 0; i < imagePages.length; i++) {
                    String imageURL = imagePages[i].imageUrl;
                    imagePages[i] = createContainer(imageURL, i);
                  }
                }),
              },
              enlargeCenterPage: true,
              autoPlay: false,
              aspectRatio: 12 / 9,
              height: widget.desiredHeight,
              enableInfiniteScroll: widget.endless,
              viewportFraction: 0.8,
            ),
          ),
        ],
      ),
    );
  }
}
