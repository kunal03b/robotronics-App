import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'constants.dart';

AppBar appBarMethod(
    double screenHeight, double appBarIconSize, double avatarRadius) {
  return AppBar(
    elevation: 0,
    backgroundColor: Color.fromRGBO(32, 38, 46, 1),
    toolbarHeight: screenHeight * 0.12,
    leading: IconButton(
      onPressed: () {},
      icon: Icon(
        Icons.menu,
        color: Color.fromRGBO(217, 217, 217, 1),
        size: appBarIconSize,
      ),
    ),
    actions: [
      IconButton(
        onPressed: () {},
        icon: CircleAvatar(
          backgroundColor: Colors.grey.shade100,
          backgroundImage: AssetImage('assets/Me.jpg'),
          radius: avatarRadius,
        ),
      ),
    ],
  );
}

class WhiteRadioListTile<T> extends StatelessWidget {
  final T value;
  final T? groupValue;
  final ValueChanged<T?> onChanged;
  final String title;

  const WhiteRadioListTile({
    Key? key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        unselectedWidgetColor: Colors.white,
      ),
      child: RadioListTile<T>(
        value: value,
        groupValue: groupValue,
        onChanged: onChanged,
        activeColor: Colors.white,
        title: Text(
          title,
          style: TextStyle(color: Colors.white),
        ),
        controlAffinity: ListTileControlAffinity.leading,
      ),
    );
  }
}

class dateWidget extends StatelessWidget {
  const dateWidget({
    Key? key,
    required this.screenWidth,
    required this.screenHeight,
    required this.onDateSelected,
    required this.selectedDate,
  }) : super(key: key);

  final double screenWidth;
  final double screenHeight;
  final Function(DateTime) onDateSelected;
  final String selectedDate;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2021),
          lastDate: DateTime(2025),
        );

        if (picked != null) {
          onDateSelected(picked);
          print('Selected Date: $picked');
        }
      },
      child: Container(
        width: screenWidth * 0.38,
        height: screenHeight * 0.038,
        decoration: BoxDecoration(
          color: Color.fromRGBO(217, 217, 217, 0.41),
          borderRadius: BorderRadius.circular(13),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Row(
            children: [
              Icon(
                CupertinoIcons.calendar,
                color: Constants().textColor,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 9),
                child: Text(
                  selectedDate.isNotEmpty ? selectedDate : 'DD/MM/YYYY',
                  style: TextStyle(color: Constants().textColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
