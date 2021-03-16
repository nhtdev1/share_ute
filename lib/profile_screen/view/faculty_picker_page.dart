import 'package:flutter/material.dart';

class FacultyPickerPage extends StatefulWidget {
  const FacultyPickerPage({this.faculty});

  final String faculty;

  final List<String> data = const [
    'Hệ chất lượng cao',
    'Hệ đại trà',
  ];

  @override
  _FacultyPickerPageState createState() => _FacultyPickerPageState();
}

class _FacultyPickerPageState extends State<FacultyPickerPage> {
  String currentValue;

  @override
  void initState() {
    currentValue = widget.faculty;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          currentValue != ""
              ? IconButton(
                  icon: Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(context, currentValue);
                  },
                )
              : Container(),
        ],
      ),
      body: ListView(
        shrinkWrap: true,
        children: _buildFaculties(),
      ),
    );
  }

  _buildFaculties() {
    List<Widget> faculties = [];
    widget.data.forEach((element) {
      faculties.add(Card(
        child: Center(
          child: ListTile(
            trailing: currentValue == element
                ? Icon(
                    Icons.check_circle_rounded,
                    color: Colors.lightGreenAccent,
                  )
                : null,
            title: Text(
              element,
              style: TextStyle(
                fontWeight: currentValue == element ? FontWeight.bold : null,
              ),
            ),
            onTap: () {
              if (currentValue != element) {
                setState(() {
                  currentValue = element;
                });
              } else {
                setState(() {
                  currentValue = "";
                });
              }
            },
          ),
        ),
      ));
    });
    return faculties;
  }
}
