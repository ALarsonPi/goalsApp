import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'AppRouter.dart';
import 'Providers/PriorityProvider.dart';
import 'Settings/GlobalFileIO.dart';
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

  await GlobalFileIO.readFiles();

  runApp(
    ChangeNotifierProvider(
      create: (_) {
        return PriorityProvider();
      },
      child: const AppRouter(),
    ),
  );
}
