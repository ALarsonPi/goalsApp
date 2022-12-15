import 'package:flutter/material.dart';
import '../../global.dart';

class RoundedCard extends StatelessWidget {
  RoundedCard({
    super.key,
    required this.currImage,
    required this.name,
    required this.index,
    this.isSmall = false,
  });

  Widget currImage;
  String name;
  int index;
  bool isSmall;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            SizedBox(
              height: constraints.constrainHeight(),
              child: Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 5,
                child: ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    SizedBox(
                      width: constraints.maxWidth,
                      height: (isSmall)
                          ? constraints.constrainHeight() * 0.7
                          : constraints.constrainHeight() * 0.75,
                      child: currImage,
                    ),
                    SizedBox(
                      height:
                          constraints.constrainHeight() - ((isSmall) ? 10 : 20),
                      width: constraints.constrainWidth(),
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  top: 8.0,
                                  bottom: (isSmall) ? 0 : 8.0,
                                ),
                                child: Text(
                                  name,
                                  style: TextStyle(
                                    fontSize: !Global.isPhone
                                        ? (isSmall)
                                            ? 30
                                            : 36
                                        : (isSmall)
                                            ? 12
                                            : 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Text(
                                  "Priority ${index + 1}",
                                  style: TextStyle(
                                    fontSize: !Global.isPhone
                                        ? (isSmall)
                                            ? 18
                                            : 24
                                        : (isSmall)
                                            ? 8
                                            : 12,
                                    fontWeight: FontWeight.normal,
                                    color: Theme.of(context)
                                        .listTileTheme
                                        .textColor
                                        ?.withOpacity(0.5),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
