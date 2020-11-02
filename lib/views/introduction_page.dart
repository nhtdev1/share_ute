import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:share_ute/home/home.dart';

class IntroductionPage extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => IntroductionPage());
  }

  @override
  _IntroductionPageState createState() => _IntroductionPageState();
}

class _IntroductionPageState extends State<IntroductionPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => HomePage()),
      (route) => false,
    );
  }

  Widget _buildImage(String assetName) {
    return Align(
      child: Image.asset(assetName, width: 250.0),
      alignment: Alignment.bottomCenter,
    );
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);
    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );
    return Scaffold(
      body: IntroductionScreen(
        key: introKey,
        pages: [
          PageViewModel(
            title: "Bạn là sinh viên khóa?",
            bodyWidget: GridView.count(
              physics: ScrollPhysics(),
              shrinkWrap: true,
              crossAxisCount: 3,
              children: List.generate(9, (index) {
                return Card(
                  child: Center(
                    child: Text(
                      (2020 - index).toString(),
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              }),
            ),
            image: _buildImage('assets/images/intro.png'),
            decoration: pageDecoration,
          ),
          PageViewModel(
            title: "Bạn đến từ khoa?",
            bodyWidget: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Center(
                      child: Text(
                        'Hệ CLC',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Center(
                      child: Text(
                        'Hệ ĐT ',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            image: _buildImage('assets/images/intro.png'),
            decoration: pageDecoration,
          ),
          PageViewModel(
            title: "Bạn học ngành nào?",
            image: _buildImage('assets/images/intro.png'),
            bodyWidget: DropdownButton<ListItem>(
                value: _selectedItem,
                items: _dropdownMenuItems,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                onChanged: (value) {
                  setState(() {
                    _selectedItem = value;
                  });
                }),
            decoration: pageDecoration,
          ),
          PageViewModel(
            title: "Chủ đề bạn quan tâm là gì?",
            image: _buildImage('assets/images/intro.png'),
            bodyWidget: Wrap(
              children: List<Widget>.generate(
                16,
                (int index) {
                  return Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: ChoiceChip(
                      label: Text('CNTT'),
                      selected: true,
                      onSelected: (bool selected) {},
                    ),
                  );
                },
              ).toList(),
            ),
            decoration: pageDecoration,
          ),
        ],
        onDone: () => _onIntroEnd(context),
        //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
        showSkipButton: true,
        skipFlex: 0,
        nextFlex: 0,
        skip: const Text('Skip'),
        next: const Icon(Icons.arrow_forward),
        done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
        dotsDecorator: const DotsDecorator(
          size: Size(10.0, 10.0),
          color: Color(0xFFBDBDBD),
          activeSize: Size(22.0, 10.0),
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
          ),
        ),
      ),
    );
  }

  List<ListItem> _dropdownItems = [
    ListItem(1, "CNKT điện, điện tử"),
    ListItem(2, "CNKT điện tử - viễn thông"),
    ListItem(3, "CNKT máy tính"),
    ListItem(4, "CNKT điều khiển và tự động hóa"),
    ListItem(5, "Kỹ thuật y sinh"),
    ListItem(6, "Hệ thống nhúng và IoT"),
    ListItem(7, "Robot và trí tuệ nhân tạo"),
    ListItem(8, "CN chế tạo máy"),
    ListItem(9, "CNKT cơ điện tử"),
    ListItem(10, "CNKT cơ khí"),
    ListItem(11, "Kỹ thuật công nghiệp"),
    ListItem(12, "Kỹ nghệ gỗ và nội thất"),
    ListItem(13, "CNKT công trình xây dựng"),
    ListItem(14, "Kỹ thuật xây dựng công trình giao thông"),
    ListItem(15, "Quản lý xây dựng"),
    ListItem(16, "Hệ thống kỹ thuật công trình xây dựng"),
    ListItem(17, "CNKT ô tô"),
    ListItem(18, "CNKT nhiệt"),
    ListItem(19, "Năng lượng tái tạo"),
    ListItem(20, "CN thông tin"),
    ListItem(21, "Kỹ thuật dữ liệu"),
    ListItem(22, "Quản lý công nghiệp"),
    ListItem(23, "Kế toán"),
    ListItem(24, "Thương mại điện tử"),
    ListItem(25, "Logistics và quản lý chuỗi cung ứng"),
    ListItem(26, "Kinh doanh Quốc tế"),
    ListItem(27, "Công nghệ may"),
    ListItem(28, "CN Kỹ thuật in"),
    ListItem(29, "Thiết kế đồ họa"),
    ListItem(30, "Kiến trúc"),
    ListItem(31, "Kiến trúc nội thất"),
    ListItem(33, "CNKT môi trường"),
    ListItem(34, "CN thực phẩm"),
    ListItem(35, "CNKT hóa học"),
    ListItem(36, "Quản trị NH và DV ăn uống"),
    ListItem(37, "Thiết kế thời trang"),
    ListItem(38, "Sư phạm tiếng Anh"),
    ListItem(39, "Ngôn ngữ Anh"),
  ];

  List<DropdownMenuItem<ListItem>> _dropdownMenuItems;
  ListItem _selectedItem;

  void initState() {
    super.initState();
    _dropdownMenuItems = buildDropDownMenuItems(_dropdownItems);
    _selectedItem = _dropdownMenuItems[0].value;
  }

  List<DropdownMenuItem<ListItem>> buildDropDownMenuItems(List listItems) {
    List<DropdownMenuItem<ListItem>> items = List();
    for (ListItem listItem in listItems) {
      items.add(
        DropdownMenuItem(
          child: Text(listItem.name),
          value: listItem,
        ),
      );
    }
    return items;
  }
}

class ListItem {
  int value;
  String name;

  ListItem(this.value, this.name);
}
