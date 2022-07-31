import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
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

  List<String> possibleTimeFrames = List.empty(growable: true);
  List<String> helperWords = List.empty(growable: true);

  @override
  void initState() {
    possibleTimeFrames.add("day");
    possibleTimeFrames.add("week");
    possibleTimeFrames.add("month");
    possibleTimeFrames.add("3 months");
    possibleTimeFrames.add("6 months");
    possibleTimeFrames.add("9 months");
    possibleTimeFrames.add("year");
    possibleTimeFrames.add("2 years");
    possibleTimeFrames.add("5 years");
    possibleTimeFrames.add("10 years");

    helperWords.add("per");
    helperWords.add("by");
    helperWords.add("in a");
    super.initState();
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
                const SizedBox(height: 30),
                DropdownButtonFormField2(
                    buttonPadding:
                        const EdgeInsets.only(left: 15.0, right: 15.0),
                    buttonHeight: 40.0,
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                    ),
                    isExpanded: true,
                    scrollbarAlwaysShow: true,
                    hint: const Text('Number of times'),
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black45,
                    ),
                    items: possibleTimeFrames
                        .map((item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(item,
                                style: const TextStyle(
                                  fontSize: 14,
                                ))))
                        .toList(),
                    validator: (value) {
                      if (value == null) {
                        return 'Please select time frame.';
                      }
                    },
                    onChanged: (value) {},
                    onSaved: (value) {}
                    //name: "numTimes", items: [DropdownMenuItem(child: child)])
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
