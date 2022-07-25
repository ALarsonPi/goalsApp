import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../Screens/ArgumentPassThroughScreens/browseImageArguments.dart';
import '../../Screens/browseImages.dart';
import '../../global.dart';

class EditPriorityWidget extends StatelessWidget {
  Function changeParentImage;
  Function saveChangesToPriorityTitle;
  Function getImage;
  int currentPriorityIndex;
  final bool _inProcess;
  EditPriorityWidget(this.currentPriorityIndex, this._inProcess,
      this.changeParentImage, this.saveChangesToPriorityTitle, this.getImage,
      {Key? key})
      : super(key: key);

  changeImage(String newURL) {
    changeParentImage(newURL);
  }

  final myController = TextEditingController();

  saveTitleTextChanges() {
    if (myController.text.isNotEmpty) {
      //call parent
      saveChangesToPriorityTitle(myController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(0.0),
      children: [
        (_inProcess)
            ? Container(
                color: Colors.white,
                height: MediaQuery.of(context).size.height * 0.95,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : const Center(),
        Padding(
          padding: const EdgeInsets.only(
              left: 8.0, right: 8.0, top: 0.0, bottom: 12.0),
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
                  onPressed: () => {
                        getImage(ImageSource.gallery),
                      },
                  child: const Text("Upload Image")),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          child: Divider(thickness: 1, color: Colors.grey),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Center(
            child: Text(Global.userPriorities[currentPriorityIndex].name,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
              left: 8.0, right: 8.0, top: 8.0, bottom: 0.0),
          child: TextFormField(
            controller: myController,
            autovalidateMode: AutovalidateMode.always,
            decoration: InputDecoration(
              hintText: Global.userPriorities[currentPriorityIndex].name,
              labelText: "Edit Priority Name",
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black12, width: 2.0),
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
              onPressed: () => {saveTitleTextChanges()},
              child: const Text("Save New Priority Name")),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          child: Divider(thickness: 1, color: Colors.grey),
        ),
      ],
    );
  }
}
