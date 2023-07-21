import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:robotronics/constants.dart';
import 'package:robotronics/projects.dart';
import 'package:robotronics/reusable.dart';

class ViewProjectDetail extends StatefulWidget {
  final String projectId;

  const ViewProjectDetail({Key? key, required this.projectId})
      : super(key: key);

  @override
  State<ViewProjectDetail> createState() => _ViewProjectDetailState();
}

class _ViewProjectDetailState extends State<ViewProjectDetail> {
  String projectTitle = '';
  String projectDescription = '';
  String thumbnailUrl = '';

  @override
  void initState() {
    super.initState();
    fetchProjectDetails();
  }

  Future<void> fetchProjectDetails() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('Project')
        .doc(widget.projectId)
        .get();

    if (snapshot.exists) {
      final projectData = snapshot.data() as Map<String, dynamic>;
      setState(() {
        projectTitle = projectData['title'] ?? '';
        projectDescription = projectData['description'] ?? '';
        thumbnailUrl = projectData['thumbnailUrl'] ?? '';
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
      appBar: appBarMethod2(
          context, screenHeight, appBarIconSize, avatarRadius, Projects()),
      backgroundColor: Constants().buttonBackground,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: screenWidth * 1,
            height: screenHeight * 0.2535,
            color: Constants().tileColor,
            child: Stack(
              children: [
                if (thumbnailUrl.isNotEmpty)
                  Image.network(
                    thumbnailUrl,
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.fitWidth,
                  ),
                if (thumbnailUrl.isEmpty)
                  Center(
                    child: CircularProgressIndicator(),
                  ),
              ],
            ),
          ),
          SizedBox(
            height: screenHeight * 0.025,
          ),
          Padding(
            padding: EdgeInsets.only(
              left: screenWidth * 0.02,
              right: screenWidth * 0.02,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  projectTitle.toUpperCase(),
                  style: TextStyle(
                    color: Constants().textColor,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.01,
                ),
                Text(
                  projectDescription,
                  style: TextStyle(
                    color: Constants().textColor,
                    fontWeight: FontWeight.w300,
                    fontSize: 15,
                    height: 1.35,
                  ),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(
                  height: screenHeight * 0.025,
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
                    children: [
                      ViewTaskTile(
                        screenHeight: screenHeight,
                        screenWidth: screenWidth,
                        imagePath: 'assets/repository.png',
                        text: 'Repository',
                        onTap: () {},
                        linkUrl: 'https://github.com/kunal03b/robotronics-App',
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
                    children: [
                      ViewTaskTile(
                        screenHeight: screenHeight,
                        screenWidth: screenWidth,
                        imagePath: 'assets/github.png',
                        text: 'Github',
                        onTap: () {},
                        linkUrl: 'https://github.com/kunal03b/robotronics-App',
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
        ],
      ),
    );
  }
}
