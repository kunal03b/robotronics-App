import 'package:flutter/material.dart';
import 'package:robotronics/chatGPT.dart';
import 'package:robotronics/constants.dart';
import 'package:robotronics/newTask.dart';
import 'package:robotronics/projects.dart';
import 'package:robotronics/reusable.dart';
import 'package:robotronics/task%20Manager%20Screen/tasksScreen.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Home extends StatefulWidget {
  const Home({Key? key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String? selectedCategory;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double avatarRadius = screenWidth * 0.05;
    final double appBarIconSize = screenWidth * 0.13;
    return Scaffold(
      floatingActionButton: Container(
        // width: screenWidth * 0.1,
        // height: screenHeight * 0.09,
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              color: Constants().tileColor,
              spreadRadius: 4,
              blurRadius: 10,
              offset: Offset(0, 0)),
        ], borderRadius: BorderRadius.circular(100)),
        child: FloatingActionButton(
          elevation: 0,
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => chatGPT()));
          },
          backgroundColor: Constants().textColor,

          child: Image(image: AssetImage('assets/chatgpt.png')),

          // child: Icon(
          //   Icons.,
          //   color: Constants().buttonBackground,
          // ),
        ),
      ),
      appBar: appBarMethod(screenHeight, appBarIconSize, avatarRadius),
      backgroundColor: Constants().buttonBackground,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: screenWidth * 0.03),
                    child: Text(
                      'UPCOMING EVENTS',
                      style: TextStyle(
                          color: Constants().textColor,
                          fontSize: screenWidth * 0.05,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.015,
                  ),
                  CarouselSlider(
                    options: CarouselOptions(
                      autoPlay: true,
                      aspectRatio: 16 / 7,
                      viewportFraction: 0.79,
                      enlargeCenterPage: true,
                    ),
                    items: [
                      Container(
                        width: screenWidth * 1,
                        height: screenHeight * 0.25,
                        decoration: BoxDecoration(
                            // image: DecorationImage(
                            //     image: NetworkImage(p1 ?? ''),
                            //     fit: BoxFit.fill),
                            color: Constants().tileColor,
                            borderRadius: BorderRadius.circular(27)),
                      ),
                      Container(
                        width: screenWidth * 1,
                        height: screenHeight * 0.25,
                        decoration: BoxDecoration(
                            // image: DecorationImage(
                            //     image: NetworkImage(p2 ?? ''),
                            //     fit: BoxFit.fill),
                            color: Constants().tileColor,
                            borderRadius: BorderRadius.circular(27)),
                      ),
                      Container(
                        width: screenWidth * 1,
                        height: screenHeight * 0.25,
                        decoration: BoxDecoration(
                            // image: DecorationImage(
                            //     image: NetworkImage(p3 ?? ''),
                            //     fit: BoxFit.fill),
                            color: Constants().tileColor,
                            borderRadius: BorderRadius.circular(27)),
                      ),
                      Container(
                        width: screenWidth * 1,
                        height: screenHeight * 0.25,
                        decoration: BoxDecoration(
                            // image: DecorationImage(
                            //     image: NetworkImage(p4 ?? ''),
                            //     fit: BoxFit.fill),
                            color: Constants().tileColor,
                            borderRadius: BorderRadius.circular(27)),
                      ),

                      // Add more Image widgets with different photos
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: screenHeight * 0.03,
            ),
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
                    child: Container(
                      width: screenWidth * 0.2,
                      height: screenHeight * 0.025,
                      child: Text(
                        'Add Task',
                        style: TextStyle(color: Constants().textColor),
                      ),
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
                  'Operational',
                  () {
                    setState(() {
                      selectedCategory = 'Operational';
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TaskManagerScreen(
                          selectedCategory: selectedCategory ?? "",
                        ),
                      ),
                    );
                    // print('Coming from Operational Tasks');
                  },
                ),
                buildTaskCard(
                  screenWidth,
                  screenHeight,
                  'assets/Technical.png',
                  'Technical',
                  () {
                    setState(() {
                      selectedCategory = 'Technical';
                    });

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TaskManagerScreen(
                          selectedCategory: selectedCategory ?? "",
                        ),
                      ),
                    );
                    print('Coming from Technical Tasks');
                  },
                ),
                buildTaskCard(
                  screenWidth,
                  screenHeight,
                  'assets/Marketing.png',
                  'Marketing',
                  () {
                    setState(() {
                      selectedCategory = 'Marketing';
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TaskManagerScreen(
                          selectedCategory: selectedCategory ?? "",
                        ),
                      ),
                    );
                    print('Coming from Marketing Tasks');
                  },
                ),
              ],
            ),
            SizedBox(
              height: screenHeight * 0.065,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: screenWidth * 0.03),
                  child: Text(
                    'PREVIOUS PROJECTS',
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
                      print('Hello from PREVIOUS PROJECTS');
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Projects()));
                    },
                    child: Container(
                      width: screenWidth * 0.16,
                      height: screenHeight * 0.025,
                      child: Text(
                        'View All',
                        style: TextStyle(color: Constants().textColor),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            Center(
              child: Container(
                  width: screenWidth * 0.95,
                  height: screenHeight * 0.04,
                  decoration: BoxDecoration(
                      color: Constants().textColor,
                      borderRadius: BorderRadius.circular(11)),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: screenWidth * 0.03),
                        child: Icon(Icons.search),
                      ),
                      SizedBox(
                        width: screenWidth * 0.01,
                      ),
                      Expanded(child: TextField())
                    ],
                  )),
            ),
            SizedBox(
              height: screenHeight * 0.01,
            ),
            Center(
              child: Container(
                height: screenHeight * 0.17,
                width: screenWidth * 0.95,
                decoration: BoxDecoration(
                    color: Constants().container,
                    borderRadius: BorderRadius.circular(12)),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildTaskCard(double screenWidth, double screenHeight,
      String imagePath, String title, VoidCallback onTap) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TaskManagerScreen(selectedCategory: title),
          ),
        );
      },
      child: Container(
        width: screenWidth * 0.29,
        height: screenHeight * 0.175,
        decoration: BoxDecoration(
          color: selectedCategory == title
              ? Constants().tileColor
              : Constants().tileColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: screenHeight * 0.03),
                child: Image(image: AssetImage(imagePath)),
              ),
              SizedBox(
                height: screenHeight * 0.005,
              ),
              Divider(
                indent: screenWidth / 45,
                endIndent: screenWidth / 45,
                thickness: screenWidth * 0.005,
                color: Color.fromRGBO(255, 255, 255, 0.9),
              ),
              SizedBox(height: screenHeight * 0.005),
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

class upcomingEventTile extends StatelessWidget {
  const upcomingEventTile({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
  });

  final double screenWidth;
  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: Constants().container,
          minRadius: 25,
        ),
        SizedBox(
          width: screenWidth * 0.035,
        ),
        Container(
          height: screenHeight * 0.05,
          width: screenWidth * 0.69,
          decoration: BoxDecoration(
              color: Constants().container,
              borderRadius: BorderRadius.circular(20)),
        )
      ],
    );
  }
}
