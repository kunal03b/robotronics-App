import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:robotronics/constants.dart';
import 'package:robotronics/reusable.dart';

class ViewTask extends StatefulWidget {
  final String taskId;

  const ViewTask({Key? key, required this.taskId}) : super(key: key);

  @override
  State<ViewTask> createState() => _ViewTaskState();
}

class _ViewTaskState extends State<ViewTask> {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double avatarRadius = screenWidth * 0.05;
    final double appBarIconSize = screenWidth * 0.13;

    CollectionReference tasksCollection =
        FirebaseFirestore.instance.collection('task');

    return FutureBuilder<DocumentSnapshot>(
      future: tasksCollection.doc(widget.taskId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        var taskData = snapshot.data!.data() as Map<String, dynamic>;
        String title = taskData['title'];
        String description = taskData['description'];
        String category = taskData['category'];
        String deadline = taskData['deadline'];
        String assignedDate = taskData['assignedDate'];
        // String assignedMembers = taskData['assignedMembers'];

        return Scaffold(
          appBar: appBarMethod(screenHeight, appBarIconSize, avatarRadius),
          backgroundColor: Constants().buttonBackground,
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(left: 11.0, right: screenWidth * 0.06),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: Constants().textColor,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Divider(
                    thickness: 1.2,
                    color: Constants().textColor,
                    indent: screenWidth * 0.016,
                    endIndent: screenWidth * 0.027,
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Text(
                    description,
                    style:
                        TextStyle(color: Constants().textColor, fontSize: 16),
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),

                  // Row()

                  SizedBox(
                    height: screenHeight * 0.02,
                  ),

                  Container(
                    height: screenHeight * 0.04,
                    width: screenWidth * 0.29,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        category,
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: screenHeight * 0.02,
                  ),

                  Text(
                    'Related Links and Documents:',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Constants().textColor),
                  ),

                  SizedBox(
                    height: screenHeight * 0.03,
                  ),

                  Text(
                    'Docs:',
                    style: TextStyle(color: Constants().textColor),
                  ),
                  SizedBox(
                    height: screenHeight * 0.008,
                  ),

                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ViewTaskTile(
                          screenHeight: screenHeight,
                          screenWidth: screenWidth,
                          imagePath: 'assets/repository.png',
                          text: 'Repository',
                          onTap: () {},
                          linkUrl:
                              'https://github.com/kunal03b/robotronics-App',
                        ),
                        SizedBox(
                          width: screenWidth * 0.037,
                        ),
                        ViewTaskTile(
                          screenHeight: screenHeight,
                          screenWidth: screenWidth,
                          imagePath: 'assets/powerpoint.png',
                          text: 'PowerPoint',
                          onTap: () {},
                          linkUrl: '',
                        ),
                        SizedBox(
                          width: screenWidth * 0.037,
                        ),
                        ViewTaskTile(
                          screenHeight: screenHeight,
                          screenWidth: screenWidth,
                          imagePath: 'assets/word.png',
                          text: 'Project Report',
                          onTap: () {},
                          linkUrl: '',
                        ),
                        SizedBox(
                          width: screenWidth * 0.037,
                        ),
                        ViewTaskTile(
                          screenHeight: screenHeight,
                          screenWidth: screenWidth,
                          imagePath: 'assets/ui.png',
                          text: 'UI Design',
                          onTap: () {},
                          linkUrl: '',
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                    height: screenHeight * 0.02,
                  ),

                  Text(
                    'Links:',
                    style: TextStyle(color: Constants().textColor),
                  ),

                  SizedBox(
                    height: screenHeight * 0.008,
                  ),

                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ViewTaskTile(
                          screenHeight: screenHeight,
                          screenWidth: screenWidth,
                          imagePath: 'assets/github.png',
                          text: 'Github',
                          onTap: () {},
                          linkUrl:
                              'https://github.com/kunal03b/robotronics-App',
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

                  SizedBox(
                    height: screenHeight * 0.03,
                  ),
                  Center(
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                        height: screenHeight * 0.058,
                        width: screenWidth * 0.6,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(120),
                          border: Border.all(
                            color: Constants().textColor,
                            width: 1.5,
                          ),
                        ),
                        child: Center(
                            child: Text(
                          'Chat Here',
                          style: TextStyle(
                              color: Constants().textColor, fontSize: 15),
                        )),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.025,
                  ),
                  Row(
                    children: [
                      Text(
                        'Deadline: ',
                        style: TextStyle(
                          color: Constants().textColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 7),
                        child: Text(
                          deadline,
                          style: TextStyle(
                            color: Constants().textColor,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 11.0),
                  //   child:
                  Row(
                    children: [
                      Text(
                        'Assigned: ',
                        style: TextStyle(
                          color: Constants().textColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 7),
                        child: Text(
                          assignedDate,
                          style: TextStyle(
                            color: Constants().textColor,
                            fontSize: 16,
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
      },
    );
  }
}
