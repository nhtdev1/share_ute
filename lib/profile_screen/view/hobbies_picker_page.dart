import 'package:flutter/material.dart';

class HobbiesPickerPage extends StatefulWidget {
  const HobbiesPickerPage({this.selectedValues});

  final List<String> selectedValues;

  final List<String> data = const [
    "Công nghệ thông tin",
    "Kinh tế",
    "Ngôn ngữ Anh",
    "Điện tử",
    "Khoa học tự nhiên",
    "Cơ khí",
    "Lý luận chính trị",
    "Kiến trúc",
    "Biểu mẫu luận văn",
    "Đề tài tốt nghiệp",
  ];

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => HobbiesPickerPage());
  }

  @override
  _HobbiesPickerPageState createState() => _HobbiesPickerPageState();
}

class _HobbiesPickerPageState extends State<HobbiesPickerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: _buildHobbies(),
          ),
          Center(
            child: RaisedButton(
                color: Colors.blue.withOpacity(0.8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Text(
                  'Đồng ý',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context, widget.selectedValues);
                }),
          ),
        ],
      ),
    );
  }

  _buildHobbies() {
    List<Widget> choices = List();
    widget.data.forEach((element) {
      choices.add(Container(
        padding: const EdgeInsets.all(2.0),
        child: ChoiceChip(
          avatar: widget.selectedValues.contains(element)
              ? Icon(
                  Icons.check_circle_outline,
                  color: Colors.lightBlueAccent,
                )
              : null,
          label: Text(element),
          selected: widget.selectedValues.contains(element),
          onSelected: (selected) {
            setState(() {
              widget.selectedValues.contains(element)
                  ? widget.selectedValues.remove(element)
                  : widget.selectedValues.add(element);
            });
          },
        ),
      ));
    });
    return Wrap(
      children: choices,
    );
  }
}
