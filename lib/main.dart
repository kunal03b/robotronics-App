import 'package:flutter/material.dart';
import 'package:robotronics/home.dart';
import 'package:robotronics/reusable.dart';
// import 'package:gap/gap.dart';

import 'cardTaskWidget.dart';

void main() {
  runApp(TaskManagerApp());
}

class TaskManagerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Manager',
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class TaskManagerScreen extends StatelessWidget {
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
                  child: ListView.builder(
                    itemCount: 1,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (context, index) => TaskCardWidget(
                      screenWidth: screenWidth,
                      cardWidth: cardWidth,
                      cardHeight: cardHeight,
                      subtitleFontSize: subtitleFontSize,
                      screenHeight: screenHeight,
                    ),
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
