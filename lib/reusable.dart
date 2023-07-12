import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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

class WhiteRadioListTile<T> extends StatefulWidget {
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
  State<WhiteRadioListTile<T>> createState() => _WhiteRadioListTileState<T>();
}

class _WhiteRadioListTileState<T> extends State<WhiteRadioListTile<T>> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        unselectedWidgetColor: Colors.white,
      ),
      child: RadioListTile<T>(
        value: widget.value,
        groupValue: widget.groupValue,
        onChanged: widget.onChanged,
        activeColor: Colors.white,
        title: Text(
          widget.title,
          style: TextStyle(color: Constants().textColor),
        ),
        controlAffinity: ListTileControlAffinity.leading,
      ),
    );
  }
}

class dateWidget extends StatefulWidget {
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
  State<dateWidget> createState() => _dateWidgetState();
}

class _dateWidgetState extends State<dateWidget> {
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
          widget.onDateSelected(picked);
          print('Selected Date: $picked');
        }
      },
      child: Container(
        width: widget.screenWidth * 0.38,
        height: widget.screenHeight * 0.038,
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
                  widget.selectedDate.isNotEmpty
                      ? widget.selectedDate
                      : 'DD/MM/YYYY',
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

class ViewTaskTile extends StatefulWidget {
  final double screenHeight;
  final double screenWidth;
  final String imagePath;
  final String text;
  final VoidCallback onTap;
  final String linkUrl;

  const ViewTaskTile({
    required this.screenHeight,
    required this.screenWidth,
    required this.imagePath,
    required this.text,
    required this.onTap,
    required this.linkUrl,
  });

  @override
  State<ViewTaskTile> createState() => _ViewTaskTileState();
}

class _ViewTaskTileState extends State<ViewTaskTile> {
  @override
  Future<void> _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _launchUrl(widget.linkUrl),
      child: Container(
        height: widget.screenHeight * 0.13,
        width: widget.screenWidth * 0.241,
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
                  widget.imagePath,
                  width: widget.screenWidth * 0.24,
                  height: widget.screenHeight * 0.056,
                ),
              ),
              SizedBox(height: widget.screenHeight * 0.026),
              Center(child: Text(widget.text)),
            ],
          ),
        ),
      ),
    );
  }
}

// Visibility widget

class ExpandableContainer extends StatefulWidget {
  final String title;
  final List<Widget> children;

  ExpandableContainer({required this.title, required this.children});

  @override
  _ExpandableContainerState createState() => _ExpandableContainerState();
}

class _ExpandableContainerState extends State<ExpandableContainer> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
          child: Row(
            children: <Widget>[
              Text(widget.title,
                  style:
                      TextStyle(fontSize: 16.0, color: Constants().textColor)),
              Icon(
                _isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                color: Constants().textColor,
                size: 35,
              ),
            ],
          ),
        ),
        Visibility(
          visible: _isExpanded,
          child: Column(
            children: widget.children,
          ),
        ),
      ],
    );
  }
}
