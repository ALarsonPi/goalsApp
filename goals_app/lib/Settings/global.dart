import 'dart:convert';
import 'dart:io' as io;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:goals_app/Settings/ThemeSwitcher.dart';
import 'package:goals_app/Settings/priorityImages.dart';
import 'package:path_provider/path_provider.dart';
import '../Models/BackgroundImageInfo.dart';
import '../Models/CustomStack.dart';
import '../Models/PictureHolderObject.dart';
import '../Models/Priority.dart';
import '../Models/Goal.dart';
import 'AppColors.dart';
import '../Providers/ThemeProvider.dart';

class Global {
  static final expandedPrioritiesBucketGlobal = PageStorageBucket();
  static Map listOfImageLists = {
    "People Pictures": PriorityImages.listOfPeoplePictures,
    "Nature/Animal Images": PriorityImages.listOfNaturePictures,
    "Activities": PriorityImages.listOfHobbyPictures,
    "Study Images": PriorityImages.listOfStudyPictures,
    "Food Images": PriorityImages.listOfFoodPictures,
  };

  static ThemeProvider globalThemeProvider = ThemeProvider();
  static int isDarkMode = 0;
  static int currentPrimaryColor = 0;
  static bool isPhone = Device.get().isPhone;
  static double toolbarHeight = (isPhone) ? 65.0 : 85.0;
  static double buttonHeight = (isPhone) ? 40.0 : 60.0;
  static List<Priority> userPriorities = List.empty(growable: true);
  static CustomStack<Goal> depthStack = CustomStack();
  static bool goalButtonsInGridView = false;
  static bool priorityIsInListView = false;

  static String currentBackgroundImage =
      PriorityImages.listOfBackgroundImages[4].url;
  static BackgroundImageHolder backgroundImageIndexes = BackgroundImageHolder();

  static const String prioritiesFile = "priorities.txt";
  static const String firstTimeFile = "firstTime.txt";
  static const String backgroundImageFile = "backgroundImage.txt";
  static const String lightDarkFile = "lightDark.txt";
  static const String primaryColorFile = "primaryColor.txt";

  static int getSumOfChildrenProgress(Goal goal) {
    return getSumOfChildrenRecursiveHelper(goal.subGoals, 0, true);
  }

  static int getSumOfChildrenTarget(Goal goal) {
    return getSumOfChildrenRecursiveHelper(goal.subGoals, 0, false);
  }

  static MaterialColor getPrimaryColorSwatch() {
    return AppColors.getMaterialColorFromColor(
        globalThemeProvider.selectedPrimaryColor);
  }

  static int getSumOfChildrenRecursiveHelper(
      List<Goal> subGoals, int currTotal, bool forProgress) {
    for (Goal currGoal in subGoals) {
      if (currGoal.subGoals.isEmpty) {
        if (forProgress) {
          currTotal += int.parse(currGoal.goalProgress);
        } else {
          currTotal += int.parse(currGoal.goalTarget);
        }
      } else {
        currTotal += getSumOfChildrenRecursiveHelper(
            currGoal.subGoals, currTotal, forProgress);
      }
    }
    return currTotal;
  }

  static bool removeGoal(int currPriorityIndex, Goal goalToRemove) {
    List<Goal> priorityGoals =
        userPriorities.elementAt(currPriorityIndex).goals;
    //If we find the goal is directly in the priority, remove it there
    int index = 0;
    for (Goal currGoal in priorityGoals) {
      if (currGoal == goalToRemove) {
        userPriorities.elementAt(currPriorityIndex).goals.removeAt(index);
        return true;
      }
      index++;
    }

    //if not, it's a child of another goal, and we need to find it in the tree
    //If it's never found, return true so we just navegate back to the main priority
    recursiveRemoveGoalHelper(
        userPriorities[currPriorityIndex].goals, goalToRemove);
    return !isFoundRecursively;
  }

  static findIndexOfGoalRecursive(List<Goal> goalsList, Goal goalToRemove) {
    for (var goal in goalsList) {
      if (goal.subGoals.isNotEmpty) {
        int subGoalIndex = 0;
        for (Goal subGoal in goal.subGoals) {
          if (subGoal == goalToRemove) {
            isFoundRecursively = true;
            return true;
          }
          subGoalIndex++;
        }
        recursiveRemoveGoalHelper(goal.subGoals, goalToRemove);
      }
    }
    return false;
  }

