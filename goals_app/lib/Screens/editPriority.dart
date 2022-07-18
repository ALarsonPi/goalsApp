import 'package:flutter/material.dart';
import 'package:goals_app/Screens/ArgumentPassThroughScreens/browseImageArguments.dart';
import 'package:goals_app/Screens/ArgumentPassThroughScreens/editPriotitiesArguments.dart';
import 'package:goals_app/Screens/browseImages.dart';
import '../Objects/Priority.dart';
import 'package:goals_app/global.dart';

class EditPriorityScreen extends StatefulWidget {
  static const routeName = '/extractPriorityArguments';

  EditPriorityScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _EditPriorityScreen();
  }
}

class _EditPriorityScreen extends State<EditPriorityScreen> {
  late final args =
      ModalRoute.of(context)!.settings.arguments as PriorityScreenArguments;
  final myController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  changeImage(String newURL) {
    debugPrint("WE MADE IT HERE");
    debugPrint(newURL);
    setState(() {
      Global.userPriorities[args.index].setImageUrl(newURL);
      args.currentPriority.imageUrl = newURL;
    });
  }

  saveChanges() {
    if (myController.text.isNotEmpty) {
      setState(() {
        Global.userPriorities[args.index].setName(myController.text);
        args.currentPriority.name = myController.text;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pushNamed(context, '/reorder-priorities'),
        ),
        title: Text(
          args.currentPriority.name,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
      ),
      body: ListView(
        children: [
          SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.45,
            child: Image.network(
              args.currentPriority.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 8.0, right: 8.0, top: 12.0, bottom: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: () => {
                          Navigator.pushNamed(
                            context,
                            BrowseImagesScreen.routeName,
                            arguments: BrowseImageArguments(
                              changeImage,
                            ),
                          ),
                        },
                    child: const Text("Browse Images")),
                ElevatedButton(
                    onPressed: () => {}, child: const Text("Upload Image")),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 8.0, right: 8.0, top: 8.0, bottom: 0.0),
            child: TextFormField(
              controller: myController,
              autovalidateMode: AutovalidateMode.always,
              decoration: InputDecoration(
                hintText: args.currentPriority.name,
                labelText: "Edit Priority Name",
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Colors.black12, width: 2.0),
                  borderRadius: BorderRadius.circular(25.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey, width: 2.0),
                  borderRadius: BorderRadius.circular(25.0),
                ),
              ),
              minLines: 2, //This controls default size of textbox
              keyboardType: TextInputType.multiline,
              maxLines: null,
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(
                left: 24.0, right: 24.0, top: 0.0, bottom: 12.0),
            child: ElevatedButton(
                onPressed: () => {saveChanges()},
                child: const Text("Save New Priority Name")),
          ),
        ],
      ),
    );
  }
}
