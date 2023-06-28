import 'package:flutter/material.dart';
import 'package:robotronics/constants.dart';
import 'package:robotronics/newTask.dart';
import 'package:robotronics/reusable.dart';
import 'package:robotronics/task%20Manager%20Screen/tasksScreen.dart';

class Home extends StatelessWidget {
  const Home({Key? key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double avatarRadius = screenWidth * 0.05;
    final double appBarIconSize = screenWidth * 0.13;
    return Scaffold(
      appBar: appBarMethod(screenHeight, appBarIconSize, avatarRadius),
      backgroundColor: Constants().buttonBackground,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(left: screenWidth * 0.03),
                child: Text(
                  'RECENT TASKS',
                  style: TextStyle(
                    color: Constants().textColor,
                    fontSize: screenWidth * 0.05,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: screenWidth * 0.04),
                child: InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => NewTask()));
                    print('Hello from Add Task');
                  },
                  child: Text(
                    'Add Task',
                    style: TextStyle(color: Constants().textColor),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.02),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildTaskCard(
                screenWidth,
                screenHeight,
                'assets/Operation.png',
                'OPERATIONAL',
                () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TaskManagerScreen()));
                  // print('Coming from Operational Tasks');
                },
              ),
              buildTaskCard(
                screenWidth,
                screenHeight,
                'assets/Technical.png',
                'TECHNICAL',
                () {
                  print('Coming from Technical Tasks');
                },
              ),
              buildTaskCard(
                screenWidth,
                screenHeight,
                'assets/Marketing.png',
                'MARKETING',
                () {
                  print('Coming from Marketing Tasks');
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildTaskCard(double screenWidth, double screenHeight,
      String imagePath, String title, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: screenWidth * 0.29,
        height: screenHeight * 0.175,
        decoration: BoxDecoration(
          color: Constants().tileColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: screenHeight * 0.03),
                child: Image(image: AssetImage(imagePath)),
              ),
              Divider(
                indent: screenWidth / 45,
                endIndent: screenWidth / 45,
                thickness: screenWidth * 0.005,
                color: Color.fromRGBO(255, 255, 255, 0.9),
              ),
              SizedBox(height: screenHeight * 0.01),
              Center(
                child: Text(
                  title,
                  style: TextStyle(
                    color: Constants().textColor,
                    fontSize: screenWidth * 0.035,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
