import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class ExampleFormBuilder extends StatefulWidget {
  //static const routeName = "/extractPriorityIndexForNewGoal";

  @override
  State<StatefulWidget> createState() {
    return _ExampleFormBuilder();
  }
}

class _ExampleFormBuilder extends State<ExampleFormBuilder> {
  final _formKey = GlobalKey<FormBuilderState>();

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
      body: FormBuilder(
        key: _formKey,
        onChanged: () => {
          // Something happens here
          // whenever any change happens in
          // the form
        },
        autovalidateMode: AutovalidateMode.onUserInteraction,
        initialValue: const {
          'exampleTextField': 'Hey dude',
        },
        skipDisabled: true,
        child: Column(children: [
          FormBuilderTextField(name: "exampleTextField"),
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
                  _formKey.currentState?.fields["exampleTextField"]?.value,

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
            child: const Text("Reset All"),
          ),
        ]),
      ),
    );
  }
}
