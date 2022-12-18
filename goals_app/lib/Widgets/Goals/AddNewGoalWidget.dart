import 'package:flutter/material.dart';
import 'package:goals_app/Settings/global.dart';
import 'package:goals_app/Widgets/Goals/CustomInput.dart';
import 'package:provider/provider.dart';

import '../../Models/Goal.dart';
import '../../Models/Priority.dart';
import '../../Providers/PriorityProvider.dart';

class AddNewGoalWidget extends StatefulWidget {
  const AddNewGoalWidget(this.currPriority, {super.key});
  final Priority currPriority;
  @override
  State<StatefulWidget> createState() {
    return _AddNewGoalWidget();
  }
}

class _AddNewGoalWidget extends State<AddNewGoalWidget> {
  bool isInInputMode = false;
  int lengthOfTextWatcher = 0;

  @override
  void initState() {
    super.initState();
    Global.textWatcher.addListener(notifyOfTextWatcherChange);
  }

  @override
  void dispose() {
    super.dispose();
    Global.textWatcher.removeListener(() {});
  }

  notifyOfTextWatcherChange() {
    if (mounted) {
      setState(() {
        lengthOfTextWatcher = Global.textWatcher.value.text.length;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!isInInputMode)
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.2,
            child: Padding(
              padding: const EdgeInsets.only(
                top: 12.0,
                right: 12.0,
              ),
              child: Text(
                "Create new:",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontStyle: FontStyle.italic,
                  fontSize: (Global.isPhone) ? 18 : 24,
                ),
              ),
            ),
          ),
        (isInInputMode)
            ? Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: CustomInput(
                      label: "What do you want to do?",
                      hint: "Describe your new goal",
                      controller: Global.textWatcher,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 8.0,
                      right: 8.0,
                    ),
                    child: GestureDetector(
                      onTap: () => {
                        setState(() {
                          isInInputMode = false;
                        }),
                        Global.textWatcher.clear(),
                      },
                      child: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => (lengthOfTextWatcher == 0)
                        ? null
                        : {
                            Provider.of<PriorityProvider>(context,
                                    listen: false)
                                .addGoalToPriority(
                              widget.currPriority,
                              Goal(
                                Global.textWatcher.value.text,
                                false,
                              ),
                            ),
                            Global.textWatcher.clear(),
                          },
                    child: Icon(
                      Icons.add,
                      color: (lengthOfTextWatcher == 0)
                          ? Colors.grey
                          : Colors.blue,
                    ),
                  ),
                ],
              )
            : SizedBox(
                child: OutlinedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  )),
                  onPressed: () => {
                    setState(() {
                      isInInputMode = true;
                    })
                  },
                  child: const Text("+"),
                ),
              ),
      ],
    );
  }
}
