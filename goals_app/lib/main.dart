import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'AppRouter.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.transparent, // navigation bar color
    statusBarColor: Colors.transparent, // status bar color
  ));
  runApp(const AppRouter());
}
