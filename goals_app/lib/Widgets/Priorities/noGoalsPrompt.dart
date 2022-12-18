import 'package:flutter/material.dart';

import '../../Settings/global.dart';

class NoGoalsPrompt extends StatelessWidget {
  int type;
  late var promptType;
  NoGoalsPrompt(this.type, {Key? key}) : super(key: key) {
    if (type == 0) {
      promptType = PromptType.Goals;
    } else if (type == 1) {
      promptType = PromptType.Priorities;
    }
  }

  @override
  Widget build(BuildContext context) {
    String messageToDisplay = "Error";
    if (promptType == PromptType.Goals) {
      messageToDisplay = "Create new:";
    } else if (promptType == PromptType.Priorities) {
      messageToDisplay = "Press the \"+\" to \ncreate a new Priority!";
    }
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Column(
        children: [
          Text(messageToDisplay,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontStyle: FontStyle.italic,
                fontSize: (Global.isPhone) ? 18 : 24,
              )),
        ],
      ),
    );
  }
}

enum PromptType {
  Goals,
  Priorities,
}
