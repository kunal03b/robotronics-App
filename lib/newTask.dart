import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:robotronics/constants.dart';
import 'package:robotronics/home.dart';
import 'package:robotronics/reusable.dart';

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

  List<String> availableMembers = [];
  late List<bool> selectedMembers = [];

  @override
  void initState() {
    super.initState();
    fetchCoreMembers().then((members) {
      setState(() {
        availableMembers = members;
        selectedMembers = List<bool>.filled(members.length, false);
      });
    });
  }

  Future<List<String>> fetchAvailableMembers(String taskId) async {
    final snapshot = await firestore.collection('task').doc(taskId).get();
    final data = snapshot.data();
    if (data != null && data.containsKey('availableMembers')) {
      return List<String>.from(data['availableMembers']);
    }
    return [];
  }

  Future<List<String>> fetchCoreMembers() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('Role', isEqualTo: 'Core Member')
        .get();
    final List<String> members = snapshot.docs
        .map((doc) => (doc.data() as Map<String, dynamic>)['Name'] as String)
        .toList();
    return members;
  }

  Future<void> updateAssignedMembers(
      String taskId, List<String> assignedMembers) async {
    try {
      await firestore
          .collection('task')
          .doc(taskId)
          .update({'assignedMembers': assignedMembers});
      print('Assigned members updated successfully');
    } catch (error) {
      print('Failed to update assigned members: $error');
    }
  }

  List<String> getSelectedMembers() {
    List<String> selected = [];
    for (int i = 0; i < availableMembers.length; i++) {
      if (selectedMembers[i]) {
        selected.add(availableMembers[i]);
      }
    }
    return selected;
  }

  Future<void> saveDataToFirebase(String firebaseLink) async {
    final CollectionReference taskCollection = firestore.collection('task');

    Map<String, dynamic> taskData = {
      'firebaseLink': firebaseLink,
    };

    try {
      await taskCollection.add(taskData);
      print('Data saved to Firebase successfully!');
    } catch (error) {
      print('Failed to save data to Firebase: $error');
    }
  }

  final TextEditingController _firebaseLinkController = TextEditingController();

  @override
  void dispose() {
    _firebaseLinkController.dispose();
    super.dispose();
  }

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
      if (titleController.text.isEmpty ||
          descriptionController.text.isEmpty ||
          selectedDate.isEmpty ||
          selectedCategory == null) {
        Fluttertoast.showToast(msg: 'Please fill in all the required fields');
        return;
      }

      CollectionReference taskCollection = firestore.collection('task');

      Map<String, dynamic> taskData = {
        'title': titleController.text,
        'description': descriptionController.text,
        'deadline': selectedDate,
        'assignedDate': '',
        'category': selectedCategory,
        'assignedMembers': getSelectedMembers(),
      };

      try {
        DocumentReference docRef = await taskCollection.add(taskData);
        String taskId = docRef.id;
        print('Task added successfully!');
        await updateAssignedMembers(taskId, getSelectedMembers());
        await updateAssignedDate(taskId);

        Fluttertoast.showToast(msg: 'Task Saved');
      } catch (error) {
        print('Failed to add task: $error');
      }
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (titleController.text.isEmpty ||
              descriptionController.text.isEmpty ||
              selectedDate.isEmpty ||
              selectedCategory == null) {
            Fluttertoast.showToast(
                msg: 'Please fill in all the required fields');
          } else {
            addTask().then((value) {
              Fluttertoast.showToast(msg: 'Task Saved');
              Navigator.pop(context, Home());
            });
          }
        },
        backgroundColor: Constants().textColor,
        child: Container(
          width: screenWidth * 0.1,
          height: screenHeight * 0.05,
          child: Image.asset(
            'assets/folder.png',
            color: Constants().buttonBackground,
          ),
        ),
      ),
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
                    hintText: "Add Title",
                    hintStyle:
                        TextStyle(color: Constants().textColor, fontSize: 27),
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.045),
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
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.045,
              ),
              ExpandableContainer(title: 'Assigned Members', children: [
                FutureBuilder<List<String>>(
                  future: fetchCoreMembers(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      availableMembers = snapshot.data!;
                      return SingleChildScrollView(
                        child: ListView.separated(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: availableMembers.length,
                          separatorBuilder: (context, index) => SizedBox(
                            height: 2,
                          ),
                          itemBuilder: (context, index) {
                            final member = availableMembers[index];
                            final isSelected = selectedMembers[index];

                            return InkWell(
                              onTap: () {
                                setState(() {
                                  selectedMembers[index] = !isSelected;
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                    color: isSelected
                                        ? Constants().tileColor
                                        : null,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 20,
                                      child: Text(
                                        availableMembers[index][0],
                                        style: TextStyle(
                                            fontSize: 16,
                                            color:
                                                Constants().buttonBackground),
                                        textAlign: TextAlign.center,
                                      ),
                                      backgroundColor: Constants().container,
                                    ),
                                    SizedBox(
                                      width: screenWidth * 0.05,
                                    ),
                                    Text(
                                      member,
                                      style: TextStyle(
                                          color: Constants().textColor),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Text('Failed to fetch available members');
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                ),
              ]),
              SizedBox(
                height: screenHeight * 0.03,
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
                      color: Color.fromRGBO(217, 217, 217, 0.41),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Icon(
                            Icons.calendar_today_rounded,
                            color: Colors.white,
                          ),
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: screenHeight * 0.235,
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
                ],
              ),
              SizedBox(
                height: screenHeight * 0.03,
              ),
              Text(
                'Add Docs:',
                style: TextStyle(color: Constants().textColor, fontSize: 18),
              ),
              InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Firebase Link'),
                        content: TextField(
                          cursorColor: Constants().buttonBackground,
                          controller: _firebaseLinkController,
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              String firebaseLink =
                                  _firebaseLinkController.text;
                              saveDataToFirebase(firebaseLink);
                              Navigator.of(context).pop();
                            },
                            child: Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Container(
                  height: screenHeight * 0.13,
                  width: screenWidth * 0.241,
                  decoration: BoxDecoration(
                    color: Constants().container,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 0),
                          child: Image.asset(
                            'assets/firebase.png',
                            width: screenHeight * 0.24,
                            height: screenHeight * 0.056,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.026),
                        Text('text'),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
