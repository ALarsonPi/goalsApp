import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:goals_app/Settings/priorityImages.dart';
import '../Models/BackgroundImageInfo.dart';
import '../Models/CustomStack.dart';
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
  static CustomStack<Goal> depthStack = CustomStack();
  static bool goalButtonsInGridView = false;
  static bool priorityIsInListView = false;
  static TextEditingController textWatcher = TextEditingController();
  static List<Priority> listOfPrioritiesFromFile = List.empty(growable: true);

  static String currentBackgroundImage =
      PriorityImages.listOfBackgroundImages[4].url;
  static BackgroundImageHolder backgroundImageIndexes = BackgroundImageHolder();

  static MaterialColor getPrimaryColorSwatch() {
    return AppColors.getMaterialColorFromColor(
        globalThemeProvider.selectedPrimaryColor);
  }
}
