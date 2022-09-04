import 'package:flutter/material.dart';
import 'package:goals_app/Screens/ArgumentPassThroughScreens/priorityHomeArguments.dart';
import 'package:goals_app/Screens/ArgumentPassThroughScreens/settingsScreenArguements.dart';
import 'package:goals_app/Screens/Priorities/prioritiesHome.dart';
import 'package:goals_app/Screens/Priorities/prioritiesHome.dart';

class OptionsScreen extends StatefulWidget {
  static const routeName = "/extractOptionsArguements";
  @override
  State<StatefulWidget> createState() {
    return _OptionsScreen();
  }
}

class _OptionsScreen extends State<OptionsScreen> {
  late final args =
      ModalRoute.of(context)!.settings.arguments as SettingsScreenArguements;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Settings",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
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
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(40),
              ),
              onPressed: null,
              child: const Text("Change Theme Color (Coming Soon)"),
            ),
            const Divider(thickness: 1, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
