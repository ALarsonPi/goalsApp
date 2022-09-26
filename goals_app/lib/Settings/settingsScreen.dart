import 'package:flutter/material.dart';
import 'package:goals_app/Screens/ArgumentPassThroughScreens/settingsScreenArguements.dart';
import 'package:goals_app/Screens/Priorities/prioritiesHome.dart';
import 'package:goals_app/Settings/PrimaryColorSwitcher.dart';
import 'package:goals_app/Settings/ThemeSwitcher.dart';
import 'package:goals_app/Settings/backgroundCarousel.dart';

import '../global.dart';

class SettingsScreen extends StatefulWidget {
  static const routeName = "/extractOptionsArguements";

  const SettingsScreen({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _SettingsScreen();
  }
}

class _SettingsScreen extends State<SettingsScreen> {
  late final args =
      ModalRoute.of(context)!.settings.arguments as SettingsScreenArguements;

  List<String> backgroundImageUrls = List.empty(growable: true);

  @override
  void initState() {
    super.initState();
    refreshBackgroundImages();
  }

  void changeBackground() {
    setState(() {});
    Global.writeBackgroundImage();
  }

  void changeColorMode() {
    refreshBackgroundImages();

    if (Global.isDarkMode == 0) {
      Global.currentBackgroundImage = Global
          .listOfBackgroundImages[Global.backgroundImageIndexes.lightModeIndex]
          .url;
    } else if (Global.isDarkMode == 1) {
      Global.currentBackgroundImage = Global
          .listOfDarkmodeBackgroundImages[
              Global.backgroundImageIndexes.darkModeIndex]
          .url;
    }
    changeBackground();
    setState(() {});
  }

  void refreshBackgroundImages() {
    List<pictureHolder> backgroundImages = (Global.isDarkMode == 0)
        ? Global.listOfBackgroundImages
        : Global.listOfDarkmodeBackgroundImages;
    backgroundImageUrls.clear();
    for (pictureHolder holder in backgroundImages) {
      backgroundImageUrls.add(holder.url);
    }
  }

  @override
  Widget build(BuildContext context) {
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
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(Global.toolbarHeight),
          child: AppBar(
            toolbarHeight: Global.toolbarHeight,
            centerTitle: true,
            title: Text(
              "Settings",
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            leading: IconButton(
              onPressed: () => {
                Navigator.push<void>(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) =>
                        PriorityHomeScreen.fromOtherRoute(
                            args.currentPriorityIndex),
                  ),
                ),
              },
              icon: Icon(
                Icons.arrow_back,
                color: Theme.of(context).textTheme.displaySmall?.color,
              ),
            ),
            automaticallyImplyLeading: false,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: ListView(
            shrinkWrap: true,
            children: [
              Container(
                padding: const EdgeInsets.only(
                  left: 15,
                ),
                color: Colors.grey.withOpacity(0.4),
                child: ExpansionTile(
                  initiallyExpanded: false,
                  title: Text(
                    "Change Theme Color",
                    style: TextStyle(
                      color: Theme.of(context).textTheme.displaySmall?.color,
                      fontSize:
                          Theme.of(context).textTheme.displaySmall?.fontSize,
                    ),
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8.0,
                        bottom: 8.0,
                        right: 15,
                      ),
                      child: ThemeSwitcher(75, changeColorMode),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 15.0),
                      child: PrimaryColorSwitcher(75),
                    ),
                  ],
                ),
              ),
              const Divider(thickness: 1, color: Colors.grey),
              Container(
                color: Colors.grey.withOpacity(0.4),
                child: ExpansionTile(
                  initiallyExpanded: false,
                  title: Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Text(
                      "Change Background Image",
                      style: TextStyle(
                        color: Theme.of(context).textTheme.displaySmall?.color,
                        fontSize:
                            Theme.of(context).textTheme.displaySmall?.fontSize,
                      ),
                    ),
                  ),
                  children: [
                    BackgroundCarousel(
                      backgroundImageUrls,
                      (Global.isPhone) ? 200 : 250,
                      true,
                      changeBackground,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
