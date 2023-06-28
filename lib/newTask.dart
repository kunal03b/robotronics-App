import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:robotronics/constants.dart';
import 'package:robotronics/reusable.dart';
import 'package:intl/intl.dart';

class newTask extends StatelessWidget {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  String selectedDate = '';
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double avatarRadius = screenWidth * 0.05;
    final double appBarIconSize = screenWidth * 0.13;

    return Scaffold(
      backgroundColor: Constants().buttonBackground,
      appBar: appBarMethod(screenHeight, appBarIconSize, avatarRadius),
      body: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Constants().textColor, width: 2.0),
                ),
              ),
              child: TextField(
                controller: titleController,
                style: TextStyle(color: Constants().textColor, fontSize: 20),
                decoration: InputDecoration(
                  hintText: 'Add Title',
                  hintStyle:
                      TextStyle(color: Constants().textColor, fontSize: 27),
                  border: InputBorder.none,
                ),
              ),
            ),
            SizedBox(height: 50),
            TextField(
              controller: descriptionController,
              maxLines: 3,
              style: TextStyle(color: Constants().textColor),
              decoration: const InputDecoration(
                labelText: 'Add Description',
                alignLabelWithHint: true,
                labelStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  // fontWeight: FontWeight.bold,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Text(
              'Assigned Members',
              style: TextStyle(color: Constants().textColor, fontSize: 16),
            ),
            SizedBox(
              height: screenHeight * 0.1,
            ),
            Text(
              'Deadline:',
              style: TextStyle(color: Constants().textColor, fontSize: 18),
            ),
            SizedBox(
              height: screenHeight * 0.012,
            ),
            InkWell(
              onTap: () async {
                final DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2021),
                  lastDate: DateTime(2025),
                );

                if (picked != null) {
                  selectedDate = DateFormat('dd/MM/yyyy').format(picked);
                  print('Selected Date: $selectedDate');
                }
              },
              child: Container(
                width: screenWidth * 0.5,
                height: screenHeight * 0.05,
                decoration: BoxDecoration(
                  border: Border.all(color: Constants().textColor, width: 1.6),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.calendar_today,
                        color: Constants().textColor,
                      ),
                      Text(
                        selectedDate.isNotEmpty ? selectedDate : 'Select Date',
                        style: TextStyle(
                          color: Constants().textColor,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Text(
              'Choose One:',
              style: TextStyle(color: Constants().textColor, fontSize: 18),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Container(
                  height: screenHeight * 0.17,
                  width: screenWidth * 0.5,
                  decoration: BoxDecoration(
                    border:
                        Border.all(color: Constants().textColor, width: 1.6),
                  ),
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      WhiteRadioListTile<String>(
                        value: 'Operational',
                        groupValue: '',
                        onChanged: (value) {},
                        title: 'Operational',
                      ),
                      Divider(color: Constants().textColor, thickness: 1.0),
                      WhiteRadioListTile<String>(
                        value: 'Technical',
                        groupValue: '',
                        onChanged: (value) {},
                        title: 'Technical',
                      ),
                      Divider(color: Constants().textColor, thickness: 1.0),
                      WhiteRadioListTile<String>(
                        value: 'Marketing',
                        groupValue: '',
                        onChanged: (value) {},
                        title: 'Marketing',
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 40),
                  child: ElevatedButton(
                    onPressed: () {
                      DocumentReference taskRef =
                          firestore.collection('task').doc();

                      Map<String, dynamic> taskData = {
                        'title': titleController.text,
                        'description': descriptionController.text,
                        'deadline': selectedDate,
                        'assignedDate': Timestamp.now(),
                      };

                      taskRef.set(taskData).then((value) {
                        print('Task saved successfully!');
                      }).catchError((error) {
                        print('Failed to save task: $error');
                      });
                    },
                    child: Text(
                      'Save',
                      style: TextStyle(color: Colors.black),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Constants().textColor),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
