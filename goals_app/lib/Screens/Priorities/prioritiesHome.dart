import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:goals_app/Providers/PriorityProvider.dart';
import 'package:goals_app/Screens/ArgumentPassThroughScreens/settingsScreenArguements.dart';
import 'package:goals_app/Screens/Priorities/reorderPrioritiesScreen.dart';
import 'package:goals_app/Models/Priority.dart';
import 'package:goals_app/Widgets/Priorities/priorityCarousel.dart';
import 'package:provider/provider.dart';

import '../../Settings/global.dart';
import '../settingsScreen.dart';

class PriorityHomeScreen extends StatefulWidget {
  PriorityHomeScreen({Key? key}) : super(key: key);
  PriorityHomeScreen.fromOtherRoute(this.currentStartIndex, {Key? key})
      : super(key: key);
  int currentStartIndex = 0;

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
  int currPriorityIndex = 0;

  @override
  void initState() {
    priorities.clear();
    priorities =
        Provider.of<PriorityProvider>(context, listen: false).priorities;
    priorities.sort((a, b) => a.priorityIndex.compareTo(b.priorityIndex));

    if (widget.currentStartIndex != 0) {
      currPriorityIndex = widget.currentStartIndex;
    }
    super.initState();
  }

  @override
  void didChangeDependencies() {
    priorities =
        Provider.of<PriorityProvider>(context, listen: false).priorities;
    priorities.sort((a, b) => a.priorityIndex.compareTo(b.priorityIndex));

    super.didChangeDependencies();
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

  goToAddPrioritiesScreen() {
    Navigator.pushNamed(context, '/new-priority');
  }

  getSettingsIcon() {
    return IconButton(
      padding: const EdgeInsets.only(right: 12.0),
      constraints: const BoxConstraints(),
      onPressed: () => {
        Navigator.pushNamed(context, SettingsScreen.routeName,
            arguments: SettingsScreenArguements(widget.currentStartIndex)),
      },
      icon: Icon(
        Icons.settings,
        color: Theme.of(context).textTheme.displayMedium?.color,
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
    double mediaPixelVar = MediaQuery.of(context).devicePixelRatio - 1.75;
    if (mediaPixelVar < 1) {
      mediaPixelVar = 1;
    }
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
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              goToAddPrioritiesScreen();
            },
            child: const Icon(
              Icons.add,
            )),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(Global.toolbarHeight),
          child: AppBar(
            toolbarHeight: Global.toolbarHeight,
            centerTitle: true,
            title: Text(
              "Priorities",
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            actions: [
              Row(
                children: [
                  getSettingsIcon(),
                ],
              ),
            ],
            automaticallyImplyLeading: false,
          ),
        ),
        body: Column(children: [
          if (Global.isPhone &&
              !Global.priorityIsInListView &&
              !isBeingLongHeld)
            SizedBox(
              height:
                  Device.screenHeight < 900 && Device.devicePixelRatio < 2.75
                      ? MediaQuery.of(context).size.height * 0.1
                      : MediaQuery.of(context).size.height * 0.05,
            ),
          Expanded(
            child: (Provider.of<PriorityProvider>(context, listen: true)
                    .priorities
                    .isNotEmpty)
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
                                        padding:
                                            const EdgeInsets.only(top: 0.0),
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
                                                  changeLongHoldStatus,
                                                )
                                              : ReorderableGridOfCards(
                                                  changeLongHoldStatusAndGoToSlideAt,
                                                ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          : const Expanded(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text("NOT HERE"),
                              ),
                            ),
                    ],
                  )
                : Center(
                    child: Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Column(
                        children: [
                          Text(
                            "Press the \"+\" to \ncreate a new Priority!",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontStyle: FontStyle.italic,
                              fontSize: (Global.isPhone) ? 18 : 24,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
          ),
        ]),
      ),
      //),
    );
  }

  getNotificationFromChildOfSlideChange(int newSlideIndex) {
    setState(() {
      widget.currentStartIndex = newSlideIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return getCurrentWidgetContent(widget.currentStartIndex);
  }
}
