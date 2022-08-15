import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:goals_app/Screens/ArgumentPassThroughScreens/individualGoalArguments.dart';
import 'package:goals_app/Screens/ArgumentPassThroughScreens/individualPriorityArgumentScreen.dart';
import 'package:goals_app/Screens/Priorities/individualPriority.dart';
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
    newGoal = Goal("null", 0, "null", "null", null, null, null, false);
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
    debugPrint("Current Args Priority Index: ");
    debugPrint(args.priorityIndex.toString());
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

  String? validateText(String? value, String invalidText) {
    if (value!.isEmpty) {
      return invalidText;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    String textInTextField = "";
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
              child: Column(children: [
                //CURRENT Priority Name
                // Padding(
                //   padding: const EdgeInsets.only(bottom: 16.0),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                //       Expanded(
                //         child: FittedBox(
                //           child: Text(
                //             Global.userPriorities[args.priorityIndex].name,
                //             style: const TextStyle(
                //                 fontSize: 24, fontWeight: FontWeight.bold),
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),

                Padding(
                  padding:
                      const EdgeInsets.only(left: 12.0, top: 8.0, bottom: 12.0),
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
                      borderSide: BorderSide(width: 1, color: Colors.redAccent),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1.5, color: Colors.green),
                    ),

                    // border: InputBorder(
                    //   borderSide: BorderSide(
                    //       color: Colors.grey, style: BorderStyle.solid, width: 2.0),
                    //),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.05,
                      right: MediaQuery.of(context).size.width * 0.35),
                  child: FormBuilderCheckbox(
                    controlAffinity: ListTileControlAffinity.trailing,
                    name: "repeat",
                    contentPadding: EdgeInsets.zero,
                    title: const Text("Repeat?",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold)),
                    onChanged: ((value) => {
                          setState(() {
                            shouldShowRepeatContent = value!;
                          }),
                        }),
                  ),
                ),
                if (shouldShowRepeatContent)
                  FormBuilderTextField(
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
                      labelText: "Enter number of times to repeat",
                      hintText: '1 by default',
                      floatingLabelAlignment: FloatingLabelAlignment.start,
                      hintStyle: TextStyle(fontStyle: FontStyle.italic),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: Colors.grey),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 1, color: Colors.redAccent),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 1.5, color: Colors.green),
                      ),
                    ),
                  ),
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
                if (shouldShowDateContent)
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Row(
                      children: [
                        ElevatedButton(
                            onPressed: () => {
                                  showFlutterDatePicker(),
                                  // setState(() {
                                  //   if (showFlutterDatePicker() != null) {
                                  //     currentDate = showFlutterDatePicker();
                                  //   }
                                  // }),
                                },
                            child: const Text("Select Date")),
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: Text(DateFormat.yMMMEd().format(currentDate!),
                              style:
                                  const TextStyle(fontStyle: FontStyle.italic)),
                        ),
                      ],
                    ),
                  ),

                //Reward
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
                if (shouldShowRewardContent)
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
                        labelText: "How'll you reward yourself when done?",
                        hintText: '',
                        floatingLabelAlignment: FloatingLabelAlignment.start,
                        hintStyle: TextStyle(fontStyle: FontStyle.italic),
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
                  ),

                //Optional Fields

                //WHY?
                const Padding(
                  padding: EdgeInsets.only(left: 12.0, top: 8.0, bottom: 4.0),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("I'll do this because...",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold))),
                ),
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
                        borderSide: BorderSide(width: 1, color: Colors.grey),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 1, color: Colors.redAccent),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 1.5, color: Colors.green),
                      ),
                    ),
                  ),
                ),

                //WHEN
                const Padding(
                  padding: EdgeInsets.only(left: 12.0, top: 8.0, bottom: 4.0),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("I'll do this at...",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold))),
                ),
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
                        borderSide: BorderSide(width: 1, color: Colors.grey),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 1, color: Colors.redAccent),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 1.5, color: Colors.green),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ElevatedButton(
                        onPressed: () => {
                          //How to access a field value in the form
                          textInTextField =
                              _formKey.currentState?.fields["goal"]?.value,

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
                                  newGoal.completeByDate =
                                      DateFormat.yMMMEd().format(currentDate!),
                                },
                              newGoal.reward = _formKey
                                      .currentState?.value['rewardPicker'] ??
                                  'null',
                              newGoal.whyToComplete =
                                  _formKey.currentState?.value['why'] ?? 'null',
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
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
