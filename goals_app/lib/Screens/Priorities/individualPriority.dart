import 'dart:io';

import 'package:flutter/material.dart';
import 'package:goals_app/Screens/ArgumentPassThroughScreens/newGoalArguements.dart';
import 'package:goals_app/Screens/ArgumentPassThroughScreens/priorityHomeArguments.dart';
import 'package:goals_app/Screens/Goals/newGoalScreen.dart';
import 'package:goals_app/Screens/Priorities/prioritiesHome.dart';
import 'package:goals_app/Unused/editPriority.dart';
import 'package:goals_app/Widgets/Priorities/normalPriorityWidget.dart';
import 'package:goals_app/global.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../Objects/Goal.dart';
import '../../Widgets/Goals/goalButton.dart';
import '../../Unused/goalsList.dart';
import '../../Widgets/Priorities/editPriorityWidget.dart';
import '../../Widgets/Priorities/gridListIconRow.dart';
import '../ArgumentPassThroughScreens/browseImageArguments.dart';
import '../ArgumentPassThroughScreens/editPriotitiesArguments.dart';
import '../ArgumentPassThroughScreens/individualPriorityArgumentScreen.dart';
import '../browseImages.dart';

class IndividualPriority extends StatefulWidget {
  static const routeName = "/extractPriorityIndex";

  const IndividualPriority({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _IndividualPriority();
  }
}

class _IndividualPriority extends State<IndividualPriority> {
  late final args = ModalRoute.of(context)!.settings.arguments
      as IndividualPriorityArgumentScreen;

  bool areSettingsOpen = false;
  bool shouldEdit = false;

  late PermissionStatus _permissionStatus;

  @override
  void initState() {
    () async {
      _permissionStatus = await Permission.storage.status;

      if (_permissionStatus != PermissionStatus.granted) {
        PermissionStatus permissionStatus = await Permission.storage.request();
        setState(() {
          _permissionStatus = permissionStatus;
        });
      }
    }();
  }

  bool recievedNewBrowsedImage = false;
  getImageWidget() {
    if (!recievedNewBrowsedImage && _selectedFile != null) {
      Global.userPriorities[args.index].imageUrl = _selectedFile!.path;
    }
    recievedNewBrowsedImage = false;

    if (Global.userPriorities[args.index].imageUrl
        .toString()
        .contains("http")) {
      return NetworkImage(
        Global.userPriorities[args.index].imageUrl,
      );
    } else {
      return FileImage(
        File(Global.userPriorities[args.index].imageUrl),
      );
    }
  }

  getDecorationImageWidget(int priorityIndex, BuildContext context) {
    return DecorationImage(image: getImageWidget(), fit: BoxFit.cover);
  }

