import 'package:flutter/material.dart';

import '../../Models/Goal.dart';
import '../../Settings/global.dart';

class GoalSliver extends StatefulWidget {
  Goal currGoal;
  bool isInEditWidget;
  GoalSliver(
    this.currGoal, {
    this.isInEditWidget = false,
    super.key,
  });

  @override
  State<StatefulWidget> createState() {
    return _GoalSliver();
  }
}

class _GoalSliver extends State<GoalSliver> {
  bool checkboxValue = false;

  @override
  void initState() {
    super.initState();
    checkboxValue = widget.currGoal.isComplete;
  }

  clickCheckBox(bool value) {
    setState(() {
      widget.currGoal.isComplete = value;
      checkboxValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 8.0,
        bottom: 8.0,
      ),
      child: Row(
        children: [
          Transform.scale(
            scale: 1.3,
            child: Checkbox(
              value: checkboxValue,
              onChanged: ((value) => {
                    clickCheckBox(value as bool),
                  }),
            ),
          ),
          (widget.isInEditWidget)
              ? Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.60,
                      child: Row(
                        children: [
                          getTextWidget(),
                        ],
                      ),
                    ),
                    SizedBox(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: GestureDetector(
                          onTap: () => {},
                          child: Icon(
                            Icons.edit,
                            color: Global.getPrimaryColorSwatch().shade700,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 8.0,
                          right: 8.0,
                        ),
                        child: GestureDetector(
                          onTap: () => {},
                          child: Icon(
                            Icons.delete,
                            color: Colors.red[900] as Color,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : getTextWidget(),
        ],
      ),
    );
  }

  getTextWidget() {
    return Flexible(
      child: Text(
        widget.currGoal.name,
        style: TextStyle(
          fontSize: (Global.isPhone) ? 18 : 24,
        ),
      ),
    );
  }
}
