import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:robotronics/home.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(TaskManagerApp());
}

class TaskManagerApp extends StatefulWidget {
  @override
  State<TaskManagerApp> createState() => _TaskManagerAppState();
}

class _TaskManagerAppState extends State<TaskManagerApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Manager',
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}
