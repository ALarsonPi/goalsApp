import 'package:flutter/material.dart';
import 'package:goals_app/Providers/PriorityProvider.dart';
import 'package:provider/provider.dart';

import '../../Models/Goal.dart';
import '../../Models/Priority.dart';
import '../../Settings/global.dart';
import 'CustomInput.dart';

class GoalSliver extends StatefulWidget {
  Priority currPriority;
  Goal currGoal;
  bool isInEditWidget;
  Function setStateInParent;
  GoalSliver(
    this.currGoal,
    this.currPriority, {
    required this.setStateInParent,
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
  bool isEditingText = false;

  @override
  void initState() {
    super.initState();
    local_controller.text = widget.currGoal.name;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  clickCheckBox(bool value) {
    setState(() {
      Provider.of<PriorityProvider>(context, listen: false)
          .updateGoalCompletion(
        widget.currPriority,
        widget.currGoal,
        value,
      );
      widget.currGoal.isComplete = value;
      checkboxValue = value;
    });
  }

  // ignore: non_constant_identifier_names
  TextEditingController local_controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Priority realCurrPriority =
        Provider.of<PriorityProvider>(context, listen: true)
            .priorities
            .elementAt(Provider.of<PriorityProvider>(context, listen: true)
                .priorities
                .indexOf(widget.currPriority));
    checkboxValue = realCurrPriority.goals
        .elementAt(realCurrPriority.goals.indexOf(widget.currGoal))
        .isComplete;
    String valueToChangeTo = widget.currGoal.name;
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
                      child: (isEditingText)
                          ? SizedBox(
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: CustomInput(
                                controller: local_controller,
                              ),
                            )
                          : Row(
                              children: [
                                getTextWidget(),
                              ],
                            ),
                    ),
                    SizedBox(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: GestureDetector(
                          onTap: () => {
                            setState(() => {
                                  if (isEditingText)
                                    {
                                      valueToChangeTo = (local_controller
                                                  .value.text.isEmpty ||
                                              local_controller.value.text == "")
                                          ? widget.currGoal.name
                                          : local_controller.value.text,
                                      Provider.of<PriorityProvider>(context,
                                              listen: false)
                                          .updateGoalName(
                                        widget.currPriority,
                                        widget.currGoal,
                                        valueToChangeTo,
                                      ),
                                      widget.currGoal.name = valueToChangeTo,
                                    },
                                  isEditingText = !isEditingText,
                                }),
                          },
                          child: Icon(
                            (isEditingText) ? Icons.save : Icons.edit,
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
                          onTap: () => {
                            // debugPrint(
                            //     getCurrGoalIndex(widget.currGoal).toString()),
                            // if (getCurrGoalIndex(widget.currGoal) <
                            //     widget.currPriority.goals.length - 1)
                            //   {
                            //     nextElementStatus =
                            //         getNextElementStatus() ? 1 : 0,
                            //     nextGoal = getNextGoal(),
                            //   },
                            // widget.currPriority.goals.remove(widget.currGoal),
                            // setState(() => {}),
                            Provider.of<PriorityProvider>(context,
                                    listen: false)
                                .removeGoalFromPriority(
                                    widget.currPriority, widget.currGoal),
                            // if (nextElementStatus != -1)
                            //   {
                            // Provider.of<PriorityProvider>(context,
                            //         listen: false)
                            //     .updateGoal(
                            //   widget.currPriority,
                            //   nextGoal,
                            //   nextElementStatus == 1,
                            // )
                            // },
                            setState(() => {}),
                            widget.setStateInParent(),
                          },
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

  bool getNextElementStatus() {
    Goal currGoal = widget.currPriority.goals
        .elementAt(getCurrGoalIndex(widget.currGoal) + 1);
    return currGoal.isComplete;
  }

  Goal getNextGoal() {
    return widget.currPriority.goals
        .elementAt(getCurrGoalIndex(widget.currGoal) + 1);
  }

  int getCurrGoalIndex(Goal currGoal) {
    return widget.currPriority.goals.indexOf(widget.currGoal);
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