  static bool removeGoalFirestore(Goal goalToRemove) {
    int priorityIndex = 0;

    bool isFound = false;
    for (Priority priority in userPriorities) {
      if (priority.goals.contains(goalToRemove)) {
        priorityIndex = priority.priorityIndex;
        isFound = true;
      }
    }

    for (int i = 0; i < userPriorities.length; i++) {
      if (findIndexOfGoalRecursive(userPriorities[i].goals, goalToRemove)) {
        priorityIndex = i;
      }
    }
    isFoundRecursively = false;

    Priority parentPriority = userPriorities.elementAt(priorityIndex);
    bool returnValue = removeGoal(parentPriority.priorityIndex, goalToRemove);

    return returnValue;
  }

  static bool isFoundRecursively = false;
  static recursiveRemoveGoalHelper(List<Goal> goalsList, Goal goalToRemove) {
    for (Goal currGoal in goalsList) {
      if (currGoal.subGoals.isNotEmpty) {
        int subGoalIndex = 0;
        for (Goal subGoal in currGoal.subGoals) {
          if (subGoal == goalToRemove) {
            currGoal.subGoals.removeAt(subGoalIndex);
            int currentGoalTarget = int.parse(currGoal.goalTarget);
            if (currentGoalTarget != 1) {
              currGoal.setGoalTarget((currentGoalTarget - 1).toString());
            }
            isFoundRecursively = true;
            return true;
          }
          subGoalIndex++;
        }
        recursiveRemoveGoalHelper(currGoal.subGoals, goalToRemove);
      }
    }
    return false;
  }

  static addPriority(Priority newPriority) {
    userPriorities.add(newPriority);
    writePrioritiesToMemory();
  }

  static updatePriorityIndexes() {
    for (int i = 0; i < userPriorities.length; i++) {
      userPriorities[i].priorityIndex = i;
      updateGoalPrioritiesInAppData(userPriorities[i], i);
    }
    writePrioritiesToMemory();
  }

  static correctPriorityProgressInTree(
      int indexOfPriorityToCorrect, bool shouldCorrectTarget) {
    Priority currPriority = userPriorities.elementAt(indexOfPriorityToCorrect);

    correctPriorityProgressRecursiveHelper(
        currPriority.goals, shouldCorrectTarget);
    writePrioritiesToMemory();
  }

  static correctPriorityProgressRecursiveHelper(
      List<Goal> subgoals, bool shouldCorrectTarget) {
    for (Goal goal in subgoals) {
      if (goal.subGoals.isEmpty) return;
      correctPriorityProgressRecursiveHelper(
          goal.subGoals, shouldCorrectTarget);

      goal.goalProgress = getSumOfChildrenProgress(goal).toString();
      if (shouldCorrectTarget) {
        goal.goalTarget = getSumOfChildrenTarget(goal).toString();
      }
    }
  }

  static updateGoalPrioritiesInAppData(
      Priority parentPriority, int correctIndex) {
    recursiveUpdateGoalPriorityIndexHelper(parentPriority.goals, correctIndex);
  }

  static recursiveUpdateGoalPriorityIndexHelper(
      List<Goal> goalsList, int correctPriorityIndex) {
    //for every goal, if it's priorityIndex is wrong, fix it
    //if a goal has a subgoal, do the same for it's subgoals
    for (Goal currGoal in goalsList) {
      currGoal.currPriorityIndex = correctPriorityIndex;
      if (currGoal.subGoals.isNotEmpty) {
        recursiveUpdateGoalPriorityIndexHelper(
            currGoal.subGoals, correctPriorityIndex);
      }
    }
  }

  static addGoalToPriority(Priority priorityOfInterest, Goal newGoal) {
    priorityOfInterest.goals.add(newGoal);
    writePrioritiesToMemory();
  }

  static removePriority(Priority priorityToRemove) async {
    int index = userPriorities.indexOf(priorityToRemove);
    userPriorities.removeAt(index);
    await writePrioritiesToMemory();
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
    return file.writeAsString(isDarkMode.toString());
  }

