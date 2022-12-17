import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import '../../Models/Goal.dart';
import '../../Models/Priority.dart';
import '../../global.dart';
import '../ArgumentPassThroughScreens/browseImageArguments.dart';
import 'prioritiesHome.dart';
import '../browseImages.dart';

class NewPriorityScreen extends StatefulWidget {
  NewPriorityScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _NewPriorityScreen();
  }
}

class _NewPriorityScreen extends State<NewPriorityScreen> {
  Priority newPriority = Priority(
    "name",
    "imageUrl",
    List<Goal>.empty(growable: true),
    -1,
  );

  @override
  void initState() {
    newPriority.imageUrl = "None";
    newPriority.name = "Default";
    super.initState();
  }

  bool recievedNewBrowsedImage = false;
  getImageWidget() {
    if (!recievedNewBrowsedImage && _selectedFile != null) {
      newPriority.imageUrl = _selectedFile!.path;
    } else {
      // newPriority.imageUrl =
      //     "https://images.unsplash.com/photo-1540189549336-e6e99c3679fe?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8N3x8Zm9vZHxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=800&q=60";
    }
    recievedNewBrowsedImage = false;
    if (newPriority.imageUrl.toString().contains("http")) {
      return NetworkImage(
        newPriority.imageUrl,
      );
    } else {
      return FileImage(
        File(newPriority.imageUrl),
      );
    }
  }

  changeImage(String newURL) {
    setState(() {
      recievedNewBrowsedImage = true;
      newPriority.setImageUrl(newURL);
      newPriority.imageUrl = newURL;
    });
  }

  saveTitleTextChanges(String newTitle) {
    setState(() {
      newPriority.setName(newTitle);
      newPriority.name = newTitle;
    });
  }

  XFile? _selectedFile;
  bool _inProcess = false;
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
        _selectedFile = XFile(cropped?.path ?? "None");
        if (_selectedFile?.path != "None") {
          newPriority.imageUrl = _selectedFile?.path ?? "None";
        }
        _inProcess = false;
      });
    } else {
      setState(() {
        _inProcess = false;
      });
    }
  }

  changeImageHelper(String newURL) {
    changeImage(newURL);
  }

  final myController = TextEditingController();

  saveTitleTextChangesHelper() {
    if (myController.text.isNotEmpty) {
      //call parent
      saveTitleTextChanges(myController.text);
    }
  }

  getDecorationImageWidget() {
    return DecorationImage(image: getImageWidget(), fit: BoxFit.cover);
  }

  final _formKey = GlobalKey<FormBuilderState>();

  checkIfValidate() {
    return _formKey.currentState?.validate();
  }

  @override
  Widget build(BuildContext context) {
    String textInTextField = "";
    return Container(
      constraints: BoxConstraints.tight(Size(1400, 1400)),
      decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(
                Global.currentBackgroundImage,
              ),
              fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(Global.toolbarHeight),
          child: AppBar(
            toolbarHeight: Global.toolbarHeight,
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: Text(
              "Create Priority",
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            leading: IconButton(
              onPressed: () => {
                Navigator.pop(context, true),
              },
              icon: const Padding(
                padding: EdgeInsets.only(left: 16.0),
                child: Icon(
                  Icons.arrow_back,
                ),
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              ListView(
                shrinkWrap: true,
                primary: false,
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
                  (newPriority.imageUrl == "None")
                      ? Placeholder(
                          fallbackHeight:
                              MediaQuery.of(context).size.height * 0.35,
                        )
                      : Container(
                          padding: const EdgeInsets.all(0.0),
                          height: MediaQuery.of(context).size.height * 0.35,
                          decoration: BoxDecoration(
                            image: getDecorationImageWidget(),
                          ),
                        ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 8.0, right: 8.0, top: 16.0, bottom: 0.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          height: Global.buttonHeight,
                          child: ElevatedButton(
                              onPressed: () => {
                                    Navigator.pushNamed(
                                      context,
                                      BrowseImagesScreen.routeName,
                                      arguments: BrowseImageArguments(
                                        changeImageHelper,
                                      ),
                                    ),
                                  },
                              child: const Text("Browse Images")),
                        ),
                        SizedBox(
                          height: Global.buttonHeight,
                          child: ElevatedButton(
                              onPressed: () => {
                                    getImage(ImageSource.gallery),
                                    setState(() => {}),
                                  },
                              child: const Text("Upload Image")),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 8.0, right: 8.0, top: 8.0, bottom: 0.0),
                    child: FormBuilder(
                      key: _formKey,
                      onChanged: () => {
                        setState(() {
                          newPriority.name = _formKey
                              .currentState?.fields["priority-name"]?.value;
                        }),
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      initialValue: const {
                        'priority-name': '',
                      },
                      skipDisabled: true,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 12.0,
                                right: 12.0,
                              ),
                              child: FormBuilderTextField(
                                key: const ValueKey('nameOfPriority'),
                                autocorrect: false,
                                decoration: const InputDecoration(
                                  labelText: "Priority Name",
                                  labelStyle:
                                      TextStyle(fontStyle: FontStyle.italic),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1, color: Colors.grey),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1.5, color: Colors.green),
                                  ),
                                ),
                                name: "priority-name",
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a name';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 20.0, left: 12.0, right: 12.0),
                              child: SizedBox(
                                height: Global.buttonHeight,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: const Size.fromHeight(36),
                                  ),
                                  onPressed: (_formKey.currentContext != null &&
                                          checkIfValidate() &&
                                          newPriority.imageUrl != "None")
                                      ? () => {
                                            if (_formKey.currentState!
                                                .validate())
                                              {
                                                newPriority.priorityIndex =
                                                    Global
                                                        .userPriorities.length,
                                                Global.addPriority(newPriority),
                                                Navigator.push<void>(
                                                  context,
                                                  MaterialPageRoute<void>(
                                                    builder: (BuildContext
                                                            context) =>
                                                        PriorityHomeScreen
                                                            .fromOtherRoute(Global
                                                                    .userPriorities
                                                                    .length -
                                                                1),
                                                  ),
                                                ),
                                              }
                                          }
                                      : null,
                                  child: const Text("CREATE"),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
