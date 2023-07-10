import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:robotronics/constants.dart';
import 'package:robotronics/viewTask.dart';

import '../cardTaskWidget.dart';
import '../reusable.dart';

class TaskManagerScreen extends StatefulWidget {
  final String selectedCategory;
  // TaskManagerScreen({required this.selectedCategory});

  TaskManagerScreen({required this.selectedCategory});

  @override
  State<TaskManagerScreen> createState() => _TaskManagerScreenState();
}

class _TaskManagerScreenState extends State<TaskManagerScreen> {
  final CollectionReference taskCollection =
      FirebaseFirestore.instance.collection('task');

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double avatarRadius = screenWidth * 0.05;
    final double cardWidth = screenWidth * 0.9;
    final double cardHeight = screenHeight * 0.255;
    final double subtitleFontSize = screenWidth * 0.038;
    final double titleFontSize = screenWidth * 0.053;
    final double appBarIconSize = screenWidth * 0.13;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(32, 38, 46, 1),
        appBar: appBarMethod(screenHeight, appBarIconSize, avatarRadius),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: screenWidth * 0.03,
                    top: screenHeight * 0.02,
                  ),
                  child: Text(
                    'TASKS ASSIGNED',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: titleFontSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.04),
                Container(
                  height: screenHeight,
                  width: screenWidth,
                  child: StreamBuilder<QuerySnapshot>(
                    stream: widget.selectedCategory.isNotEmpty
                        ? taskCollection
                            .where('category',
                                isEqualTo: widget.selectedCategory)
                            .orderBy('assignedDate', descending: false)
                            .snapshots()
                        : taskCollection
                            .orderBy('assignedDate', descending: false)
                            .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }

                      if (!snapshot.hasData) {
                        return CircularProgressIndicator();
                      }

                      final task = snapshot.data!.docs;

                      return ListView.builder(
                        itemCount: task.length,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemBuilder: (context, index) => TaskCardWidget(
                          screenWidth: screenWidth,
                          cardWidth: cardWidth,
                          cardHeight: cardHeight,
                          subtitleFontSize: subtitleFontSize,
                          screenHeight: screenHeight,
                          task: task[index],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
