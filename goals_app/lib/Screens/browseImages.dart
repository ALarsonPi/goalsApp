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
  List<String> foodUrlList = List.empty(growable: true);
  List<String> studyUrlList = List.empty(growable: true);
  List<String> hobbiesUrlList = List.empty(growable: true);

  List<ImageCarousel> imageCarousels = List.empty(growable: true);
  TextStyle subTitleTextStyle = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w100,
    fontStyle: FontStyle.italic,
  );
  String selectedImage = "None";

  var somethingIsHighlighted = [false, -1];
  checkIfSomethingIsHighlighted() {
    return somethingIsHighlighted;
  }

  List<Function> tappableCurrentImage = List.empty(growable: true);
  clearParents(int index, Function tapChildDetector) {
    somethingIsHighlighted[0] = false;
    //Clear highlighted
    tappableCurrentImage[somethingIsHighlighted[1] as int]();
    //Highlight current
    tapChildDetector();
    imageCarousels[0];
  }

  getSelectImageFromCarousel(
      String imageUrl, int index, Function clickableChildFunction) {
    setState(() {
      tappableCurrentImage[index] = clickableChildFunction;
      selectedImage = imageUrl;
      if (selectedImage != "None") {
        somethingIsHighlighted[0] = true;
        somethingIsHighlighted[1] = index;
      } else {
        somethingIsHighlighted[0] = false;
        somethingIsHighlighted[1] = index;
      }
    });
  }

  defaultFunction() {}

  @override
  void initState() {
    bool isUsingVertical = false;

    double carouselSize = 200;
    if (isUsingVertical) {
      carouselSize = 300;
    }
    for (var pictureHolder in Global.listOfNaturePictures) {
      natureUrlList.add(pictureHolder.url);
    }
    for (var pictureHolder in Global.listOfStudyPictures) {
      studyUrlList.add(pictureHolder.url);
    }
    for (var pictureHolder in Global.listOfFoodPictures) {
      foodUrlList.add(pictureHolder.url);
    }
    for (var pictureHolder in Global.listOfHobbyPictures) {
      hobbiesUrlList.add(pictureHolder.url);
    }

    tappableCurrentImage.add(defaultFunction);
    imageCarousels.add(ImageCarousel(
        natureUrlList,
        "Nature/Animal Images",
        carouselSize,
        true,
        getSelectImageFromCarousel,
        0,
        checkIfSomethingIsHighlighted,
        clearParents));

    tappableCurrentImage.add(defaultFunction);
    imageCarousels.add(ImageCarousel(
        hobbiesUrlList,
        "Activities",
        carouselSize,
        true,
        getSelectImageFromCarousel,
        1,
        checkIfSomethingIsHighlighted,
        clearParents));

    tappableCurrentImage.add(defaultFunction);
    imageCarousels.add(ImageCarousel(
        studyUrlList,
        "Study Images",
        carouselSize,
        true,
        getSelectImageFromCarousel,
        2,
        checkIfSomethingIsHighlighted,
        clearParents));

    tappableCurrentImage.add(defaultFunction);
    imageCarousels.add(ImageCarousel(
        foodUrlList,
        "Food Images",
        carouselSize,
        true,
        getSelectImageFromCarousel,
        3,
        checkIfSomethingIsHighlighted,
        clearParents));

    super.initState();
  }

  Padding createImageCarouselWithPadding(ImageCarousel currentCarousel) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: currentCarousel,
    );
  }

  ImageCarousel createImageCarousel(ImageCarousel currentCarousel) {
    String title = currentCarousel.carouselTitle;
    double height = currentCarousel.desiredHeight;
    bool endless = currentCarousel.endless;
    int index = currentCarousel.index;
    Function currentFunction = currentCarousel.updateParent;
    List<String> currentList = currentCarousel.urlList;
    currentCarousel.createState;
    return ImageCarousel(currentList, title, height, endless, currentFunction,
        index, checkIfSomethingIsHighlighted, clearParents);
  }

  @override
  Widget build(BuildContext context) {
    bool verticalCarousel = true;

    List<Padding> fullCarouselList = List.empty(growable: true);
    for (var currentCarousel in imageCarousels) {
      fullCarouselList.add(createImageCarouselWithPadding(currentCarousel));
    }
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
                  // VerticalCarouselPageView(
                  //     imageCarousels,
                  //     MediaQuery.of(context).size.height * 0.7,
                  //     getSelectImageFromCarousel),

                  ...fullCarouselList,
                ],
              ),
            ),
          ),
          ElevatedButton(
              onPressed: (selectedImage != "None")
                  ? () => {
                        args.parentFunctionToChangeImage(selectedImage),
                        Navigator.pop(context, true),
                      }
                  : null,
              child: const Text("Choose Selected Image")),
        ],
      ),
    );
  }
}
