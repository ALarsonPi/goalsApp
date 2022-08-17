import 'package:flutter/material.dart';

class NoGoalsPrompt extends StatelessWidget {
  int type;
  late var promptType;
  NoGoalsPrompt(this.type, {Key? key}) : super(key: key) {
    if (type == 0) {
      promptType = PromptType.Goals;
    } else if (type == 1) {
      debugPrint("Got here");
      promptType = PromptType.Priorities;
    }
  }

  @override
  Widget build(BuildContext context) {
    String messageToDisplay = "Error";
    if (promptType == PromptType.Goals) {
      messageToDisplay = "Press the \"+\" to \ncreate a new Goal!";
    } else if (promptType == PromptType.Priorities) {
      messageToDisplay = "Press the \"+\" to \ncreate a new Priority!";
    }
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          Text(messageToDisplay,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.normal,
                fontStyle: FontStyle.italic,
                fontSize: 18,
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