  static Future<io.File> writePrimaryColor() async {
    final file = await _localFile(primaryColorFile);
    return file.writeAsString(currentPrimaryColor.toString());
  }

  static Future<io.File> writeBackgroundImage() async {
    final file = await _localFile(backgroundImageFile);
    return file.writeAsString(json.encode(backgroundImageIndexes));
  }

  static Future<io.File> writePrioritiesToMemory() async {
    final file = await _localFile(prioritiesFile);
    file.writeAsString(json.encode(userPriorities));
    return file;
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

  static populatePrioritiesForFirstTimeUser() async {
    List<Goal> emptyGoalsList = List.empty(growable: true);

    userPriorities.add(
      Priority(
          "Social",
          "https://images.unsplash.com/photo-1619537903549-0981d6bca911?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80",
          emptyGoalsList,
          0),
    );
    userPriorities.add(
      Priority(
          "Physical",
          "https://images.unsplash.com/photo-1502224562085-639556652f33?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cnVufGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=800&q=60",
          emptyGoalsList,
          1),
    );

    userPriorities.add(
      Priority(
          "Intellectual",
          "https://images.unsplash.com/photo-1523240795612-9a054b0db644?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80",
          emptyGoalsList,
          2),
    );

    userPriorities.add(
      Priority("Emotional", "https://placedog.net/900/1200?id=36",
          emptyGoalsList, 3),
    );

    List<Goal> nonEmptyGoal = List.empty(growable: true);
    Goal newGoal =
        Goal("name", 0, "1", "2", "whyToComplete", "whenToComplete", false);
    nonEmptyGoal.add(newGoal);
    userPriorities.add(
      Priority(
          "Spiritual",
          "https://images.unsplash.com/photo-1657199372069-bd8cb49315c4?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=600&q=80",
          nonEmptyGoal,
          4),
    );
    await writePrioritiesToMemory();
    userPriorities.clear();
  }

  static readLightDarkMode() async {
    await readFile(lightDarkFile).then(
      (value) {
        try {
          int valueAsInt = int.parse(value);
          isDarkMode = valueAsInt;
        } catch (e) {
          debugPrint(e.toString());
          isDarkMode = 0;
        }
        globalThemeProvider
            .setSelectedThemeMode(ThemeSwitcher.appThemes[isDarkMode].mode);
      },
    );
  }

  static readBackgroundFile() async {
    await readBackgroundIndexes().then(
      (value) {
        try {
          BackgroundImageHolder newHolder =
              BackgroundImageHolder.fromJson(value);
          backgroundImageIndexes = newHolder;
          if (isDarkMode == 0) {
            currentBackgroundImage = PriorityImages
                .listOfBackgroundImages[newHolder.lightModeIndex].url;
          } else if (isDarkMode == 1) {
            currentBackgroundImage = PriorityImages
                .listOfDarkmodeBackgroundImages[newHolder.darkModeIndex].url;
          }
        } catch (e) {
          debugPrint(e.toString());
          currentBackgroundImage = PriorityImages.listOfBackgroundImages[0].url;
        }
      },
    );
  }

  static readPrimaryColorFile() async {
    await readFile(primaryColorFile).then(
      (value) {
        try {
          int valueAsInt = int.parse(value);
          currentPrimaryColor = valueAsInt;
        } catch (e) {
          debugPrint(e.toString());
          currentPrimaryColor = 0;
        }
        globalThemeProvider.setSelectedPrimaryColor(
            AppColors.primaryColors[currentPrimaryColor]);
      },
    );
  }

  static getPriorities() async {
    userPriorities.clear();
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
      await populatePrioritiesForFirstTimeUser();
      backgroundImageIndexes.lightModeIndex = 0;
      backgroundImageIndexes.darkModeIndex = 0;
      isDarkMode = 0;
      currentPrimaryColor = 0;
      await writeBackgroundImage();
      await writeDarkMode();
      await writePrimaryColor();
    }

    await readLightDarkMode();
    await readBackgroundFile();
    await readPrimaryColorFile();

    await readPriorities().then(
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

            userPriorities.add(newPriority);
          }
        }
      },
    );
  }
}
