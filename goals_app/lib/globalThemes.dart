import 'dart:ffi';

import 'package:flutter/material.dart';
import 'global.dart';

class GlobalThemes {
  //Themes to add

  static ThemeData getThemeData(int isDarkMode) {
    return ThemeData(
      brightness: getBrightness(isDarkMode),
      primarySwatch: Global.getPrimaryColorSwatch(),
      primaryColor: getPrimaryColorForTheme(isDarkMode),
      textTheme: getTextTheme(isDarkMode),
      elevatedButtonTheme: getEvevatedButtonThemeData(isDarkMode),
      progressIndicatorTheme: getProgressIndicatorThemeData(isDarkMode),
      floatingActionButtonTheme: getFABThemeData(isDarkMode),
      iconTheme: getIconThemeData(isDarkMode),
      secondaryHeaderColor: getSecondaryColor(isDarkMode),
      listTileTheme: getListTileThemeData(isDarkMode),
    );
  }

  static ListTileThemeData getListTileThemeData(int isDarkMode) {
    if (isDarkMode == 0) {
      return const ListTileThemeData(
        textColor: Colors.black,
      );
    } else {
      return const ListTileThemeData(
        textColor: Colors.white,
      );
    }
  }

  //Text Theme has all the smaller text styles inside it
  static TextTheme getTextTheme(int isDarkMode) {
    return TextTheme(
      displaySmall: getTextStyleSmall(isDarkMode),
      headlineLarge: getTextStyleHeaderLarge(isDarkMode),
      headlineMedium: getTextStyleHeaderMedium(isDarkMode),
      headlineSmall: getTextStyleHeaderSmall(isDarkMode),
    );
  }

  static IconThemeData getIconThemeData(int isDarkMode) {
    if (isDarkMode == 0) {
      return IconThemeData(
        color: Colors.black,
        opacity: 70,
        size: (Global.isPhone) ? 24 : 32,
      );
    } else {
      return IconThemeData(
        color: Colors.white,
        opacity: 70,
        size: (Global.isPhone) ? 24 : 32,
      );
    }
  }

  static FloatingActionButtonThemeData getFABThemeData(int isDarkMode) {
    if (isDarkMode == 0) {
      return FloatingActionButtonThemeData(
        backgroundColor: Global.getPrimaryColorSwatch().shade500,
        //foregroundColor:
      );
    } else {
      return FloatingActionButtonThemeData(
        backgroundColor: Global.getPrimaryColorSwatch().shade600,
        //foregroundColor:
      );
    }
  }

  static TextStyle getTextStyleSmall(int isDarkMode) {
    if (isDarkMode == 0) {
      return TextStyle(
        fontSize: (Global.isPhone) ? 14 : 24,
        color: Colors.black,
      );
    } else {
      return TextStyle(
        fontSize: (Global.isPhone) ? 14 : 24,
        color: Colors.white,
      );
    }
  }

  static TextStyle getTextStyleHeaderLarge(int isDarkMode) {
    if (isDarkMode == 0) {
      return TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: (Global.isPhone) ? 22 : 36,
        color: Colors.black,
      );
    } else {
      return TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: (Global.isPhone) ? 22 : 36,
        color: Colors.white,
      );
    }
  }

  static TextStyle getTextStyleHeaderMedium(int isDarkMode) {
    if (isDarkMode == 0) {
      return TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: (Global.isPhone) ? 18 : 24,
        color: Colors.black,
      );
    } else {
      return TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: (Global.isPhone) ? 18 : 24,
        color: Colors.white,
      );
    }
  }

  static TextStyle getTextStyleHeaderSmall(int isDarkMode) {
    if (isDarkMode == 0) {
      return TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: (Global.isPhone) ? 12 : 18,
        color: Colors.black,
      );
    } else {
      return TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: (Global.isPhone) ? 12 : 18,
        color: Colors.white,
      );
    }
  }

  static ProgressIndicatorThemeData getProgressIndicatorThemeData(
      int isDarkMode) {
    if (isDarkMode == 0) {
      return ProgressIndicatorThemeData(
        color: Global.getPrimaryColorSwatch().shade700,
        circularTrackColor: Colors.white,
      );
    } else {
      return ProgressIndicatorThemeData(
        color: Global.getPrimaryColorSwatch().shade300,
        circularTrackColor: Global.getPrimaryColorSwatch().shade900,
      );
    }
  }

  static ElevatedButtonThemeData getEvevatedButtonThemeData(int isDarkMode) {
    if (isDarkMode == 0) {
      return ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Global.getPrimaryColorSwatch().shade400,
          textStyle: TextStyle(
            color: Colors.black,
            fontSize: (Global.isPhone) ? 14 : 24,
          ),
          foregroundColor: Colors.black,
        ),
      );
    } else {
      return ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Global.getPrimaryColorSwatch().shade600,
          textStyle: TextStyle(
            color: Colors.white,
            fontSize: (Global.isPhone) ? 14 : 24,
          ),
          foregroundColor: Colors.white,
        ),
      );
    }
  }

  static Color getPrimaryColorForTheme(int isDarkMode) {
    if (isDarkMode == 0) {
      return Global.getPrimaryColorSwatch().shade500;
    } else {
      return Global.getPrimaryColorSwatch().shade400;
    }
  }

  static Color getSecondaryColor(int isDarkMode) {
    if (isDarkMode == 0) {
      return Colors.white;
    } else {
      return Colors.black;
    }
  }

  static Brightness getBrightness(int isDarkMode) {
    if (isDarkMode == 0) {
      return Brightness.light;
    } else {
      return Brightness.dark;
    }
  }
}
