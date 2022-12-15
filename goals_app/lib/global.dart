import 'dart:convert';
import 'dart:io' as io;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:goals_app/Settings/ThemeSwitcher.dart';
import 'package:path_provider/path_provider.dart';
import 'Objects/Priority.dart';
import 'Objects/Goal.dart';
import 'Settings/AppColors.dart';
import 'Providers/ThemeProvider.dart';

class Global {
  static final expandedPrioritiesBucketGlobal = PageStorageBucket();
  static Map listOfImageLists = {
    "People Pictures": listOfPeoplePictures,
    "Nature/Animal Images": listOfNaturePictures,
    "Activities": listOfHobbyPictures,
    "Study Images": listOfStudyPictures,
    "Food Images": listOfFoodPictures,
  };

  static List<pictureHolder> listOfDarkmodeBackgroundImages = [
    pictureHolder(
      "https://images.unsplash.com/photo-1531306728370-e2ebd9d7bb99?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8YW5pbWF0ZWQlMjBiYWNrZ3JvdW5kfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=700&q=60",
      "Space",
    ),
    pictureHolder(
      "https://images.unsplash.com/photo-1507608158173-1dcec673a2e5?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTF8fGFuaW1hdGVkJTIwYmFja2dyb3VuZHxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=700&q=60",
      "Dark Blue Rain",
    ),
    pictureHolder(
        "https://images.unsplash.com/photo-1504470695779-75300268aa0e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Nnx8ZGFyayUyMGJhY2tncm91bmR8ZW58MHx8MHx8&auto=format&fit=crop&w=800&q=60",
        "Fire"),
    pictureHolder(
        "https://images.unsplash.com/photo-1502899576159-f224dc2349fa?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8N3x8ZGFyayUyMGJhY2tncm91bmR8ZW58MHx8MHx8&auto=format&fit=crop&w=800&q=60",
        "New York Skyline Evening"),
    pictureHolder(
        "https://images.unsplash.com/photo-1472552944129-b035e9ea3744?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8bmlnaHQlMjBza3l8ZW58MHx8MHx8&auto=format&fit=crop&w=800&q=60",
        "Cloud then Space"),
    pictureHolder(
        "https://images.unsplash.com/photo-1419242902214-272b3f66ee7a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8N3x8bmlnaHQlMjBza3l8ZW58MHx8MHx8&auto=format&fit=crop&w=800&q=60",
        "Violet Skyline"),
    pictureHolder(
        "https://images.unsplash.com/photo-1436891620584-47fd0e565afb?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTF8fG5pZ2h0JTIwc2t5fGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=800&q=60",
        "Mountain Still night"),
    //pictureHolder("", ""),
  ];

  static List<pictureHolder> listOfBackgroundImages = [
    pictureHolder(
        "https://images.unsplash.com/photo-1538947151057-dfe933d688d1?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTJ8fGJsdWV8ZW58MHx8MHx8&auto=format&fit=crop&w=800&q=60",
        "Chill Blue Morning"),
    pictureHolder(
      "https://images.unsplash.com/photo-1518627675569-e9d4fb90cdb5?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MjB8fHBhc3RlbHxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=700&q=60",
      "Snowy Sunset Forest",
    ),
    pictureHolder(
      "https://images.unsplash.com/photo-1497384401032-2182d2687715?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTN8fGFuaW1hdGVkJTIwYmFja2dyb3VuZHxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=700&q=60",
      "Foggy Red Mountain",
    ),
    pictureHolder(
      "https://images.unsplash.com/photo-1528460033278-a6ba57020470?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8OHx8YW5pbWF0ZWQlMjBiYWNrZ3JvdW5kfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=700&q=60",
      "Sky Blue",
    ),
    pictureHolder(
      "https://images.unsplash.com/photo-1517639493569-5666a7b2f494?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cGFzdGVsfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=700&q=60",
      "Bright Clouds",
    ),
    pictureHolder(
      "https://images.unsplash.com/photo-1546514355-7fdc90ccbd03?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTl8fHBhc3RlbHxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=700&q=60",
      "Snowy Mountain Red",
    ),
    pictureHolder(
      "https://images.unsplash.com/photo-1614481327033-68e5df399653?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8cGFzdGVsfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=700&q=60",
      "Rainbow Leaves",
    ),
  ];

