import 'package:flutter/material.dart';
import 'package:goals_app/Screens/ArgumentPassThroughScreens/settingsScreenArguements.dart';
import 'package:goals_app/Screens/Priorities/rowExample.dart';
import 'package:goals_app/Screens/optionsScreen.dart';
import 'package:goals_app/Widgets/Priorities/noGoalsPrompt.dart';
import 'package:goals_app/Widgets/Priorities/priorityCard.dart';
import 'package:goals_app/Unused/randomMotivation.dart';
import 'package:reorderable_carousel/reorderable_carousel.dart';
import 'package:toast/toast.dart';
import 'package:goals_app/Objects/IconsEnum.dart';
import 'package:goals_app/Objects/Priority.dart';
import 'package:goals_app/Screens/ArgumentPassThroughScreens/priorityHomeArguments.dart';
import 'package:goals_app/Screens/Priorities/individualPriority.dart';
import 'package:goals_app/Unused/reorderScreen.dart';
import 'package:goals_app/Widgets/Priorities/gridListIconRow.dart';
import 'package:goals_app/Widgets/Priorities/priorityCarousel.dart';
import 'package:goals_app/Widgets/Priorities/priorityExpandedList.dart';
import '../../Unused/CardLabel.dart';
import '../../Unused/PriorityCarouselWithReorderableCarousel.dart';
import '../../global.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PriorityHomeScreen extends StatefulWidget {
  PriorityHomeScreen({Key? key}) : super(key: key);

  static const routeName = "/priorityHomeArgs";

  @override
  State<StatefulWidget> createState() {
    return _PriorityHomeScreen();
  }
}

class _PriorityHomeScreen extends State<PriorityHomeScreen> {
  List<String> urls = List.empty(growable: true);
  List<Priority> priorities = List.empty(growable: true);
  bool isEdit = false;
  bool areSettingsOpen = false;

  @override
  void initState() {
    priorities = Global.userPriorities;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    priorities = Global.userPriorities;
    super.didChangeDependencies();
  }

  // @override
  // void setState(VoidCallback fn) {
  //   priorities.clear();
  //   for (Priority priority in Global.userPriorities) {
  //     priorities.add(priority);
  //   }
  //   super.setState(fn);
  // }

  void saveAndDelete(List<Priority> prioritiesToSave) {
    setState(() {
      isEdit = !isEdit;
      Global.userPriorities.clear();
      for (var priority in prioritiesToSave) {
        Global.userPriorities.add(priority);
      }
    });
  }

  setListViewState(bool isList) {
    setState(() {
      Global.priorityIsInListView = isList;
      if (Global.priorityIsInListView) isBeingLongHeld = false;
    });
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

  getMenuIcon() {
    return IconButton(
        padding: const EdgeInsets.only(right: 12.0),
        constraints: const BoxConstraints(),
        onPressed: () => {
              setState(() {
                areSettingsOpen = !areSettingsOpen;
              }),
            },
        icon: Icon(
          (areSettingsOpen) ? Icons.menu_open : Icons.menu,
          color: Colors.white,
        ));
  }

  showInfoToast(BuildContext context) async {
    var myToastContext = ToastContext();
    myToastContext.init(context);
    return Toast.show("HOLD and DRAG to reorder",
        duration: Toast.lengthLong, gravity: Toast.bottom);
  }

  getInfoIcon() {
    return IconButton(
      padding: const EdgeInsets.only(right: 8.0),
      constraints: const BoxConstraints(),
      onPressed: () => {
        setState(() {
          isEdit = !isEdit;
        }),
        showInfoToast(context),
      },
      icon: const Icon(
        Icons.info,
        color: Colors.white,
        size: 20,
        //color: (isEdit) ? Colors.black87 : Colors.white,
      ),
    );
  }

  getAddNewIcon() {
    return IconButton(
      padding: const EdgeInsets.only(right: 8.0),
      constraints: const BoxConstraints(),
      onPressed: () => {
        Navigator.pushNamed(context, '/new-priority'),
      },
      icon: const Icon(
        Icons.add,
        color: Colors.white,
        size: 25,
        //color: (isEdit) ? Colors.black87 : Colors.white,
      ),
    );
  }

  getSettingsIcon() {
    return IconButton(
      padding: const EdgeInsets.only(right: 12.0),
      constraints: const BoxConstraints(),
      onPressed: () => {
        Navigator.pushNamed(context, OptionsScreen.routeName,
            arguments: SettingsScreenArguements(args.currentIndex)),
      },
      icon: const Icon(Icons.settings, size: 22.0),
    );
  }

  Widget getSettingsMenu(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 14.0, bottom: 14.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          GridListIconRow(setListViewState, IconsEnum.priorityHome),
        ],
      ),
    );
  }

  bool isBeingLongHeld = false;
  void changeLongHoldStatus() {
    setState(() {
      isBeingLongHeld = !isBeingLongHeld;
    });
  }

  void changeLongHoldStatusAndGoToSlideAt(int goToSlide) {
    setState(() {
      isBeingLongHeld = !isBeingLongHeld;
    });
  }

  Widget getCurrentWidgetContent(int currentDisplayIndex) {
    double paddingMultiplier = 0.1;
    if (MediaQuery.of(context).size.height > 1500) {
      paddingMultiplier = 0.4;
    } else if (MediaQuery.of(context).size.height > 1000) {
      paddingMultiplier = 0.3;
    } else if (MediaQuery.of(context).size.height > 750) {
      paddingMultiplier = 0.18;
    } else if (MediaQuery.of(context).size.height > 500) {
      paddingMultiplier = 0.05;
    }
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(
            Icons.add,
          )),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Priorities",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        actions: [
          Row(
            children: [
              //getInfoIcon(),
              getAddNewIcon(),
              getSettingsIcon(),
            ],
          ),
        ],
        automaticallyImplyLeading: false,
      ),
      body: Column(children: [
        Padding(
          padding: EdgeInsets.only(
              bottom: (!Global.priorityIsInListView && !isBeingLongHeld)
                  ? MediaQuery.of(context).size.height * paddingMultiplier
                  : 0.0),
          child: Column(
            children: [
              getSettingsMenu(context),
            ],
          ),
        ),
        Expanded(
          child: (Global.userPriorities.isNotEmpty)
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    (!Global.priorityIsInListView)
                        ? Column(
                            children: [
                              Container(
                                color: Colors.transparent,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 0.0),
                                      child: SizedBox(
                                        height: (!isBeingLongHeld)
                                            ? MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.6
                                            : MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.7,
                                        child: (!isBeingLongHeld)
                                            ? PriorityCarousel(
                                                currentDisplayIndex,
                                                getNotificationFromChildOfSlideChange,
                                                changeLongHoldStatus)
                                            : RowExample(
                                                changeLongHoldStatusAndGoToSlideAt),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        : Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: PriorityExpandedList(isEdit, true),
                            ),
                          ),
                  ],
                )
              : Center(
                  child: NoGoalsPrompt(1),
                ),
        ),
      ]),
    );
  }

  getNotificationFromChildOfSlideChange(int newSlideIndex) {
    setState(() {
      args.currentIndex = newSlideIndex;
    });
  }

  late final args =
      ModalRoute.of(context)!.settings.arguments as PriorityHomeArguments;

  @override
  Widget build(BuildContext context) {
    return getCurrentWidgetContent(args.currentIndex);
  }
}
