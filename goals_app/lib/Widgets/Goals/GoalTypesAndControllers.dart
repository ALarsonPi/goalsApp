import 'package:flutter/material.dart';
import 'package:goals_app/Widgets/Goals/CustomInput.dart';

class GoalTypesAndControllers {
  static TextEditingController controller1 = TextEditingController();
  static TextEditingController controller2 = TextEditingController();

  static Widget getSingleValueGoalType() {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Padding(
                padding: EdgeInsets.only(
                  top: 8.0,
                  left: 8.0,
                ),
                child: Text("1 - Ex. Pushups in a row (50)",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 12.0,
                  left: 12.0,
                  right: 12.0,
                ),
                child: CustomInput(
                  label: "What do you want to do?",
                  hint: "What will you do?",
                  inputBorder: const OutlineInputBorder(),
                  controller: controller1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 12.0,
                  right: 12.0,
                  bottom: 8.0,
                ),
                child: CustomInput(
                  label: "Number to achieve?",
                  hint: "Ex. '3'",
                  inputBorder: const OutlineInputBorder(),
                  controller: controller2,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  static Widget getUntilEventGoalType() {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Padding(
                padding: EdgeInsets.only(
                  top: 8.0,
                  left: 8.0,
                ),
                child: Text("2 - Do ___ until ___",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 12.0,
                  left: 12.0,
                  right: 12.0,
                ),
                child: CustomInput(
                  label: "What do you want to do?",
                  hint: "What will you do?",
                  inputBorder: const OutlineInputBorder(),
                  controller: controller1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 12.0,
                  right: 12.0,
                  bottom: 8.0,
                ),
                child: CustomInput(
                  label: "How will you know you're done?",
                  hint: "Until...?",
                  inputBorder: const OutlineInputBorder(),
                  controller: controller2,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  static Widget getType3() {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Padding(
                padding: EdgeInsets.only(
                  top: 8.0,
                  left: 8.0,
                ),
                child: Text("3 - Do ___ every day until ___",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 12.0,
                  left: 12.0,
                  right: 12.0,
                ),
                child: CustomInput(
                  label: "What do you want to do?",
                  hint: "What will you do?",
                  inputBorder: const OutlineInputBorder(),
                  controller: controller1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 12.0,
                  right: 12.0,
                  bottom: 8.0,
                ),
                child: CustomInput(
                  label: "How will you know you're done?",
                  hint: "Until...?",
                  inputBorder: const OutlineInputBorder(),
                  controller: controller2,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
