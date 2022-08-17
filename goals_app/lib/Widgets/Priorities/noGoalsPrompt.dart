import 'package:flutter/material.dart';

class NoGoalsPrompt extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: const [
          Text("Press the \"+\" to \ncreate a new Goal!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontStyle: FontStyle.italic,
                fontSize: 18,
              )),
        ],
      ),
    );
  }
}
