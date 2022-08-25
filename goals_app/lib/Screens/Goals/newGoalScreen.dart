import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:goals_app/Screens/ArgumentPassThroughScreens/individualGoalArguments.dart';
import 'package:goals_app/Screens/ArgumentPassThroughScreens/individualPriorityArgumentScreen.dart';
import 'package:goals_app/Screens/Priorities/individualPriority.dart';
import 'package:goals_app/Widgets/Goals/nextPreviousButtons.dart';
import 'package:intl/intl.dart';

import '../../Objects/Goal.dart';
import '../../global.dart';
import '../ArgumentPassThroughScreens/newGoalArguements.dart';
import 'individualGoal.dart';

class NewGoalScreen extends StatefulWidget {
  static const routeName = "/extractPriorityIndexForNewGoal";

  @override
  State<StatefulWidget> createState() {
    return _NewGoalScreen();
  }
}

class _NewGoalScreen extends State<NewGoalScreen> {
  late final _formKey;
  bool isValidForm = false;

  late Goal newGoal;

  bool shouldShowRepeatContent = false;
  bool shouldShowDateContent = false;
  bool shouldShowRewardContent = false;
  DateTime? currentDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  DateTime todaysDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  late final args =
      ModalRoute.of(context)!.settings.arguments as NewGoalArguments;

  @override
  void initState() {
    _formKey = GlobalKey<FormBuilderState>();
    newGoal = Goal("null", 0, "null", "null", null, null, false);
    currentSlide = 1;
    super.initState();
  }

  void addGoalGloballyAndNavigateBack() {
    if (args.isComingFromPriority) {
      Global.userPriorities[args.priorityIndex].goals.add(newGoal);
    } else {
      newGoal.isChildGoal = true;
      args.currentGoal.subGoals.add(newGoal);
      args.currentGoal.goalProgress = "0";
      newGoal.currPriorityIndex = args.priorityIndex;
      args.currentGoal.goalTarget = args.currentGoal.subGoals.length.toString();
    }
    navigateBack();
  }

  void navigateBack() {
    if (args.isComingFromPriority) {
      Navigator.pushNamed(context, IndividualPriority.routeName,
          arguments: IndividualPriorityArgumentScreen(args.priorityIndex));
    } else {
      Navigator.pushNamed(
        context,
        IndividualGoal.routeName,
        arguments: IndividualGoalArguments(
          args.currentGoal,
          args.priorityIndex,
          false,
        ),
      );
    }
  }

  showFlutterDatePicker() async {
    DateTime? newDate = await showDatePicker(
      context: context,
      initialDate: todaysDate,
      firstDate: todaysDate,
      lastDate: DateTime(2100),
    );
    setState(() {
      currentDate = newDate;
      currentDate ??= todaysDate;
    });
  }

  decrementSlide() {
    setState(() {
      currentSlide--;
      if (currentSlide == 0) currentSlide = 1;
      debugPrint(currentSlide.toString());
    });
  }

  incrementSlide() {
    setState(() {
      currentSlide++;
      if (currentSlide == 4) currentSlide = 3;
      debugPrint(currentSlide.toString());
    });
  }

  String? validateText(String? value, String invalidText) {
    if (value != null && value.isEmpty) {
      return invalidText;
    }
    return null;
  }

