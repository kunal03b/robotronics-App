import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:robotronics/constants.dart';
import 'package:robotronics/reusable.dart';
import 'package:robotronics/task%20Manager%20Screen/tasksScreen.dart';

class ViewTask extends StatelessWidget {
  final String taskId;

  const ViewTask({Key? key, required this.taskId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double avatarRadius = screenWidth * 0.05;
    final double appBarIconSize = screenWidth * 0.13;

    CollectionReference tasksCollection =
        FirebaseFirestore.instance.collection('tasks');

    return FutureBuilder<DocumentSnapshot>(
      future: tasksCollection.doc(taskId).get(),
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
        String deadline = taskData['deadline'];

        return Scaffold(
          appBar: appBarMethod(screenHeight, appBarIconSize, avatarRadius),
          backgroundColor: Constants().buttonBackground,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 11.0, top: 13),
                child: Text(
                  title,
                  style: TextStyle(
                    color: Constants().textColor,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              Divider(
                thickness: 1.2,
                color: Constants().textColor,
                indent: screenWidth * 0.025,
                endIndent: screenWidth * 0.025,
              ),
              SizedBox(height: screenHeight * 0.01),
              Padding(
                padding: const EdgeInsets.only(left: 11.0, right: 11.0),
                child: Text(
                  description,
                  style: TextStyle(color: Constants().textColor, fontSize: 16),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.5,
              ),
              Center(
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TaskManagerScreen()),
                    );
                  },
                  child: Container(
                    height: screenHeight * 0.058,
                    width: screenWidth * 0.6,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(120),
                      border:
                          Border.all(color: Constants().textColor, width: 2),
                    ),
                    // child: Center(
                    //     child: Text(
                    //   'OK',
                    //   style: TextStyle(color: Constants().textColor, fontSize: 22),
                    // )),
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.025,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 11.0),
                child: Row(
                  children: [
                    Text(
                      'Deadline-',
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
                            color: Constants().textColor, fontSize: 16),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