  static List<pictureHolder> listOfPeoplePictures = [
    pictureHolder(
        "https://images.unsplash.com/photo-1591035897819-f4bdf739f446?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80",
        "Girls laughing in sunflowers"),
    pictureHolder(
        "https://images.unsplash.com/photo-1466193341027-56e68017ee2d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80",
        "Woman taking a deep breath on a beach"),
    pictureHolder(
        "https://images.unsplash.com/photo-1502902020937-d77a834d5e5f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80",
        "Falling?"),
    pictureHolder(
        "https://i.picsum.photos/id/1004/1200/800.jpg?hmac=XzDs6RyPJPGVeW2xChNhSRZX1uyM1LFCsY7QfF1Qo9E",
        "Kissing in the Snow"),
    pictureHolder(
        "https://images.unsplash.com/photo-1619537903549-0981d6bca911?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80",
        "Campfire gettogether"),
    pictureHolder(
        "https://picsum.photos/id/1001/1200/800", "Man with son on beach"),
    pictureHolder(
        "https://picsum.photos/id/1066/1200/800", "Father with son in crib"),
    pictureHolder("https://picsum.photos/id/129/1200/800",
        "Man and woman chilling on a bench"),
  ];

  static List<pictureHolder> listOfNaturePictures = [
    pictureHolder("https://placedog.net/900/1200?id=36", "Dog Image 1"),
    pictureHolder(
        "https://images.unsplash.com/photo-1657199372069-bd8cb49315c4?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=600&q=80",
        "Mountain"),
    pictureHolder(
        "https://images.unsplash.com/photo-1591208333284-825682219525?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1476&q=80",
        "Dog staring down human"),
    pictureHolder("https://picsum.photos/id/237/1200/800", "Dog"),
    pictureHolder("https://picsum.photos/id/191/500/600", "Road"),
    pictureHolder("https://picsum.photos/id/1039/500/600", "Forest"),
    pictureHolder("https://picsum.photos/id/152/500/600", "Flowers"),
    pictureHolder("https://placedog.net/800/640?id=177", "Dog Image 2"),
  ];

  static List<pictureHolder> listOfFoodPictures = [
    pictureHolder(
        "https://images.unsplash.com/photo-1533777857889-4be7c70b33f7?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80",
        "Woman enjoying pasta"),
    pictureHolder("https://picsum.photos/id/493/1200/800", "Strawberry Cereal"),
    pictureHolder(
        "https://images.unsplash.com/photo-1540189549336-e6e99c3679fe?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8N3x8Zm9vZHxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=800&q=60",
        "Stir Fry and Orange Juice"),
    pictureHolder(
        "https://images.unsplash.com/photo-1567620905732-2d1ec7ab7445?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8Zm9vZHxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=800&q=60",
        "Pancakes"),
    pictureHolder(
        "https://images.unsplash.com/photo-1484723091739-30a097e8f929?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTN8fGZvb2R8ZW58MHx8MHx8&auto=format&fit=crop&w=800&q=60",
        'French Toast'),
    pictureHolder("https://picsum.photos/id/312/500/600", "Honey"),
    pictureHolder(
        "https://images.unsplash.com/photo-1473093295043-cdd812d0e601?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTh8fGZvb2R8ZW58MHx8MHx8&auto=format&fit=crop&w=800&q=60",
        "Healthy Pasta"),
    pictureHolder("https://picsum.photos/id/1080/500/600", "Strawberries"),
    pictureHolder(
        "https://images.unsplash.com/photo-1498837167922-ddd27525d352?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTZ8fGZvb2R8ZW58MHx8MHx8&auto=format&fit=crop&w=800&q=60",
        "Veggies on Display"),
  ];

