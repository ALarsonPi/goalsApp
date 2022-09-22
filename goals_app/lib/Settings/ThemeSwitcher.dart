import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'ThemeProvider.dart';
import 'AppColors.dart';
import 'AppTheme.dart';

class ThemeSwitcher extends StatelessWidget {
  ThemeSwitcher(this.containerHeight, {Key? key}) : super(key: key);
  double containerHeight;

  List<AppTheme> appThemes = [
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
    AppTheme(
      mode: ThemeMode.system,
      title: 'Auto',
      icon: Icons.brightness_4_rounded,
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
          crossAxisCount: appThemes.length,
          children: List.generate(appThemes.length, (i) {
            bool _isSelectedTheme =
                appThemes[i].mode == themeProvider.selectedThemeMode;
            return GestureDetector(
              onTap: _isSelectedTheme
                  ? null
                  : () => themeProvider.setSelectedThemeMode(appThemes[i].mode),
              child: AnimatedContainer(
                height: containerHeight,
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
                    padding: EdgeInsets.zero,
                    margin: EdgeInsets.zero,
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
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
