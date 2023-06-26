import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:robotronics/constants.dart';
import 'package:robotronics/reusable.dart';

class newtask extends StatelessWidget {
  const newtask({super.key});

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
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Constants().textColor, width: 2.0),
                ),
              ),
              child: TextField(
                style: TextStyle(color: Constants().textColor, fontSize: 20),
                decoration: InputDecoration(
                  hintText: 'Add Title',
                  hintStyle:
                      TextStyle(color: Constants().textColor, fontSize: 27),
                  border: InputBorder.none,
                ),
              )),
          SizedBox(height: 50),
          TextField(
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
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          // child:
          Text(
            'Assigned Members',
            style: TextStyle(color: Constants().textColor, fontSize: 16),
            // ),
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
          Container(
            width: screenWidth * 0.38,
            height: screenHeight * 0.038,
            decoration: BoxDecoration(
              color: Color.fromRGBO(217, 217, 217, 0.41),
              borderRadius: BorderRadius.circular(13),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Row(children: [
                Icon(
                  CupertinoIcons.calendar,
                  color: Constants().textColor,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 9),
                  child: Text(
                    'DD/MM/YYYY',
                    style: TextStyle(color: Constants().textColor),
                  ),
                )
              ]),
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

          Row(children: [
            Container(
              height: screenHeight * 0.17,
              width: screenWidth * 0.5,
              decoration: BoxDecoration(
                border: Border.all(color: Constants().textColor, width: 1.6),
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
                onPressed: () {},
                child: Text(
                  'Save',
                  style: TextStyle(color: Colors.black),
                ),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Constants().textColor),
                ),
              ),
            )
          ])
        ]),
      ),
    );
  }
}
