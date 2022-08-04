import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class NewGoalScreen extends StatefulWidget {
  static const routeName = "/extractPriorityIndexForNewGoal";

  @override
  State<StatefulWidget> createState() {
    return _NewGoalScreen();
  }
}

class _NewGoalScreen extends State<NewGoalScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  bool shouldShowRepeatContent = false;
  bool shouldShowDateContent = false;
  bool shouldShowRewardContent = false;
  DateTime? currentDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  DateTime todaysDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  @override
  void initState() {
    super.initState();
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
              'goal': '',
              'why': '',
              'when': '',
              'where': '',
            },

            //USE ONLY IF NEEDED
            skipDisabled: true,

            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(children: [
                const Padding(
                  padding: EdgeInsets.only(top: 8.0, bottom: 12.0),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("I want to...",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold))),
                ),
                FormBuilderTextField(
                  name: "goal",
                  minLines: 2,
                  maxLines: 4,
                  decoration: const InputDecoration(
                    labelText: "What are you going to do?",
                    floatingLabelAlignment: FloatingLabelAlignment.start,
                    hintStyle: TextStyle(fontStyle: FontStyle.italic),
                    hintText: 'Goal',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.grey),
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
                    name: "Repeat",
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
                      if (value == null || value == '') {
                        return 'Please select a number';
                      } else if (int.parse(value) > 1000) {
                        return 'Please select a realistic number';
                      }
                    },
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ], // Only numbers can be entered

                    decoration: const InputDecoration(
                      labelText: "Enter number of times to repeat",
                      hintText: '',
                      floatingLabelAlignment: FloatingLabelAlignment.start,
                      hintStyle: TextStyle(fontStyle: FontStyle.italic),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: Colors.grey),
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
                  Row(
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
                      Text(
                          '${currentDate?.year}/${currentDate?.month}/${currentDate?.day}',
                          style: const TextStyle(fontStyle: FontStyle.italic)),
                    ],
                  ),
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
                  FormBuilderTextField(
                    maxLines: 1,
                    minLines: 1,
                    name: "rewardPicker",
                    validator: (value) {
                      if (value == null || value == '') {
                        return 'Please select a number';
                      } else if (int.parse(value) > 1000) {
                        return 'Please select a realistic number';
                      }
                    },
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ], // Only numbers can be entered

                    decoration: const InputDecoration(
                      labelText: "Enter number of times to repeat",
                      hintText: '',
                      floatingLabelAlignment: FloatingLabelAlignment.start,
                      hintStyle: TextStyle(fontStyle: FontStyle.italic),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 1.5, color: Colors.green),
                      ),
                    ),
                  ),
                FormBuilderTextField(
                  name: "why",
                  decoration: const InputDecoration(
                      labelText: "Why do you want to complete this?",
                      hintText: 'Why'),
                ),
                FormBuilderTextField(
                  name: "when",
                  decoration: const InputDecoration(
                      labelText: "When do you want to do this activity?",
                      hintText: 'When'),
                ),
                FormBuilderTextField(
                  name: "where",
                  decoration: const InputDecoration(
                      labelText: "Where do you want to do this activity?",
                      hintText: 'Where'),
                ),
                ElevatedButton(
                  onPressed: () => {
                    _formKey.currentState?.reset(),
                    //Closes keyboard if open
                    FocusScope.of(context).unfocus(),
                  },
                  child: const Text("Reset All"),
                ),
                ElevatedButton(
                  onPressed: () => {
                    //How to access a field value in the form
                    textInTextField =
                        _formKey.currentState?.fields["goal"]?.value,

                    //How to access all the values of the form
                    _formKey.currentState?.value,

                    //How to save all fields before submitting
                    _formKey.currentState?.save(),

                    //How to save one field
                    _formKey.currentState?.fields["exampleTextField"]?.save(),

                    //For optional fields if they are blank maybe
                    //set them as disabled and then you can use the
                    //skipDisabled: true in the main form so that
                    //when submitting those won't be saved
                  },
                  child: const Text("Do All"),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
