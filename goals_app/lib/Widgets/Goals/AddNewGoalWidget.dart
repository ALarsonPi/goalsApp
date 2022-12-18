import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Models/Goal.dart';
import '../../Models/Priority.dart';
import '../../Providers/PriorityProvider.dart';
import '../Priorities/noGoalsPrompt.dart';

class AddNewGoalWidget extends StatelessWidget {
  Priority currPriority;
  AddNewGoalWidget(this.currPriority, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.2,
          child: Padding(
            padding: const EdgeInsets.only(
              top: 12.0,
              right: 12.0,
            ),
            child: NoGoalsPrompt(0),
          ),
        ),
        SizedBox(
          child: OutlinedButton(
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            )),
            onPressed: () => {
              Provider.of<PriorityProvider>(context, listen: false)
                  .addGoalToPriority(
                      currPriority,
                      Goal("name", 1, "goalProgress", "goalTarget",
                          "whyToComplete", "whenToComplete", true)),
            },
            child: Text("+"),
          ),
        ),
      ],
    );
  }
}
