import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class TaskModel {
  String? docID;
  final String title;
  final String description;
  final String deadline;
  final String taskCategory;
  final String assignedDate;

  TaskModel(
      {this.docID,
      required this.title,
      required this.description,
      required this.deadline,
      required this.taskCategory,
      required this.assignedDate});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'docsID': docID,
      'title': title,
      'description': description,
      'deadline': deadline,
      'taskCategory': taskCategory,
      'assignedDate': assignedDate,
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      docID: map['docsID'] != null ? map['docsID'] as String : null,
      title: map['title'] as String,
      description: map['description'] as String,
      deadline: map['deadline'] as String,
      taskCategory: map['taskCategory'] as String,
      assignedDate: map['assignedDate'] as String,
    );
  }

  factory TaskModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> doc) {
    return TaskModel(
        docID: doc.id,
        title: doc['title'],
        description: doc['description'],
        deadline: doc['deadline'],
        taskCategory: doc['taskCategory'],
        assignedDate: doc['assignedDate']);
  }
}
