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
    for (int i = 0; i < Global.listOfBackgroundImages.length; i++) {
      backgroundImageUrls.add(Global.listOfBackgroundImages[i].url);
    }
  }

  void changeBackground() {
    setState(() {});
    Global.writeBackgroundImage();
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
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Settings",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: (Global.isPhone) ? 22 : 36,
            ),
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
            icon: const Icon(Icons.arrow_back, color: Colors.white),
          ),
          automaticallyImplyLeading: false,
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
                      color: Colors.black,
                      fontSize: (Global.isPhone) ? 14 : 24,
                    ),
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8.0,
                        bottom: 8.0,
                        right: 15,
                      ),
                      child: ThemeSwitcher(75),
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
                    child: Text("Change Background Image",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: (Global.isPhone) ? 14 : 24)),
                  ),
                  children: [
                    BackgroundCarousel(
                      backgroundImageUrls,
                      (Global.isPhone) ? 200 : 350,
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
