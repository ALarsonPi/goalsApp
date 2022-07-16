import 'package:flutter/material.dart';
import 'package:goals_app/Screens/ArgumentPassThroughScreens/browseImageArguments.dart';
import 'package:goals_app/Screens/editPriority.dart';
import 'package:goals_app/Widgets/imageCarousel.dart';
import 'package:goals_app/Widgets/verticalCarouselPageView.dart';
import 'package:goals_app/global.dart';

class BrowseImagesScreen extends StatefulWidget {
  BrowseImagesScreen();
  static const routeName = '/extractBrowseImageArguments';

  @override
  State<StatefulWidget> createState() {
    return _BrowseImagesScreen();
  }
}

class _BrowseImagesScreen extends State<BrowseImagesScreen> {
  late final args =
      ModalRoute.of(context)!.settings.arguments as BrowseImageArguments;

  List<String> natureUrlList = List.empty(growable: true);
  List<String> cityUrlList = List.empty(growable: true);
  List<ImageCarousel> imageCarousels = List.empty(growable: true);
  TextStyle subTitleTextStyle = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w100,
    fontStyle: FontStyle.italic,
  );

  @override
  void initState() {
    for (var pictureHolder in Global.listOfNaturePictures) {
      natureUrlList.add(pictureHolder.url);
    }
    for (var pictureHolder in Global.listOfCityPictures) {
      cityUrlList.add(pictureHolder.url);
    }

    imageCarousels
        .add(ImageCarousel(natureUrlList, "Nature/Animal Images", 250, true));
    imageCarousels
        .add(ImageCarousel(cityUrlList, "City/Technology Images", 250, true));
    imageCarousels
        .add(ImageCarousel(natureUrlList, "Nature/Animal Images", 250, true));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context, true),
        ),
        title: const Text(
          "Browse Images",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.72,
              child: ListView(
                children: [
                  VerticalCarouselPageView(
                      imageCarousels, MediaQuery.of(context).size.height * 0.7),
                  /*
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Center(
                      child: Text("Nature/Animal Images",
                          style: subTitleTextStyle),
                    ),
                  ),
                  ImageCarousel(natureUrlList, 200, true),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Center(
                        child: Text("City/Technology Images",
                            style: subTitleTextStyle)),
                  ),
                  ImageCarousel(cityUrlList, 200, true),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Center(
                        child: Text("City/Technology Images",
                            style: subTitleTextStyle)),
                  ),
                  ImageCarousel(cityUrlList, 200, true),
                  ElevatedButton(
                      onPressed: () => {
                            args.parentFunctionToChangeImage(
                                "https://picsum.photos/id/3/800/800"),
                            Navigator.pop(context, true),
                          },
                      child: Text("Hi"))
                  */
                ],
              ),
            ),
          ),
          ElevatedButton(
              onPressed: () {}, child: const Text("Choose Selected Image")),
        ],
      ),
    );
  }
}
