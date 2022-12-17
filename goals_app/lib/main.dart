import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'AppRouter.dart';
import 'Settings/global.dart';

Future<void> main() async {
  // Setting the App as Vertical Only
  // Landscape is Disabled
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.transparent, // navigation bar color
    statusBarColor: Colors.transparent, // status bar color
  ));
  await Global.getPriorities();
  runApp(const AppRouter());
}