  static List<pictureHolder> listOfStudyPictures = [
    pictureHolder(
        "https://images.unsplash.com/photo-1523240795612-9a054b0db644?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80",
        "Laughing in a library"),
    pictureHolder(
        "https://images.unsplash.com/photo-1472745433479-4556f22e32c2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTZ8fHJlYWRpbmd8ZW58MHx8MHx8&auto=format&fit=crop&w=800&q=60",
        "Reading on Bench"),
    pictureHolder("https://picsum.photos/id/3/800/800", "Tech"),
    pictureHolder(
        "https://images.unsplash.com/photo-1560439450-57df7ac6dbef?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80",
        "2 college girls, studying, one is doing the peace sign"),
    pictureHolder("https://picsum.photos/id/367/800/800", "Kindle"),
    pictureHolder("https://picsum.photos/id/180/500/800", "Laptop Study"),
    pictureHolder(
        "https://images.unsplash.com/photo-1521714161819-15534968fc5f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTh8fHJlYWRpbmd8ZW58MHx8MHx8&auto=format&&w=1600&q=60",
        "SpiderMan Reading"),
    pictureHolder("https://picsum.photos/id/24/500/800", "Book"),
    pictureHolder("https://picsum.photos/id/259/800/800",
        "Dude on bench in NYC with Snow"),
  ];

  static List<pictureHolder> listOfHobbyPictures = [
    pictureHolder(
        "https://images.unsplash.com/photo-1520207588543-1e545b20c19e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1471&q=80",
        "Painting art"),
    pictureHolder(
        "https://images.unsplash.com/photo-1502224562085-639556652f33?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cnVufGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=800&q=60",
        "Running"),
    pictureHolder(
        "https://images.unsplash.com/photo-1612872087720-bb876e2e67d1?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NDJ8fHNwb3J0fGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=800&q=60",
        "Volleyball"),
    pictureHolder(
        "https://images.unsplash.com/photo-1517836357463-d25dfeac3438?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTd8fHdvcmtvdXR8ZW58MHx8MHx8&auto=format&fit=crop&w=800&q=60",
        "Lifting weights"),
    pictureHolder(
        "https://images.unsplash.com/photo-1543326727-cf6c39e8f84c?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80",
        "Soccer again"),
    pictureHolder(
        "https://images.unsplash.com/photo-1560272564-c83b66b1ad12?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MzR8fHNwb3J0fGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=800&q=60",
        "Soccer"),
    pictureHolder(
        "https://images.unsplash.com/photo-1493225255756-d9584f8606e9?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8c3VyZmluZ3xlbnwwfHwwfHw%3D&auto=format&fit=crop&w=800&q=60",
        "Surfing"),
    pictureHolder(
        "https://images.unsplash.com/photo-1557685888-2d3621ddf615?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NzV8fHNwb3J0fGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=800&q=60",
        "Rock Climbing"),
    pictureHolder(
        "https://images.unsplash.com/photo-1565992441121-4367c2967103?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8N3x8c3BvcnR8ZW58MHx8MHx8&auto=format&fit=crop&w=800&q=60",
        "Ski-ing"),
    pictureHolder(
        "https://images.unsplash.com/photo-1560089000-7433a4ebbd64?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mjh8fHNwb3J0fGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=800&q=60",
        "Swimming"),
  ];

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

  static String currentBackgroundImage = listOfBackgroundImages[4].url;
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
            currentBackgroundImage =
                listOfBackgroundImages[newHolder.lightModeIndex].url;
          } else if (isDarkMode == 1) {
            currentBackgroundImage =
                listOfDarkmodeBackgroundImages[newHolder.darkModeIndex].url;
          }
        } catch (e) {
          debugPrint(e.toString());
          currentBackgroundImage = listOfBackgroundImages[0].url;
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

class BackgroundImageHolder {
  int lightModeIndex = 0;
  int darkModeIndex = 0;

  BackgroundImageHolder({lightIndex, darkIndex}) {
    if (lightIndex == null && darkIndex == null) {
      lightModeIndex = 0;
      darkModeIndex = 0;
    } else {
      lightModeIndex = lightIndex;
      darkModeIndex = darkIndex;
    }
  }

  Map<String, dynamic> toJson() => {
        'lightIndex': lightModeIndex,
        'darkIndex': darkModeIndex,
      };

  factory BackgroundImageHolder.fromJson(Map<String, dynamic> json) {
    return BackgroundImageHolder(
      lightIndex: json['lightIndex'],
      darkIndex: json['darkIndex'],
    );
  }
}

class pictureHolder {
  String url;
  String description;
  pictureHolder(this.url, this.description);
}

class CustomStack<E> {
  final _list = List.empty(growable: true);

  void push(E value) => _list.add(value);

  E pop() => _list.removeLast();

  E get top => _list.last;

  bool get isEmpty => _list.isEmpty;
  bool get isNotEmpty => _list.isNotEmpty;

  @override
  String toString() => _list.toString();
}
