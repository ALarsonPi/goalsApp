import 'dart:io';

import 'package:flutter/material.dart';
import 'package:goals_app/Screens/Priorities/editPriority.dart';
import 'package:goals_app/global.dart';
import '../ArgumentPassThroughScreens/editPriotitiesArguments.dart';
import '../ArgumentPassThroughScreens/individualPriorityArgumentScreen.dart';

class IndividualPriority extends StatefulWidget {
  static const routeName = "/extractPriorityIndex";

  const IndividualPriority({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _IndividualPriority();
  }
}

getImageWidget(int priorityIndex, BuildContext context) {
  String currentImage = Global.userPriorities[priorityIndex].imageUrl;
  if (currentImage.contains("http")) {
    return DecorationImage(
        image: NetworkImage(currentImage), fit: BoxFit.fitWidth);
  } else {
    return DecorationImage(
        image: FileImage(
          File(currentImage),
        ),
        fit: BoxFit.fitWidth);
  }
}

class _IndividualPriority extends State<IndividualPriority> {
  @override
  Widget build(BuildContext context) {
    late final args = ModalRoute.of(context)!.settings.arguments
        as IndividualPriorityArgumentScreen;
    return Scaffold(
      body:
          // SafeArea(
          //   child:
          Column(
        children: [
          Container(
            decoration: BoxDecoration(
              image: getImageWidget(args.index, context),
            ),
            height: MediaQuery.of(context).size.height * 0.4,
            width: double.infinity,
            child: Stack(
              children: [
                //Icons
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          IconButton(
                              onPressed: () => {
                                    Navigator.pushNamed(context, '/'),
                                  },
                              icon: const Icon(Icons.arrow_back),
                              color: Colors.white),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                              onPressed: () => {
                                    Navigator.pushNamed(
                                        context, EditPriorityScreen.routeName,
                                        arguments: PriorityScreenArguments(
                                            Global.userPriorities[args.index],
                                            args.index))
                                  },
                              icon: const Icon(Icons.edit),
                              color: Colors.white),
                          IconButton(
                              onPressed: () => {
                                    Global.userPriorities.removeAt(args.index),
                                    Navigator.pushNamed(context, '/'),
                                  },
                              icon: const Icon(Icons.delete),
                              color: Colors.redAccent),
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 24.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            color: const Color(0xFFD9D9D9),
                            height: MediaQuery.of(context).size.height * 0.25,
                            width: MediaQuery.of(context).size.width * 0.55,
                            child: Center(
                              child: Text(
                                  Global.userPriorities[args.index].name,
                                  style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Center(
                    child: Text(Global.userPriorities[args.index].name,
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      //),
    );
  }
}
