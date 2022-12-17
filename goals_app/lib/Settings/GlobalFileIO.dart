import 'dart:io' as io;
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:goals_app/Settings/priorityImages.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import '../Models/BackgroundImageInfo.dart';
import '../Models/Goal.dart';
import '../Models/Priority.dart';
import '../Providers/PriorityProvider.dart';
import '../Settings/AppColors.dart';
import '../Settings/ThemeSwitcher.dart';
import 'global.dart';

class GlobalFileIO {
  static const String prioritiesFile = "priorities.txt";
  static const String firstTimeFile = "firstTime.txt";
  static const String backgroundImageFile = "backgroundImage.txt";
  static const String lightDarkFile = "lightDark.txt";
  static const String primaryColorFile = "primaryColor.txt";

  writePrioritiesFirstTime(BuildContext context) async {
    Provider.of<PriorityProvider>(context, listen: false).priorities = [];

    bool isFirstTime = true;
    String isFirstTimeFromFile = "";

    //First time is either null or '1'
    await readFile(firstTimeFile).then((value) {
      isFirstTimeFromFile = value;
    });
    if (isFirstTimeFromFile == "1") {
      isFirstTime = false;
    } else {
      await writeFirstTime();
    }

    if (isFirstTime) {
      Provider.of<PriorityProvider>(context, listen: false)
          .populatePrioritiesForFirstTimeUser();
    }
  }

  static writeFilesFirstTime() async {
    Global.backgroundImageIndexes.lightModeIndex = 0;
    Global.backgroundImageIndexes.darkModeIndex = 0;
    Global.isDarkMode = 0;
    Global.currentPrimaryColor = 0;
    await writeBackgroundImage();
    await writeDarkMode();
    await writePrimaryColor();
  }

  static readFiles() async {
    bool isFirstTime = true;
    String isFirstTimeFromFile = "";

    //First time is either null or '1'
    await readFile(firstTimeFile).then((value) {
      isFirstTimeFromFile = value;
    });
    if (isFirstTimeFromFile == "1") {
      isFirstTime = false;
    } else {
      await writeFirstTime();
    }

    if (isFirstTime) {
      writeFilesFirstTime();
    }

    await readLightDarkMode();
    await readBackgroundFile();
    await readPrimaryColorFile();
  }

  static List<Priority> getPrioritiesFromFile() {
    List<Priority> prioritiesFromFile = List.empty(growable: true);

    readPriorities().then(
      (value) {
        if (value is! String) {
          for (var element in value) {
            String name = element['name'];
            String imageUrl = element['imageUrl'];
            List goalsDynamic = element['goals'];
            List<Goal> goals = List.empty(growable: true);
            for (var element in goalsDynamic) {
              goals.add(Goal.fromJson(element));
            }
            int priorityIndex = element['priorityIndex'];
            Priority newPriority =
                Priority(name, imageUrl, goals, priorityIndex);

            prioritiesFromFile.add(newPriority);
          }
        }
      },
    );

    return prioritiesFromFile;
  }

  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future<io.File> _localFile(String filePath) async {
    final path = await _localPath;
    return io.File('$path/$filePath');
  }

  static readFile(String filePath) async {
    try {
      final file = await _localFile(filePath);
      bool fileExists = await file.exists();
      if (fileExists) {
        return file.readAsString();
      } else {
        return "notAvailable";
      }
    } catch (e) {
      debugPrint("IO ERROR");
    }
  }

  static Future<io.File> writeFirstTime() async {
    final file = await _localFile(firstTimeFile);
    return file.writeAsString("1");
  }

  static Future<io.File> writeDarkMode() async {
    final file = await _localFile(lightDarkFile);
    if (Global.isDarkMode < 0 || Global.isDarkMode > 1) Global.isDarkMode = 0;
    return file.writeAsString(Global.isDarkMode.toString());
  }

  static Future<io.File> writePrimaryColor() async {
    final file = await _localFile(primaryColorFile);
    return file.writeAsString(Global.currentPrimaryColor.toString());
  }

  static Future<io.File> writeBackgroundImage() async {
    final file = await _localFile(backgroundImageFile);
    return file.writeAsString(json.encode(Global.backgroundImageIndexes));
  }

  static Future<io.File> writePrioritiesToMemory(
      List<Priority> userPriorities) async {
    final file = await _localFile(prioritiesFile);
    file.writeAsString(json.encode(userPriorities));
    return file;
  }

  static readLightDarkMode() async {
    await readFile(lightDarkFile).then(
      (value) {
        try {
          int valueAsInt = int.parse(value);
          Global.isDarkMode = valueAsInt;
        } catch (e) {
          debugPrint(e.toString());
          Global.isDarkMode = 0;
        }
        Global.globalThemeProvider.setSelectedThemeMode(
            ThemeSwitcher.appThemes[Global.isDarkMode].mode);
      },
    );
  }

  static readBackgroundFile() async {
    await readBackgroundIndexes().then(
      (value) {
        try {
          BackgroundImageHolder newHolder =
              BackgroundImageHolder.fromJson(value);
          Global.backgroundImageIndexes = newHolder;
          if (Global.isDarkMode == 0) {
            Global.currentBackgroundImage = PriorityImages
                .listOfBackgroundImages[newHolder.lightModeIndex].url;
          } else if (Global.isDarkMode == 1) {
            Global.currentBackgroundImage = PriorityImages
                .listOfDarkmodeBackgroundImages[newHolder.darkModeIndex].url;
          }
        } catch (e) {
          debugPrint(e.toString());
          Global.currentBackgroundImage =
              PriorityImages.listOfBackgroundImages[0].url;
        }
      },
    );
  }

  static readPrimaryColorFile() async {
    await readFile(primaryColorFile).then(
      (value) {
        try {
          int valueAsInt = int.parse(value);
          Global.currentPrimaryColor = valueAsInt;
        } catch (e) {
          debugPrint(e.toString());
          Global.currentPrimaryColor = 0;
        }
        Global.globalThemeProvider.setSelectedPrimaryColor(
            AppColors.primaryColors[Global.currentPrimaryColor]);
      },
    );
  }

  static Future readBackgroundIndexes() async {
    try {
      final file = await _localFile(backgroundImageFile);
      String contents = await file.readAsString();
      var jsonResponse = jsonDecode(contents);
      return jsonResponse;
    } catch (e) {
      debugPrint(e.toString());
      return "ERROR - DIDNT READ CORRECTLY";
    }
  }

  static Future readPriorities() async {
    try {
      final file = await _localFile(prioritiesFile);
      String contents = await file.readAsString();
      var jsonResponse = jsonDecode(contents);
      return jsonResponse;
    } catch (e) {
      return "0";
    }
  }
}