  getCircleIconWidget(
      BuildContext context, IconButton iconButton, Color borderColor) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          // Circle shape
          shape: BoxShape.circle,
          color: Colors.black,
          // The border you want
          border: Border.all(
            width: 2.0,
            color: borderColor,
          ),
        ),
        child: iconButton,
      ),
    );
  }

  getSettingsMenu(BuildContext context) {
    return (areSettingsOpen)
        ? Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              getCircleIconWidget(
                context,
                IconButton(
                  onPressed: () => {
                    setState(() {
                      shouldEdit = !shouldEdit;
                    }),
                  },
                  icon: const Icon(
                    Icons.edit,
                    size: 20,
                  ),
                  color: (shouldEdit) ? Colors.yellowAccent : Colors.white,
                  highlightColor: Colors.grey,
                ),
                (shouldEdit) ? Colors.yellowAccent : Colors.white,
              ),
              getCircleIconWidget(
                context,
                IconButton(
                  onPressed: () => {
                    Global.userPriorities.removeAt(args.index),
                    Navigator.pushNamed(context, '/'),
                  },
                  icon: const Icon(
                    Icons.delete,
                    size: 20.0,
                  ),
                  color: Colors.redAccent,
                ),
                Colors.white,
              ),
              getCircleIconWidget(
                  context,
                  IconButton(
                      onPressed: () => {
                            setState(() {
                              areSettingsOpen = !areSettingsOpen;
                            }),
                          },
                      icon: const Icon(
                        Icons.menu_open,
                        color: Colors.white,
                        size: 20.0,
                      )),
                  Colors.white)
            ],
          )
        : getCircleIconWidget(
            context,
            IconButton(
              onPressed: () => {
                setState(() {
                  areSettingsOpen = !areSettingsOpen;
                }),
              },
              icon: const Icon(
                Icons.menu,
                color: Colors.white,
                size: 20.0,
              ),
            ),
            Colors.white);
  }

  changeImage(String newURL) {
    setState(() {
      recievedNewBrowsedImage = true;
      Global.userPriorities[args.index].setImageUrl(newURL);
      Global.userPriorities[args.index].imageUrl = newURL;
    });
  }

  saveTitleTextChanges(String newTitle) {
    setState(() {
      Global.userPriorities[args.index].setName(newTitle);
      Global.userPriorities[args.index].name = newTitle;
    });
  }

  XFile? _selectedFile;
  bool _inProcess = false;
  getImage(ImageSource source) async {
    setState(() {
      _inProcess = true;
    });
    XFile? image = await ImagePicker.platform.getImage(source: source);
    if (image != null) {
      CroppedFile? cropped = await ImageCropper.platform.cropImage(
        sourcePath: image.path,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
        compressQuality: 100,
        maxWidth: 700,
        maxHeight: 700,
        compressFormat: ImageCompressFormat.jpg,
      );

      setState(() {
        _selectedFile = XFile(cropped!.path);
        _inProcess = false;
      });
    } else {
      setState(() {
        _inProcess = false;
      });
    }
  }

  getEditWidget(List<Goal> buttons) {
    return (shouldEdit)
        ? EditPriorityWidget(args.index, _inProcess, changeImage,
            saveTitleTextChanges, getImage, buttons)
        : NormalPriorityWidget(args.index, buttons);
  }

  @override
  Widget build(BuildContext context) {
    List<GoalButton> justForTesting = List.empty(growable: true);
    Goal testGoal = Goal("default", "3", "4", "whyToComplete", "whenToComplete",
        "whereToComplete");
    justForTesting.add(GoalButton(testGoal, false));
    justForTesting.add(GoalButton(testGoal, false));
    justForTesting.add(GoalButton(testGoal, false));
    List<Goal> goalsJustForTesting = List.empty(growable: true);
    goalsJustForTesting.add(testGoal);
    goalsJustForTesting.add(testGoal);
    goalsJustForTesting.add(testGoal);
    goalsJustForTesting.add(testGoal);
    goalsJustForTesting.add(testGoal);
    goalsJustForTesting.add(testGoal);
    goalsJustForTesting.add(testGoal);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () => {
                Navigator.pushNamed(context, NewGoalScreen.routeName,
                    arguments: NewGoalArguments(args.index))
              }),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(0.0),
            decoration: BoxDecoration(
              image: getDecorationImageWidget(args.index, context),
            ),
            height: MediaQuery.of(context).size.height * 0.4,
            width: double.infinity,
            child: Stack(
              children: [
                //Icons
                Padding(
                  padding:
                      const EdgeInsets.only(top: 16.0, left: 12.0, right: 0.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          getCircleIconWidget(
                              context,
                              IconButton(
                                onPressed: () => {
                                  Navigator.pushNamed(
                                    context,
                                    PriorityHomeScreen.routeName,
                                    arguments:
                                        PriorityHomeArguments(args.index),
                                  ),
                                },
                                icon: const Icon(
                                  Icons.arrow_back,
                                  size: 20.0,
                                ),
                                color: Colors.white,
                              ),
                              Colors.white),
                        ],
                      ),
                      getSettingsMenu(context),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: getEditWidget(goalsJustForTesting),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
