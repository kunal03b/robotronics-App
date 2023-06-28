import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:robotronics/constants.dart';
import 'package:robotronics/reusable.dart';
import 'package:intl/intl.dart';

class NewTask extends StatefulWidget {
  @override
  _NewTaskState createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  String selectedDate = '';
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  String? selectedCategory;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double avatarRadius = screenWidth * 0.05;
    final double appBarIconSize = screenWidth * 0.13;
    String cdate = DateFormat("yyyy-MM-dd").format(DateTime.now());
    print(cdate);

    Future<void> updateAssignedDate(String taskId) async {
      final DateTime currentDate = DateTime.now();
      final String formattedDate = DateFormat('dd/MM/yyyy').format(currentDate);

      try {
        await firestore
            .collection('task')
            .doc(taskId)
            .update({'assignedDate': formattedDate});
        print('Assigned date updated successfully');
      } catch (error) {
        print('Failed to update assigned date: $error');
      }
    }

    Future<void> addTask() async {
      CollectionReference taskCollection = firestore.collection('task');

      Map<String, dynamic> taskData = {
        'title': titleController.text,
        'description': descriptionController.text,
        'deadline': selectedDate,
        'assignedDate': '',
        'category': selectedCategory,
      };

      try {
        DocumentReference docRef = await taskCollection.add(taskData);
        String taskId = docRef.id;
        print('Task added successfully!');
        await updateAssignedDate(taskId);
      } catch (error) {
        print('Failed to add task: $error');
      }
    }

    return Scaffold(
      backgroundColor: Constants().buttonBackground,
      appBar: appBarMethod(screenHeight, appBarIconSize, avatarRadius),
      body: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom:
                        BorderSide(color: Constants().textColor, width: 2.0),
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
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2100),
                  );
                  if (picked != null) {
                    setState(() {
                      selectedDate =
                          DateFormat('dd/MM/yyyy').format(picked).toString();
                    });
                  }
                },
                child: Container(
                    width: screenWidth * 0.4,
                    height: screenHeight * 0.05,
                    decoration: BoxDecoration(
                      border:
                          Border.all(color: Constants().textColor, width: 1.6),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.calendar_today_rounded,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: screenWidth * 0.015,
                        ),
                        Center(
                          child: Text(
                            selectedDate.isNotEmpty
                                ? selectedDate
                                : 'Select Date',
                            style: TextStyle(
                              color: Constants().textColor,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
              SizedBox(
                height: screenHeight * 0.03,
              ),
              Text(
                'Choose One:',
                style: TextStyle(color: Constants().textColor, fontSize: 18),
              ),
              SizedBox(
                height: screenHeight * 0.008,
              ),
              Row(
                children: [
                  Container(
                    height: screenHeight * 0.235,
                    width: screenWidth * 0.45,
                    decoration: BoxDecoration(
                      border:
                          Border.all(color: Constants().textColor, width: 1.6),
                    ),
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        WhiteRadioListTile<String>(
                          value: 'Operational',
                          groupValue: selectedCategory,
                          onChanged: (value) {
                            setState(() {
                              selectedCategory = value;
                            });
                          },
                          title: 'Operational',
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 0),
                          child: Divider(
                              color: Constants().textColor, thickness: 1.0),
                        ),
                        WhiteRadioListTile<String>(
                          value: 'Technical',
                          groupValue: selectedCategory,
                          onChanged: (value) {
                            setState(() {
                              selectedCategory = value;
                            });
                          },
                          title: 'Technical',
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 0),
                          child: Divider(
                              color: Constants().textColor, thickness: 1.0),
                        ),
                        WhiteRadioListTile<String>(
                          value: 'Marketing',
                          groupValue: selectedCategory,
                          onChanged: (value) {
                            setState(() {
                              selectedCategory = value;
                            });
                          },
                          title: 'Marketing',
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      addTask();
                    },
                    child: Container(
                      width: screenWidth * 0.15,
                      height: screenHeight * 0.15,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromRGBO(255, 255, 255, 1),
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        '>',
                        style: TextStyle(
                            fontSize: 60,
                            // fontWeight: FontWeight.w900,
                            color: Color.fromRGBO(32, 38, 46, 1)),
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