  late int currentSlide;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Create Goal",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        leading: IconButton(
          onPressed: () => {
            Navigator.pop(context, true),
          },
          icon: const Icon(
            Icons.arrow_back,
          ),
          color: Colors.white,
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          FormBuilder(
            key: _formKey,
            onChanged: () => {
              // Something happens here
              // whenever any change happens in
              // the form
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
            initialValue: const {
              // 'goal': '',
              // 'why': '',
              // 'when': '',
              // 'where': '',
            },

            //USE ONLY IF NEEDED
            skipDisabled: true,

            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  //CURRENT Priority Name
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: FittedBox(
                            child: Text(
                              (args.isComingFromPriority)
                                  ? "For Priority: ${Global.userPriorities[args.priorityIndex].name}"
                                  : "Subgoal of \"${args.currentGoal.name}\" ${args.currentGoal.goalTarget}x",
                              style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  if (currentSlide != 1)
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 8.0, bottom: 8.0, left: 16.0),
                      child: Row(
                        children: const [
                          Text(
                            "Optional",
                            style: TextStyle(fontStyle: FontStyle.italic),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                    ),

                  //Main Goal Entry
                  if (currentSlide == 1)
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 12.0, top: 8.0, bottom: 12.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Row(children: const [
                          Text("*",
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.redAccent)),
                          Text("I want to...",
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold)),
                        ]),
                      ),
                    ),
                  if (currentSlide == 1)
                    FormBuilderTextField(
                      name: "goal",
                      minLines: 2,
                      maxLines: 4,
                      validator: (value) {
                        if (value == null || value == '') {
                          return 'Please enter a goal';
                        }
                      },
                      decoration: const InputDecoration(
                        labelText: "What are you going to do?",
                        floatingLabelAlignment: FloatingLabelAlignment.start,
                        hintStyle: TextStyle(fontStyle: FontStyle.italic),
                        hintText: 'Goal',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1, color: Colors.grey),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1, color: Colors.redAccent),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1.5, color: Colors.green),
                        ),
                      ),
                    ),

                  //Repeat
                  if (currentSlide == 1)
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
                      child: FormBuilderTextField(
                        maxLines: 1,
                        minLines: 1,
                        name: "numRepeat",
                        validator: (value) {
                          if ((value == null || value == '')) {
                            return 'Please select a number';
                          } else if (int.parse(value) > 1000) {
                            return 'Please select a realistic number';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ], // Only numbers can be entered

                        decoration: const InputDecoration(
                          labelText: "How many times?",
                          hintText: 'How many reps/days/etc?',
                          floatingLabelAlignment: FloatingLabelAlignment.start,
                          hintStyle: TextStyle(fontStyle: FontStyle.italic),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: Colors.grey),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: Colors.redAccent),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1.5, color: Colors.green),
                          ),
                        ),
                      ),
                    ),

                  //End Date
                  if (currentSlide == 2)
                    Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.05,
                          right: MediaQuery.of(context).size.width * 0.3),
                      child: FormBuilderCheckbox(
                        contentPadding: EdgeInsets.zero,
                        controlAffinity: ListTileControlAffinity.trailing,
                        name: "Date",
                        title: const Text("End Date?",
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold)),
                        onChanged: ((value) => {
                              setState(() {
                                shouldShowDateContent = value!;
                              }),
                            }),
                      ),
                    ),
                  if (shouldShowDateContent && currentSlide == 2)
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Row(
                        children: [
                          ElevatedButton(
                              onPressed: () => {
                                    showFlutterDatePicker(),
                                  },
                              child: const Text("Select Date")),
                          Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: Text(
                                DateFormat.yMMMEd().format(currentDate!),
                                style: const TextStyle(
                                    fontStyle: FontStyle.italic)),
                          ),
                        ],
                      ),
                    ),

                  //Reward
                  if (currentSlide == 2)
                    Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.05,
                          right: MediaQuery.of(context).size.width * 0.35),
                      child: FormBuilderCheckbox(
                        controlAffinity: ListTileControlAffinity.trailing,
                        name: "reward",
                        title: const Text("Reward?",
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold)),
                        onChanged: ((value) => {
                              setState(() {
                                shouldShowRewardContent = value!;
                              }),
                            }),
                      ),
                    ),
                  if (shouldShowRewardContent && currentSlide == 2)
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, right: 8.0, bottom: 18.0),
                      child: FormBuilderTextField(
                        maxLines: 3,
                        minLines: 1,
                        name: "rewardPicker",
                        validator: ((value) => validateText(
                            value, 'Please enter a reward (if you want one!)')),
                        decoration: const InputDecoration(
                          labelText: "How'll you reward yourself?",
                          hintText: '',
                          floatingLabelAlignment: FloatingLabelAlignment.start,
                          hintStyle: TextStyle(fontStyle: FontStyle.italic),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: Colors.grey),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: Colors.redAccent),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1.5, color: Colors.green),
                          ),
                        ),
                      ),
                    ),

                  //Optional Fields

                  //WHY?
                  if (currentSlide == 3)
                    const Padding(
                      padding:
                          EdgeInsets.only(left: 12.0, top: 8.0, bottom: 4.0),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text("I'll do this because...",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold))),
                    ),
                  if (currentSlide == 3)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FormBuilderTextField(
                        minLines: 1,
                        maxLines: 3,
                        name: "why",
                        decoration: const InputDecoration(
                          labelText: "What's your why?",
                          labelStyle: TextStyle(fontStyle: FontStyle.italic),
                          hintText: 'Why',
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: Colors.grey),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: Colors.redAccent),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1.5, color: Colors.green),
                          ),
                        ),
                      ),
                    ),

                  //WHEN
                  if (currentSlide == 3)
                    const Padding(
                      padding:
                          EdgeInsets.only(left: 12.0, top: 8.0, bottom: 4.0),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text("I'll do this at...",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold))),
                    ),
                  if (currentSlide == 3)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FormBuilderTextField(
                        minLines: 1,
                        maxLines: 3,
                        name: "whenWhere",
                        decoration: const InputDecoration(
                          labelText: "Certain time? Certain place?",
                          labelStyle: TextStyle(fontStyle: FontStyle.italic),
                          hintText: 'When',
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: Colors.grey),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: Colors.redAccent),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1.5, color: Colors.green),
                          ),
                        ),
                      ),
                    ),

                  NextPreviousButtons(
                      currentSlide, incrementSlide, decrementSlide),

                  //SUBMIT BUTTON
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ElevatedButton(
                          onPressed: () => {
                            isValidForm = _formKey.currentState!.validate(),
                            if (isValidForm)
                              {
                                _formKey.currentState?.save(),
                                newGoal.name =
                                    _formKey.currentState?.value['goal'],
                                newGoal.goalTarget =
                                    _formKey.currentState?.value['numRepeat'] ??
                                        '1',
                                newGoal.goalProgress = '0',
                                if (shouldShowDateContent)
                                  {
                                    newGoal.completeByDate = DateFormat.yMMMEd()
                                        .format(currentDate!),
                                  },
                                newGoal.reward = _formKey
                                        .currentState?.value['rewardPicker'] ??
                                    'null',
                                newGoal.whyToComplete =
                                    _formKey.currentState?.value['why'] ??
                                        'null',
                                newGoal.whenToComplete =
                                    _formKey.currentState?.value['whenWhere'] ??
                                        'null',
                                addGoalGloballyAndNavigateBack(),
                              },
                          },
                          child: const Text("SUBMIT"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
