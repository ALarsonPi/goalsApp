import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'AppRouter.dart';

Future<void> main() async {
  //System Colors initialization
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.transparent, // navigation bar color
    statusBarColor: Colors.transparent, // status bar color
  ));
  runApp(const AppRouter());
}
