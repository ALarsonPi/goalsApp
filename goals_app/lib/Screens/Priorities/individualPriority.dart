import 'dart:io';

import 'package:flutter/material.dart';
import 'package:goals_app/Models/Priority.dart';
import 'package:goals_app/Providers/PriorityProvider.dart';
import 'package:goals_app/Screens/Priorities/prioritiesHome.dart';
import 'package:goals_app/Widgets/Priorities/normalPriorityWidget.dart';
import 'package:goals_app/Settings/global.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import '../../Models/Goal.dart';
import '../../Widgets/Priorities/editPriorityWidget.dart';
import '../ArgumentPassThroughScreens/individualPriorityArgumentScreen.dart';

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
    super.initState();
  }

  late Priority currPriority;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    currPriority = Provider.of<PriorityProvider>(context, listen: false)
        .priorities
        .elementAt(args.index);
  }

  bool recievedNewBrowsedImage = false;
  getImageWidget() {
    if (!recievedNewBrowsedImage && _selectedFile != null) {
      currPriority.imageUrl = _selectedFile!.path;
    }
    recievedNewBrowsedImage = false;

    if (currPriority.imageUrl.toString().contains("http")) {
      return NetworkImage(
        currPriority.imageUrl,
      );
    } else {
      return FileImage(
        File(currPriority.imageUrl),
      );
    }
  }

  getDecorationImageWidget(int priorityIndex, BuildContext context) {
    return DecorationImage(image: getImageWidget(), fit: BoxFit.cover);
  }

  getCircleIconWidget(BuildContext context, IconButton iconButton) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Container(
        width: (Global.isPhone) ? 50 : 75,
        height: (Global.isPhone) ? 50 : 75,
        decoration: BoxDecoration(
          // Circle shape
          shape: BoxShape.circle,
          color: Theme.of(context).secondaryHeaderColor,
          // The border you want
          border: (Global.isDarkMode == 0)
              ? Border.all(color: Colors.transparent)
              : Border.all(
                  width: 2.0,
                  color:
                      Theme.of(context).textTheme.displaySmall?.color as Color,
                ),
        ),
        child: iconButton,
      ),
    );
  }

  getSettingsMenu(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 0.0),
      child: (areSettingsOpen)
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
                    ),
                    color: (shouldEdit)
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).textTheme.displaySmall?.color,
                    highlightColor: Colors.grey,
                  ),
                  //(shouldEdit) ? Colors.yellowAccent : Colors.white,
                ),
                getCircleIconWidget(
                  context,
                  IconButton(
                    onPressed: () async => {
                      await Provider.of<PriorityProvider>(context,
                              listen: false)
                          .removePriority(currPriority),
                      Navigator.push<void>(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) =>
                              PriorityHomeScreen.fromOtherRoute(0),
                        ),
                      ),
                    },
                    icon: const Icon(
                      Icons.delete,
                    ),
                    color: Colors.redAccent,
                  ),
                ),
                getCircleIconWidget(
                  context,
                  IconButton(
                    onPressed: () => {
                      setState(() {
                        areSettingsOpen = !areSettingsOpen;
                      }),
                    },
                    icon: Icon(
                      Icons.menu_open,
                      color: Theme.of(context).textTheme.displaySmall?.color,
                    ),
                  ),
                )
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
                icon: Icon(
                  Icons.menu,
                  color: Theme.of(context).textTheme.displaySmall?.color,
                ),
              ),
            ),
    );
  }

  changeImage(String newURL) {
    setState(() {
      recievedNewBrowsedImage = true;
      currPriority.setImageUrl(newURL);
      currPriority.imageUrl = newURL;
    });
  }

  saveTitleTextChanges(String newTitle) {
    setState(() {
      currPriority.setName(newTitle);
      currPriority.name = newTitle;
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

  getMainWidget(List<Goal> buttons) {
    return (shouldEdit)
        ? EditPriorityWidget(args.index, _inProcess, changeImage,
            saveTitleTextChanges, getImage, buttons)
        : NormalPriorityWidget(args.index, true, false);
  }

  justSetState() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    List<Goal> currentPriorityGoals = currPriority.goals;
    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(
                Global.currentBackgroundImage,
              ),
              fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
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
                    padding: const EdgeInsets.only(
                        top: 36.0, left: 12.0, right: 0.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            getCircleIconWidget(
                              context,
                              IconButton(
                                onPressed: () => {
                                  Navigator.push<void>(
                                    context,
                                    MaterialPageRoute<void>(
                                      builder: (BuildContext context) =>
                                          PriorityHomeScreen.fromOtherRoute(
                                              args.index),
                                    ),
                                  ),
                                },
                                icon: Icon(
                                  Icons.arrow_back,
                                  color: Theme.of(context)
                                      .textTheme
                                      .displaySmall
                                      ?.color as Color,
                                ),
                              ),
                            ),
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
                    child: getMainWidget(currentPriorityGoals),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
