import 'dart:io';

import 'package:flutter/material.dart';
import 'package:goals_app/Screens/ArgumentPassThroughScreens/browseImageArguments.dart';
import 'package:goals_app/Screens/ArgumentPassThroughScreens/editPriotitiesArguments.dart';
import 'package:goals_app/Screens/Priorities/individualPriority.dart';
import 'package:goals_app/Screens/browseImages.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:goals_app/global.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:image_picker/image_picker.dart';

import '../Screens/ArgumentPassThroughScreens/individualPriorityArgumentScreen.dart';

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

  XFile? _selectedFile;
  bool _inProcess = false;
  bool recievedNewBrowsedImage = false;
  Widget getImageWidget() {
    if (!recievedNewBrowsedImage && _selectedFile != null) {
      args.currentPriority.imageUrl = _selectedFile!.path;
    }
    recievedNewBrowsedImage = false;

    if (args.currentPriority.imageUrl.toString().contains("http")) {
      return Image.network(
        args.currentPriority.imageUrl,
        fit: BoxFit.cover,
      );
    } else {
      return Image.file(
        File(args.currentPriority.imageUrl),
        fit: BoxFit.cover,
      );
    }
  }

  getImage(ImageSource source) async {
    setState(() {
      _inProcess = true;
    });
    XFile? image = await ImagePicker.platform.getImage(source: source);
    if (image != null) {
      CroppedFile? cropped = await ImageCropper.platform.cropImage(
        sourcePath: image.path,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
        compressQuality: 100,
        maxWidth: 700,
        maxHeight: 700,
        compressFormat: ImageCompressFormat.jpg,
      );

      setState(() {
        _selectedFile = XFile(cropped!.path);
        _inProcess = false;
      });
    } else {
      setState(() {
        _inProcess = false;
      });
    }
  }

  late PermissionStatus _permissionStatus;

  @override
  void initState() {
    super.initState();

    () async {
      _permissionStatus = await Permission.storage.status;

      if (_permissionStatus != PermissionStatus.granted) {
        PermissionStatus permissionStatus = await Permission.storage.request();
        setState(() {
          _permissionStatus = permissionStatus;
        });
      }
    }();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  changeImage(String newURL) {
    setState(() {
      recievedNewBrowsedImage = true;
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
          onPressed: () => Navigator.pushNamed(
              context, IndividualPriority.routeName,
              arguments: IndividualPriorityArgumentScreen(args.index)),
        ),
        title: Text(
          args.currentPriority.name,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
      ),
      body: ListView(
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
          SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.45,
            child: getImageWidget(),
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
                    onPressed: () => {
                          getImage(ImageSource.gallery),
                        },
                    child: const Text("Upload Image")),
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
