import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:robotronics/constants.dart';
import 'package:robotronics/projects.dart';
import 'package:robotronics/reusable.dart';
// import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:vibration/vibration.dart';

import 'home.dart';

class addProject extends StatefulWidget {
  const addProject({Key? key}) : super(key: key);

  @override
  State<addProject> createState() => _addProjectState();
}

class _addProjectState extends State<addProject> {
  final TextEditingController _ProjectTitleController = TextEditingController();
  final TextEditingController _ProjectDescriptionController =
      TextEditingController();

  File? _thumbnailImage;
  File? _coverPhotoImage;

  bool isButtonPressed = false;

  Future<void> _submitTask() async {
    final String title = _ProjectTitleController.text;
    final String description = _ProjectDescriptionController.text;

    if (title.isEmpty || description.isEmpty) {
      Vibration.vibrate();
      Fluttertoast.showToast(
        msg: 'Please fill Title & Description of the project',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black87,
        textColor: Colors.white,
      );
      return;
    }

    Map<String, String>? thumbnailData;
    if (_thumbnailImage != null) {
      thumbnailData = await _uploadImageToFirebase(_thumbnailImage!);
    }

    Map<String, String>? coverPhotoData;
    if (_coverPhotoImage != null) {
      coverPhotoData = await _uploadImageToFirebase(_coverPhotoImage!);
    }

    await FirebaseFirestore.instance.collection('Project').add({
      'title': title,
      'description': description,
      'thumbnailUrl': thumbnailData?['url'],
      'thumbnailName': thumbnailData?['name'],
      'coverPhotoUrl': coverPhotoData?['url'],
      'coverPhotoName': coverPhotoData?['name'],
    });

    Fluttertoast.showToast(
      msg: 'Task submitted successfully!',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black87,
      textColor: Colors.white,
    );

    Navigator.pop(
      context,
      MaterialPageRoute(builder: (context) => Projects()),
    );
  }

  Future<Map<String, String>> _uploadImageToFirebase(File image) async {
    final firebaseStorageRef = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('project_images')
        .child(DateTime.now().millisecondsSinceEpoch.toString());

    final uploadTask = firebaseStorageRef.putFile(image);
    final snapshot = await uploadTask.whenComplete(() {});
    final imageUrl = await snapshot.ref.getDownloadURL();

    return {
      'url': imageUrl,
      'name': firebaseStorageRef.name,
    };
  }

