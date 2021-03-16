import 'package:flutter/material.dart';

class MajorPickerPage extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => MajorPickerPage());
  }

  @override
  _MajorPickerPageState createState() => _MajorPickerPageState();
}

class _MajorPickerPageState extends State<MajorPickerPage> {
  String selectedValue = "";

  final List<String> data = [
    "CNKT điện, điện tử",
    "CNKT điện tử - viễn thông",
    "CNKT máy tính",
    "CNKT điều khiển và tự động hóa",
    "Kỹ thuật y sinh",
    "Hệ thống nhúng và IoT",
    "Robot và trí tuệ nhân tạo",
    "CN chế tạo máy",
    "CNKT cơ điện tử",
    "CNKT cơ khí",
    "Kỹ thuật công nghiệp",
    "Kỹ nghệ gỗ và nội thất",
    "CNKT công trình xây dựng",
    "Kỹ thuật xây dựng công trình giao thông",
    "Quản lý xây dựng",
    "Hệ thống kỹ thuật công trình xây dựng",
    "CNKT ô tô",
    "CNKT nhiệt",
    "Năng lượng tái tạo",
    "CN thông tin",
    "Kỹ thuật dữ liệu",
    "Quản lý công nghiệp",
    "Kế toán",
    "Thương mại điện tử",
    "Logistics và quản lý chuỗi cung ứng",
    "Kinh doanh Quốc tế",
    "Công nghệ may",
    "CN Kỹ thuật in",
    "Thiết kế đồ họa",
    "Kiến trúc",
    "Kiến trúc nội thất",
    "CNKT môi trường",
    "CN thực phẩm",
    "CNKT hóa học",
    "Quản trị NH và DV ăn uống",
    "Thiết kế thời trang",
    "Sư phạm tiếng Anh",
    "Ngôn ngữ Anh",
  ];

  @override
  Widget build(BuildContext context) {
    List<Widget> majors = [];
    data.forEach((element) {
      majors.add(Card(
        child: Center(
          child: ListTile(
            trailing: selectedValue == element
                ? Icon(
                    Icons.check_circle_rounded,
                    color: Colors.lightGreenAccent,
                  )
                : null,
            title: Text(
              element,
              style: TextStyle(
                fontWeight: selectedValue == element ? FontWeight.bold : null,
              ),
            ),
            onTap: () {
              if (selectedValue != element) {
                setState(() {
                  selectedValue = element;
                });
              } else {
                setState(() {
                  selectedValue = "";
                });
              }
            },
          ),
        ),
      ));
    });
    return Scaffold(
      appBar: AppBar(
        actions: [
          selectedValue != ""
              ? IconButton(
                  icon: Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(context, selectedValue);
                  },
                )
              : Container(),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(5.0),
        physics: const ScrollPhysics(),
        shrinkWrap: true,
        children: majors,
      ),
    );
  }
}
