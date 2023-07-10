import 'package:flutter/material.dart';
import 'package:robotronics/reusable.dart';

class addProject extends StatefulWidget {
  const addProject({super.key});

  @override
  State<addProject> createState() => _addProjectState();
}

class _addProjectState extends State<addProject> {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double avatarRadius = screenWidth * 0.05;
    final double appBarIconSize = screenWidth * 0.13;
    return Scaffold(
      appBar: appBarMethod(screenHeight, appBarIconSize, avatarRadius),
    );
  }
}
