import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class FetchData extends StatefulWidget {
  const FetchData({Key? key}) : super(key: key);

  @override
  State<FetchData> createState() => _FetchDataState();
}

class _FetchDataState extends State<FetchData> {
  List<Map<String, dynamic>> coreMembers = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: coreMembers.length,
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 50,
                  child: Text(
                    coreMembers[index]['name'],
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(width: 16),
                Text(
                  coreMembers[index]['name'],
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void fetchData() async {
    // Initialize Firebase
    await Firebase.initializeApp();

    // Get the Firebase collection reference
    CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('users');

    // Query the users collection for core members
    QuerySnapshot querySnapshot =
        await usersCollection.where('Role', isEqualTo: 'Core Member').get();

    // Extract the UIDs and names from the query snapshot
    coreMembers = querySnapshot.docs
        .map((doc) => {
              'uid': doc.id,
              'name': (doc.data() as Map<String, dynamic>?)?['Name'] ?? ''
            })
        .toList();

    setState(() {});
  }
}
