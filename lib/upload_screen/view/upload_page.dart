import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_ute/add_tags_screen/add_tags_screen.dart';

class UploadPage extends StatefulWidget {
  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  bool _post = false;
  final _textEditingController = TextEditingController();

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: ListView(
          children: [
            Divider(
              height: 1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 10,
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            const IconData(0xf401,
                                fontFamily: CupertinoIcons.iconFont,
                                fontPackage: CupertinoIcons.iconFontPackage),
                            size: 14,
                          ),
                          const SizedBox(
                            width: 2,
                          ),
                          Text(
                            'Public',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 2,
                          ),
                          Icon(
                            const IconData(0xf5d5,
                                fontFamily: CupertinoIcons.iconFont,
                                fontPackage: CupertinoIcons.iconFontPackage),
                            size: 14,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Spacer(),
                CupertinoButton(
                  child: Text(
                    'Đăng',
                    style: TextStyle(
                      color: _post
                          ? CupertinoColors.activeBlue
                          : CupertinoColors.systemGrey3,
                    ),
                  ),
                  onPressed: () {},
                )
              ],
            ),
            TextFormField(
              style: TextStyle(fontSize: 20, color: CupertinoColors.label),
              keyboardType: TextInputType.multiline,
              controller: _textEditingController,
              maxLines: 10,
              minLines: 10,
              decoration: InputDecoration(
                hintText: 'Mô tả về tài liệu của bạn',
                fillColor: CupertinoColors.white,
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: CupertinoColors.white)),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: CupertinoColors.white)),
              ),
              onChanged: (value) {
                if (value.trim() == '') {
                  setState(() {
                    _post = false;
                  });
                } else {
                  setState(() {
                    _post = true;
                  });
                }
              },
            ),
            Divider(
              height: 1,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: GestureDetector(
                child: Row(
                  children: [
                    Icon(const IconData(0xf528,
                        fontFamily: CupertinoIcons.iconFont,
                        fontPackage: CupertinoIcons.iconFontPackage)),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Chọn tài liệu',
                      style:
                          TextStyle(fontSize: 16, color: CupertinoColors.label),
                    ),
                  ],
                ),
                onTap: () {},
              ),
            ),
            Divider(
              height: 1,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: GestureDetector(
                child: Row(
                  children: [
                    Icon(const IconData(0xf48c,
                        fontFamily: CupertinoIcons.iconFont,
                        fontPackage: CupertinoIcons.iconFontPackage)),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Thêm nhãn',
                      style:
                          TextStyle(fontSize: 16, color: CupertinoColors.label),
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TagsPage(),
                      ));
                },
              ),
            ),
            Divider(
              height: 1,
            ),
          ],
        ),
      ),
    );
  }
}
