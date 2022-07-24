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
    return Container(
        height: MediaQuery.of(context).size.height * 0.4,
        child: Image.network(currentImage, fit: BoxFit.fitWidth));
  } else {
    return Image.file(File(currentImage), fit: BoxFit.fitWidth);
  }
}

class _IndividualPriority extends State<IndividualPriority> {
  @override
  Widget build(BuildContext context) {
    late final args = ModalRoute.of(context)!.settings.arguments
        as IndividualPriorityArgumentScreen;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pushNamed(context, '/'),
        ),
        //title: Text(Global.userPriorities[args.index].name),
        actions: [
          IconButton(
              onPressed: () => {
                    Navigator.pushNamed(context, EditPriorityScreen.routeName,
                        arguments: PriorityScreenArguments(
                            Global.userPriorities[args.index], args.index))
                  },
              icon: const Icon(Icons.edit)),
          IconButton(
              onPressed: () => {
                    Global.userPriorities.removeAt(args.index),
                    Navigator.pushNamed(context, '/'),
                  },
              icon: const Icon(Icons.delete),
              color: Colors.redAccent),
        ],
      ),
      body: ListView(
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
    );
  }
}
