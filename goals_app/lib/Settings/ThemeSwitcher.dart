import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../global.dart';
import 'ThemeProvider.dart';
import 'AppColors.dart';
import 'AppTheme.dart';

class ThemeSwitcher extends StatelessWidget {
  ThemeSwitcher(this.containerHeight, {Key? key}) : super(key: key);
  double containerHeight;

  static List<AppTheme> appThemes = [
    AppTheme(
      mode: ThemeMode.light,
      title: 'Light',
      icon: Icons.brightness_5_rounded,
    ),
    AppTheme(
      mode: ThemeMode.dark,
      title: 'Dark',
      icon: Icons.brightness_2_rounded,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (c, themeProvider, _) => SizedBox(
        height: containerHeight,
        child: GridView.count(
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 10,
          childAspectRatio: 1 / 0.4,
          shrinkWrap: true,
          crossAxisCount: appThemes.length,
          children: List.generate(
            appThemes.length,
            (i) {
              bool _isSelectedTheme = appThemes[i].mode ==
                  Global.globalThemeProvider.selectedThemeMode;
              return GestureDetector(
                onTap: _isSelectedTheme
                    ? null
                    : () => {
                          themeProvider.setSelectedThemeMode(appThemes[i].mode),
                          Global.isDarkMode = i,
                          Global.writeDarkMode(),
                          Global.globalThemeProvider
                              .setSelectedThemeMode(appThemes[i].mode),
                        },
                child: AnimatedContainer(
                  height: 100,
                  duration: const Duration(milliseconds: 200),
                  decoration: BoxDecoration(
                    color: _isSelectedTheme
                        ? Theme.of(context).primaryColor
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        width: 2, color: Theme.of(context).primaryColor),
                  ),
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 7),
                      margin: const EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Theme.of(context).cardColor.withOpacity(0.5),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Icon(appThemes[i].icon),
                          Text(
                            appThemes[i].title,
                            style: Theme.of(context).textTheme.subtitle2,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
