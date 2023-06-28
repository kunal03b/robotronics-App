import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:robotronics/constants.dart';
import 'package:robotronics/viewTask.dart';

class TaskCardWidget extends StatelessWidget {
  final double screenWidth;
  final double cardWidth;
  final double cardHeight;
  final double subtitleFontSize;
  final double screenHeight;
  final QueryDocumentSnapshot<Object?> task;

  TaskCardWidget({
    required this.screenWidth,
    required this.cardWidth,
    required this.cardHeight,
    required this.subtitleFontSize,
    required this.screenHeight,
    required this.task,
  });

  @override
  Widget build(BuildContext context) {
    // Get the current date
    final DateTime currentDate = DateTime.now();
    final String formattedDate = currentDate.toString();

    // Update the assigned date in Firestore
    FirebaseFirestore.instance
        .collection('task')
        .doc(task.id)
        .update({'assignedDate': formattedDate}).then((value) {
      // Update successful
      print('Assigned date updated successfully');
    }).catchError((error) {
      // Handle update error
      print('Failed to update assigned date: $error');
    });

    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Card(
        color: Color.fromRGBO(217, 217, 217, 1),
        margin: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.05,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(screenWidth * 0.04),
        ),
        child: Container(
          width: cardWidth,
          height: cardHeight,
          padding: EdgeInsets.all(screenWidth * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  task['title'].toString(),
                  style: TextStyle(
                    fontSize: subtitleFontSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  task['description'].toString(),
                  style: TextStyle(color: Colors.black),
                ),
              ),
              SizedBox(height: screenHeight * 0.015),
              Row(
                children: [
                  for (int i = 0; i < 5; i++)
                    Padding(
                      padding: EdgeInsets.only(right: screenWidth * 0.02),
                      child: CircleAvatar(
                        backgroundColor: Colors.grey.shade900,
                        radius: screenWidth * 0.042,
                      ),
                    ),
                ],
              ),
              SizedBox(height: screenHeight * 0.015),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Assigned - $formattedDate', // Use the current date
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.001),
                      Text(
                        'Deadline - ${task['deadline'].toString()}',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ViewTask(taskId: task.id),
                        ),
                      );
                    },
                    child: Container(
                      width: screenWidth / 3.5,
                      height: screenHeight / 20,
                      decoration: BoxDecoration(
                        color: Constants().buttonBackground,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Center(
                        child: Text(
                          'Tap Here',
                          style: TextStyle(
                            color: Colors.white,
                          ),
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
