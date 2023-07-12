import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:robotronics/addProject.dart';
import 'package:robotronics/reusable.dart';

import 'constants.dart';

class projects extends StatefulWidget {
  const projects({Key? key});

  @override
  State<projects> createState() => _projectsState();
}

class _projectsState extends State<projects> {
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
        children: [
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
                    print('Hello from Add Project');
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => addProject()));
                  },
                  child: Container(
                    width: screenWidth * 0.2,
                    height: screenHeight * 0.025,
                    child: Center(
                      child: Text(
                        'Add Project',
                        style: TextStyle(
                            color: Constants().textColor, fontSize: 11),
                      ),
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
              width: screenWidth * 0.9,
              height: screenHeight * 0.04,
              decoration: BoxDecoration(
                color: Constants().textColor,
                borderRadius: BorderRadius.circular(11),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: screenWidth * 0.03),
                    child: Icon(Icons.search),
                  ),
                  SizedBox(
                    width: screenWidth * 0.01,
                  ),
                  Expanded(
                    child: TextField(
                      cursorColor: Constants().buttonBackground,
                      decoration: InputDecoration(border: InputBorder.none),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: screenHeight * 0.03,
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('Project').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final projectDocs = snapshot.data!.docs;
                  return ListView.builder(
                    itemCount: projectDocs.length,
                    itemBuilder: (context, index) {
                      final project =
                          projectDocs[index].data() as Map<String, dynamic>;
                      final title = project['title'] ?? '';
                      final description = project['description'] ?? '';
                      final imageURL = project['imageURL'] ?? '';

                      final isEvenIndex = index % 2 == 0;
                      final backgroundColor = isEvenIndex
                          ? Constants().container
                          : Constants().tileColor;

                      final titleColor = isEvenIndex
                          ? Constants().buttonBackground
                          : Constants().textColor;

                      final descColor = isEvenIndex
                          ? Color.fromRGBO(0, 0, 0, 1)
                          : Constants().container;

                      return Padding(
                        padding: EdgeInsets.only(bottom: screenHeight * 0.025),
                        child: Container(
                          // color: backgroundColor,
                          width: screenWidth * 0.867,
                          height: screenHeight * 0.173,
                          decoration: BoxDecoration(
                            color: backgroundColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  left: screenWidth * 0.05,
                                  top: screenHeight * 0.015,
                                ),
                                child: Container(
                                  width: screenWidth * 0.52,
                                  height: screenHeight / 5.5,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        title.toUpperCase(),
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.w900,
                                            color: titleColor),
                                      ),
                                      SizedBox(
                                        height: screenHeight * 0.002,
                                      ),
                                      Text(
                                        description,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w100,
                                            fontSize: 10,
                                            color: descColor),
                                      ),
                                      SizedBox(
                                        height: screenHeight * 0.045,
                                      ),
                                      Container(
                                        width: screenWidth * 0.28,
                                        height: screenHeight * 0.037,
                                        decoration: BoxDecoration(
                                          color: Constants().buttonBackground,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Center(
                                          child: Text(
                                            "Know More",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Constants().textColor,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.only(right: screenWidth * 0.05),
                                child: Container(
                                  width: screenWidth * 0.22,
                                  height: screenHeight * 0.136,
                                  child: Image.asset(
                                    "assets/project.png",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
