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
    return Container(
      color: CupertinoColors.white,
      child: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: ListView(
            children: [
              Divider(
                height: 1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(shape: BoxShape.circle),
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(60.0)),
                        child: Container(
                          color: CupertinoColors.systemGrey3,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    'Thịnh',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
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
                      'POST',
                      style: TextStyle(
                          color: _post
                              ? CupertinoColors.activeBlue
                              : CupertinoColors.systemGrey3),
                    ),
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
                  hintText: 'Write your document here',
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
                        'File',
                        style: TextStyle(
                            fontSize: 16, color: CupertinoColors.label),
                      ),
                    ],
                  ),
                  onTap: () {
                    print('add file');
                  },
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
                        'Add tags',
                        style: TextStyle(
                            fontSize: 16, color: CupertinoColors.label),
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
          )),
    );
  }
}
