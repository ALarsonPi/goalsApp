import 'dart:ffi';

import 'package:flutter/material.dart';
import 'global.dart';

class GlobalThemes {
  //Themes to add
  //Card Theme
  //Divider Color?

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
      //cardTheme: getCardThemeData(isDarkMode),
      listTileTheme: getListTileThemeData(isDarkMode),
    );
  }

  // static CardTheme getCardThemeData(int isDarkMode) {
  //   if (isDarkMode == 0) {
  //     return const CardTheme(
  //       color: Colors.white,
  //     );
  //   } else {
  //     return const CardTheme(
  //       color: Colors.black,
  //     );
  //   }
  // }

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
    if (isDarkMode == 0) {
      return TextTheme(
        displaySmall: GlobalThemes.getTextStyleSmall(Global.isDarkMode),
      );
    } else {
      return TextTheme(
        displaySmall: getTextStyleSmall(Global.isDarkMode),
      );
    }
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
        backgroundColor: Global.getPrimaryColorSwatch().shade400,
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
        circularTrackColor: Colors.black,
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
