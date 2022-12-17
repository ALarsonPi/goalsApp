import 'package:flutter/material.dart';
import 'package:goals_app/Providers/ThemeProvider.dart';
import 'package:goals_app/Settings/GlobalFileIO.dart';
import 'package:provider/provider.dart';

import 'global.dart';
import 'AppColors.dart';

class PrimaryColorSwitcher extends StatelessWidget {
  PrimaryColorSwitcher(this.desiredHeight, {Key? key}) : super(key: key);
  double desiredHeight;

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (c, themeProvider, _) => SizedBox(
        height: (Global.isPhone) ? desiredHeight : desiredHeight + 100,
        child: GridView.count(
          crossAxisCount: AppColors.primaryColors.length,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 10,
          children: List.generate(
            AppColors.primaryColors.length,
            (i) {
              bool _isSelectedColor = AppColors.primaryColors[i] ==
                  Global.globalThemeProvider.selectedPrimaryColor;
              return GestureDetector(
                onTap: _isSelectedColor
                    ? null
                    : () => {
                          themeProvider.setSelectedPrimaryColor(
                              AppColors.primaryColors[i]),
                          Global.globalThemeProvider.setSelectedPrimaryColor(
                              AppColors.primaryColors[i]),
                          Global.currentPrimaryColor = i,
                          GlobalFileIO.writePrimaryColor(),
                        },
                child: Container(
                  height: desiredHeight / 3,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColors[i],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 200),
                    opacity: _isSelectedColor ? 1 : 0,
                    child: Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: Theme.of(context).cardColor.withOpacity(0.5),
                          ),
                          child: Icon(Icons.check,
                              size: (Global.isPhone) ? 20 : 36),
                        ),
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
