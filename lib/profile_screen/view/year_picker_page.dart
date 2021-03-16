import 'package:flutter/material.dart';

class YearPickerPage extends StatefulWidget {
  const YearPickerPage({this.year});

  final String year;

  final List<String> data = const [
    '2020',
    '2019',
    '2018',
    '2017',
    '2016',
    '2015',
    '2014',
    '2013',
    '2012',
  ];

  @override
  _YearPickerPageState createState() => _YearPickerPageState();
}

class _YearPickerPageState extends State<YearPickerPage> {
  String currentValue;

  @override
  void initState() {
    currentValue = widget.year;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: _buildYear(),
          ),
          Center(
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue.withOpacity(0.8),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                  padding: const EdgeInsets.all(10.0),
                ),
                child: Text(
                  'Đồng ý',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context, currentValue);
                }),
          ),
        ],
      ),
    );
  }

  _buildYear() {
    List<Widget> chips = [];
    widget.data.forEach((element) {
      chips.add(Container(
        padding: const EdgeInsets.all(5.0),
        child: ChoiceChip(
          label: Container(
            height: MediaQuery.of(context).size.height / 15,
            width: MediaQuery.of(context).size.width / 4.5,
            child: Center(
              child: Text(
                element,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          selectedColor: Colors.lightBlueAccent,
          selected: currentValue == element,
          onSelected: (selected) {
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
      ));
    });
    return Wrap(
      children: chips,
    );
  }
}
