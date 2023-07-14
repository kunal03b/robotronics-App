import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:robotronics/constants.dart';
import 'package:robotronics/viewTask.dart';

class TaskCardWidget extends StatefulWidget {
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
  State<TaskCardWidget> createState() => _TaskCardWidgetState();
}

class _TaskCardWidgetState extends State<TaskCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Card(
        color: Color.fromRGBO(217, 217, 217, 1),
        margin: EdgeInsets.symmetric(
          horizontal: widget.screenWidth * 0.05,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(widget.screenWidth * 0.04),
        ),
        child: Container(
          width: widget.cardWidth,
          height: widget.cardHeight,
          padding: EdgeInsets.all(widget.screenWidth * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  widget.task["title"].toString().toUpperCase(),
                  style: TextStyle(
                    fontSize: widget.subtitleFontSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  widget.task['description'].toString(),
                  maxLines: 2,
                  style: TextStyle(color: Colors.black),
                ),
              ),
              SizedBox(height: widget.screenHeight * 0.015),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    for (int i = 0;
                        i < widget.task['assignedMembers'].length;
                        i++)
                      Padding(
                        padding:
                            EdgeInsets.only(right: widget.screenWidth * 0.02),
                        child: CircleAvatar(
                          backgroundColor: Colors.grey.shade900,
                          radius: widget.screenWidth * 0.042,
                          child: Text(
                            widget.task['assignedMembers'][i][0],
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              SizedBox(height: widget.screenHeight * 0.015),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Assigned - ${widget.task['assignedDate'].toString()}', // Use the assigned date from the database
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: widget.screenHeight * 0.001),
                      Text(
                        'Deadline - ${widget.task['deadline'].toString()}',
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
                          builder: (context) =>
                              ViewTask(taskId: widget.task.id),
                        ),
                      );
                    },
                    child: Container(
                      width: widget.screenWidth / 3.5,
                      height: widget.screenHeight / 20,
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
