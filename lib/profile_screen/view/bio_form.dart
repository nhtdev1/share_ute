import 'package:flutter/material.dart';
import 'package:share_ute/profile_screen/profile_screen.dart';
import 'package:share_ute/profile_screen/view/faculty_picker_page.dart';
import 'package:share_ute/profile_screen/view/major_picker_page.dart';

class BioForm extends StatefulWidget {
  const BioForm({Key key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const BioForm());
  }

  @override
  _BioFormState createState() => _BioFormState();
}

class _BioFormState extends State<BioForm> {
  String year = "2020";
  String major = "CNKT điện, điển tử";
  String faculty = 'Hệ chất lượng cao';
  List<String> hobbies = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 1 / 5,
                  child: Text(
                    'Khóa',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    year,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                onTap: () async {
                  final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => YearPickerPage(
                                year: year,
                              )));
                  if (result != null) {
                    setState(() {
                      year = result;
                    });
                  }
                },
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Divider(),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 1 / 5,
                  child: Text(
                    'Khoa',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    faculty,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                onTap: () async {
                  final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FacultyPickerPage(
                                faculty: faculty,
                              )));
                  if (result != null) {
                    setState(() {
                      faculty = result;
                    });
                  }
                },
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Divider(),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 1 / 5,
                  child: Text(
                    'Ngành',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    major,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                onTap: () async {
                  final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MajorPickerPage()));
                  if (result != null) {
                    setState(() {
                      major = result;
                    });
                  }
                },
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Divider(),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 1 / 5,
                  child: Text(
                    'Quan tâm',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: GestureDetector(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      _buildHobbies(),
                      !hobbies.isNotEmpty
                          ? Container(
                              child: Text(
                                'Lựa chọn chủ để bạn quan tâm sẽ giúp chúng tôi tìm '
                                'kiếm tài liệu phù hợp cho bạn',
                                style: TextStyle(
                                  color: Colors.blue,
                                ),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                  onTap: () async {
                    final results = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HobbiesPickerPage(
                                  selectedValues: hobbies,
                                )));
                    setState(() {
                      hobbies = results;
                    });
                  },
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Divider(),
          ),
          Center(
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue.withOpacity(0.8),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                ),
                child: Text(
                  'CẬP NHẬT',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () {}),
          )
        ],
      ),
    );
  }

  _buildHobbies() {
    List<Widget> chips = [];
    hobbies.forEach((element) {
      chips.add(
        Container(
          padding: const EdgeInsets.all(2.0),
          child: Chip(
            deleteIconColor: Colors.white,
            onDeleted: () {
              setState(() {
                hobbies.remove(element);
              });
            },
            labelStyle: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            backgroundColor: Colors.lightBlueAccent,
            label: Text(
              element,
            ),
          ),
        ),
      );
    });

    return Wrap(
      children: chips,
    );
  }
}
