import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:goals_app/Objects/CardLabel.dart';
import '../global.dart';

class FullCarousel extends StatelessWidget {
  final List<String> urlList;
  final List<CardLabel> textList;
  final bool endless;
  final bool hasLabel;
  FullCarousel(this.urlList, this.endless, this.hasLabel, this.textList,
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

  NetworkImage getImage(String url) {
    return NetworkImage(
      url,
    );
  }

  Container createContainerWithLabel(String labelText1, String labelText2) {
    return Container(
      height: 24,
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                labelText1,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                labelText2,
                style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                    fontWeight: FontWeight.normal),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<NetworkImage> imageList = List.empty(growable: true);
    List<Container> containerLabelList = List.empty(growable: true);
    List<Card> fullCardContainer = List.empty(growable: true);
    List<Widget> cardsList = List.empty(growable: true);
    for (String url in urlList) {
      imageList.add(getImage(url));
    }
    if (hasLabel) {
      for (int i = 0; i < textList.length; i++) {
        containerLabelList.add(createContainerWithLabel(
            textList[i].primaryText, textList[i].secondaryText));
      }
    }

    //So I think a good way to go about this
    //would be to make a carousel-card Widget that takes
    //a list of Containers [1 - the image, 2 - optional, the label] and
    //combines them.
    // Then I make a bunch of these new widgets and put them
    //here into my carousel

    int i = 0;
    for (NetworkImage imageContainer in imageList) {
      if (hasLabel) {
        cardsList.add(
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.3,
            child: Stack(
              children: <Widget>[
                Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 5,
                  margin: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: MediaQuery.of(context).size.height * 0.25,
                        child: Image.network(
                          urlList[i],
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 10,
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.08,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 32.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [Text('Title'), Text('Subtitle')],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          // Column(children: [
          //   GestureDetector(
          //     onTap: () {},
          //     child: SizedBox(
          //       width: MediaQuery.of(context).size.width * 0.8,
          //       //height: MediaQuery.of(context).size.height * 0.5,
          //       child: Card(
          //         clipBehavior: Clip.antiAliasWithSaveLayer,
          //         shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(10.0),
          //         ),
          //         elevation: 5,
          //         margin: const EdgeInsets.all(10),
          //         child: Column(
          //           children: [
          // SizedBox(
          //   width: MediaQuery.of(context).size.width * 0.8,
          //   child: Image.network(
          //     urlList[i],
          //     fit: BoxFit.fitWidth,
          //   ),
          // ),
          //             SizedBox(
          //                 //height: MediaQuery.of(context).size.height * 0.2,
          //                 child: Column(children: const [
          //               Text('Title'),
          //               Text('Subtitle')
          //             ])),
          //           ],
          //         ),
          //       ),
          //     ),
          //   ),
          // ]),
        );
        //fullCardContainer.add(

        // Card(
        //   semanticContainer: false,
        //   clipBehavior: Clip.antiAliasWithSaveLayer,
        //   shape: RoundedRectangleBorder(
        //     borderRadius: BorderRadius.circular(10.0),
        //   ),
        //   elevation: 5,
        //   margin: const EdgeInsets.all(10),
        //   child: Column(
        //     children: [
        //       SizedBox(
        //         width: MediaQuery.of(context).size.width * 0.8,
        //         child: Image.network(
        //           urlList[i],
        //           fit: BoxFit.fitWidth,
        //         ),
        //       ),
        //       containerLabelList[i],
        //     ],
        //   ),
        // ),
        //);
      } else {
        fullCardContainer.add(
          Card(
            semanticContainer: true,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 5,
            margin: const EdgeInsets.all(10),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Image.network(
                urlList[i],
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
        );
      }
      i++;
    }

    return ListView(
      children: [
        CarouselSlider(
          items: [
            ...fullCardContainer,
            ...cardsList,
          ],
          options: CarouselOptions(
            enlargeCenterPage: true,
            autoPlay: false,
            aspectRatio: 12 / 9,
            height: 300,
            enableInfiniteScroll: endless,
            viewportFraction: 0.75,
          ),
        ),
      ],
    );
  }
}
