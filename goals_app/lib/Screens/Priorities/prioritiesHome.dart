import 'package:flutter/material.dart';
import 'package:goals_app/Screens/Priorities/rowExample.dart';
import 'package:goals_app/Widgets/Priorities/priorityCard.dart';
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
  bool isList = false;
  bool areSettingsOpen = false;

  @override
  void initState() {
    for (Priority priority in Global.userPriorities) {
      priorities.add(priority);
    }
    super.initState();
  }

  @override
  void setState(VoidCallback fn) {
    priorities.clear();
    for (Priority priority in Global.userPriorities) {
      priorities.add(priority);
    }
    super.setState(fn);
  }

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
      this.isList = isList;
      if (isList) isBeingLongHeld = false;
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

  getSettingsIcon() {
    return IconButton(
      padding: const EdgeInsets.only(right: 12.0),
      constraints: const BoxConstraints(),
      onPressed: () => {},
      icon: const Icon(Icons.settings, size: 22.0),
    );
  }

  getSettingsMenu(BuildContext context) {
    return
        // (areSettingsOpen)
        //     ?
        Padding(
      padding: const EdgeInsets.only(top: 14.0, bottom: 14.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // if (isBeingLongHeld)
          //   IconButton(
          //       onPressed: () => {
          //             setState(() {
          //               isBeingLongHeld = !isBeingLongHeld;
          //             })
          //           },
          //       icon: const Icon(Icons.save)),
          GridListIconRow(setListViewState, IconsEnum.priorityHome),
        ],
      ),
    );
    //: const Text("");
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
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () => {
                Navigator.pushNamed(context, '/new-priority'),
              },
          foregroundColor: Colors.white,
          child: const Icon(Icons.add)),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Priorities",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        actions: [
          Row(
            children: [
              getInfoIcon(),
              getSettingsIcon(),
            ],
          ),
        ],
        automaticallyImplyLeading: false,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          getSettingsMenu(context),
          (!isList)
              ? Expanded(
                  child: Container(
                    color: Colors.transparent,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 0.0),
                          child: SizedBox(
                            height: (!isBeingLongHeld)
                                ? MediaQuery.of(context).size.height * 0.6
                                : MediaQuery.of(context).size.height * 0.7,
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
                )
              : Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: PriorityExpandedList(isEdit),
                  ),
                ),
          // Padding(
          //     padding: const EdgeInsets.all(8.0),
          //     child: PriorityExpandedList(isEdit),
          //   ),

          //Priority List
          //PriorityExpandedList(priorities),

          //Edit / Reorder List
          //ReorderScreen(saveAndDelete),
        ],
      ),
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