  Future<void> _pickThumbnailImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _thumbnailImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _pickCoverPhotoImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _coverPhotoImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double avatarRadius = screenWidth * 0.05;
    final double appBarIconSize = screenWidth * 0.13;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            isButtonPressed = !isButtonPressed;
          });
          _submitTask();
        },
        backgroundColor: Constants().textColor,
        child: Icon(
          Icons.arrow_forward_ios_outlined,
          color: Constants().buttonBackground,
        ),
      ),
      backgroundColor: Constants().buttonBackground,
      appBar: appBarMethod2(
          context, screenHeight, appBarIconSize, avatarRadius, Projects()),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 8, right: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Constants().textColor,
                      width: 2.0,
                    ),
                  ),
                ),
                child: TextField(
                  controller: _ProjectTitleController,
                  style: TextStyle(
                    color: Constants().textColor,
                    fontSize: 20,
                  ),
                  decoration: InputDecoration(
                    hintText: "Add Title",
                    hintStyle: TextStyle(
                      color: Constants().textColor,
                      fontSize: 27,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.04,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Thumbnail',
                        style: TextStyle(color: Constants().textColor),
                      ),
                      SizedBox(
                        height: screenHeight * 0.005,
                      ),
                      InkWell(
                        onTap: _pickThumbnailImage,
                        child: Container(
                          width: screenWidth * 0.414,
                          height: screenHeight * 0.117,
                          decoration: BoxDecoration(
                            color: Constants().tileColor,
                            borderRadius: BorderRadius.circular(13),
                          ),
                          child: _thumbnailImage != null
                              ? Image.file(
                                  _thumbnailImage!,
                                  fit: BoxFit.cover,
                                )
                              : Center(
                                  child: Icon(
                                    Icons.add_a_photo,
                                    color: Colors.white,
                                    size: screenWidth * 0.07,
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Cover Photo',
                        style: TextStyle(color: Constants().textColor),
                      ),
                      SizedBox(
                        height: screenHeight * 0.005,
                      ),
                      InkWell(
                        onTap: _pickCoverPhotoImage,
                        child: Container(
                          width: screenWidth * 0.414,
                          height: screenHeight * 0.117,
                          decoration: BoxDecoration(
                            color: Constants().tileColor,
                            borderRadius: BorderRadius.circular(13),
                          ),
                          child: _coverPhotoImage != null
                              ? Image.file(
                                  _coverPhotoImage!,
                                  fit: BoxFit.cover,
                                )
                              : Center(
                                  child: Icon(
                                    Icons.add_a_photo,
                                    color: Colors.white,
                                    size: screenWidth * 0.07,
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: screenHeight * 0.03,
              ),
              TextField(
                controller: _ProjectDescriptionController,
                maxLines: 3,
                style: TextStyle(color: Constants().textColor),
                decoration: const InputDecoration(
                  labelText: 'Add Description',
                  alignLabelWithHint: true,
                  labelStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 1.3,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.03,
              ),
              Text(
                'Add Docs:',
                style: TextStyle(color: Constants().textColor),
              ),
              SizedBox(
                height: screenHeight * 0.008,
              ),
              // SingleChildScrollView(
              //   scrollDirection: Axis.horizontal,
              //   child: Row(
              //     children: [
              //       ViewTaskTile(
              //         screenHeight: screenHeight,
              //         screenWidth: screenWidth,
              //         imagePath: 'assets/repository.png',
              //         text: 'Repository',
              //         onTap: () {},
              //         linkUrl: 'https://github.com/kunal03b/robotronics-App',
              //       ),
              //       SizedBox(
              //         width: screenWidth * 0.037,
              //       ),
              //       ViewTaskTile(
              //         screenHeight: screenHeight,
              //         screenWidth: screenWidth,
              //         imagePath: 'assets/powerpoint.png',
              //         text: 'PowerPoint',
              //         onTap: () {},
              //         linkUrl: '',
              //       ),
              //       SizedBox(
              //         width: screenWidth * 0.037,
              //       ),
              //       ViewTaskTile(
              //         screenHeight: screenHeight,
              //         screenWidth: screenWidth,
              //         imagePath: 'assets/word.png',
              //         text: 'Project Report',
              //         onTap: () {},
              //         linkUrl: '',
              //       ),
              //       SizedBox(
              //         width: screenWidth * 0.037,
              //       ),
              //       ViewTaskTile(
              //         screenHeight: screenHeight,
              //         screenWidth: screenWidth,
              //         imagePath: 'assets/ui.png',
              //         text: 'UI Design',
              //         onTap: () {},
              //         linkUrl: '',
              //       ),
              //     ],
              //   ),
              // ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              Text(
                'Add Links:',
                style: TextStyle(color: Constants().textColor),
              ),
              SizedBox(
                height: screenHeight * 0.008,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ViewTaskTile(
                      screenHeight: screenHeight,
                      screenWidth: screenWidth,
                      imagePath: 'assets/github.png',
                      text: 'Github',
                      onTap: () {},
                      linkUrl: '',
                    ),
                    SizedBox(
                      width: screenWidth * 0.037,
                    ),
                    ViewTaskTile(
                      screenHeight: screenHeight,
                      screenWidth: screenWidth,
                      imagePath: 'assets/figma.png',
                      text: 'Figma Design',
                      onTap: () {},
                      linkUrl: '',
                    ),
                    SizedBox(
                      width: screenWidth * 0.037,
                    ),
                    ViewTaskTile(
                      screenHeight: screenHeight,
                      screenWidth: screenWidth,
                      imagePath: 'assets/docs.png',
                      text: 'Docs File',
                      onTap: () {},
                      linkUrl: '',
                    ),
                    SizedBox(
                      width: screenWidth * 0.037,
                    ),
                    ViewTaskTile(
                      screenHeight: screenHeight,
                      screenWidth: screenWidth,
                      imagePath: 'assets/firebase.png',
                      text: 'Firebase',
                      onTap: () {},
                      linkUrl: '',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
