import 'dart:io';
import 'package:flutter/material.dart';
import 'package:goals_app/Screens/ArgumentPassThroughScreens/browseImageArguments.dart';
import 'package:goals_app/Widgets/Priorities/imageCarousel.dart';
import 'package:goals_app/Settings/global.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import '../Models/PictureHolderObject.dart';

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

  Future<File> _makeFile(String filename) async {
    Directory dir = await getApplicationDocumentsDirectory();
    String pathName = p.join(dir.path, filename);
    return File(pathName);
  }

  _cropImage() async {
    //Maybe allow the user to crop these in the future?

    args.parentFunctionToChangeImage(selectedImage);
    Navigator.pop(context, true);
  }

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
  }

  setStateForButton() {}

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
    double carouselHeight = (Global.isPhone) ? 200 : 300;

    List<String> listDescriptions = List.empty(growable: true);
    for (String listDescription in Global.listOfImageLists.keys) {
      listDescriptions.add(listDescription);
    }

    int i = 0;
    for (var currentImageList in Global.listOfImageLists.values) {
      List<String> urls = List.empty(growable: true);
      for (pictureHolder myPicHolder in currentImageList) {
        urls.add(myPicHolder.url);
      }
      tappableCurrentImage.add(defaultFunction);
      imageCarousels.add(
        ImageCarousel(
          urls,
          listDescriptions[i],
          carouselHeight,
          true,
          getSelectImageFromCarousel,
          i,
          checkIfSomethingIsHighlighted,
          clearParents,
          somethingIsHighlighted,
        ),
      );
      i++;
    }
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
    return ImageCarousel(
        currentList,
        title,
        height,
        endless,
        currentFunction,
        index,
        checkIfSomethingIsHighlighted,
        clearParents,
        somethingIsHighlighted);
  }

  @override
  Widget build(BuildContext context) {
    List<Padding> fullCarouselList = List.empty(growable: true);
    for (var currentCarousel in imageCarousels) {
      fullCarouselList.add(createImageCarouselWithPadding(currentCarousel));
    }
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(Global.toolbarHeight),
        child: AppBar(
          toolbarHeight: Global.toolbarHeight,
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
            ),
            onPressed: () => Navigator.pop(context, true),
          ),
          title: Center(
            child: Text(
              "Browse Images",
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.8,
              child: ListView(
                children: [
                  ...fullCarouselList,
                ],
              ),
            ),
          ),
          SizedBox(
            height: Global.buttonHeight,
            child: ElevatedButton(
                onPressed: (selectedImage != "None")
                    ? () => {
                          _cropImage(),
                        }
                    : null,
                child: const Text("Choose Selected Image")),
          ),
        ],
      ),
    );
  }
}
