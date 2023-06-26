import 'package:flutter/material.dart';

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
  final T groupValue;
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
        unselectedWidgetColor:
            Colors.white, // Set the unselected color to white
      ),
      child: RadioListTile<T>(
        value: value,
        groupValue: groupValue,
        onChanged: onChanged,
        activeColor: Colors.white,
        title: Text(
          title,
          style: TextStyle(color: Colors.white), // Set the text color to white
        ),
        controlAffinity: ListTileControlAffinity.leading,
      ),
    );
  }
}
