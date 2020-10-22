import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:pdftron_flutter/pdftron_flutter.dart';
import 'package:share_ute/main_screen/main_screen.dart';

class DocumentInfoView extends StatefulWidget {
  const DocumentInfoView({this.document});

  final Document document;

  @override
  _DocumentInfoViewState createState() => _DocumentInfoViewState();
}

class _DocumentInfoViewState extends State<DocumentInfoView> {
  List _items;
  String _version;

  @override
  void initState() {
    _items = ['CNTT', '3TC', '2020', 'HK2', 'DaiTra', 'Tran Cong Tu', 'CuoiKy'];
    initPlatformState();
    super.initState();
  }

  Future<void> initPlatformState() async {
    String version;
    try {
      PdftronFlutter.initialize('');
      version = await PdftronFlutter.version;
    } on PlatformException {
      version = 'Failed to get platform version.';
    }
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _version = version;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CupertinoColors.white,
      child: Stack(
        children: [
          // Chứa ảnh tài liệu
          GestureDetector(
            child: AspectRatio(
              aspectRatio: 6 / 5,
              child: Image.asset('assets/design_course/webInterFace.png'),
            ),
            onTap: () async {
              await PdftronFlutter.openDocument(widget.document.fileUrl);
            },
          ),

          // Chứa tiêu đề, ngày tạo, tags của tài liệu
          Positioned(
            top: (MediaQuery.of(context).size.width / 1.2) - 24.0,
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                  color: CupertinoColors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: const Radius.circular(20.0),
                    topRight: const Radius.circular(20.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                        color: CupertinoColors.systemGrey3,
                        offset: const Offset(1.1, 1.1),
                        blurRadius: 10.0)
                  ]),
              child: Padding(
                padding: const EdgeInsets.only(left: 5, right: 5),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 50, left: 10, right: 10),
                        child: Text(
                          widget.document.title,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 22,
                              letterSpacing: 0.27,
                              color: CupertinoColors.darkBackgroundGray),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 5, left: 10, right: 10),
                        child: Text(
                          widget.document.dateCreated,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 14,
                              letterSpacing: 0.27,
                              color: CupertinoColors.darkBackgroundGray
                                  .withOpacity(0.8)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15, right: 15, bottom: 3),
                        child: Icon(const IconData(0xf48c,
                            fontFamily: CupertinoIcons.iconFont,
                            fontPackage: CupertinoIcons.iconFontPackage)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: _tags,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).padding.bottom,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),

          //Like Icon
          Positioned(
            top: (MediaQuery.of(context).size.width / 1.2) - 24.0 - 35.0,
            right: 15,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  child: Container(
                    width: 50,
                    height: 50,
                    child: CupertinoButton(
                      child: Icon(
                        const IconData(0xf6b7,
                            fontFamily: CupertinoIcons.iconFont,
                            fontPackage: CupertinoIcons.iconFontPackage),
                      ),
                      onPressed: () {
                        print('Like');
                      },
                    ),
                  ),
                  color: CupertinoColors.extraLightBackgroundGray,
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(widget.document.like.toString())
              ],
            ),
          ),

          //Dislike Icon
          Positioned(
            top: (MediaQuery.of(context).size.width / 1.2) - 24.0 - 35.0,
            right: 80,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  child: Container(
                    width: 50,
                    height: 50,
                    child: CupertinoButton(
                      child: Icon(
                        const IconData(0xf6b5,
                            fontFamily: CupertinoIcons.iconFont,
                            fontPackage: CupertinoIcons.iconFontPackage),
                      ),
                      onPressed: () {
                        print('Dislike');
                      },
                    ),
                  ),
                  color: CupertinoColors.extraLightBackgroundGray,
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(widget.document.dislike.toString())
              ],
            ),
          ),

          //Avatar Icon
          Positioned(
            top: (MediaQuery.of(context).size.width / 1.2) - 24.0 - 35.0,
            left: 15,
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: CupertinoColors.extraLightBackgroundGray,
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(60.0)),
                child: Image.network(widget.document.userUrl),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget get _tags {
    return Tags(
      key: Key('document_tags'),
      symmetry: false,
      horizontalScroll: false,
      columns: 0,
      itemCount: widget.document.tags.length,
      itemBuilder: (index) {
        final item = widget.document.tags[index];
        return ItemTags(
          key: Key('document_tags' + index.toString()),
          index: index,
          title: item,
          pressEnabled: false,
          activeColor: CupertinoColors.systemGrey4,
          textScaleFactor:
              utf8.encode(item.substring(0, 1)).length > 2 ? 0.8 : 1,
          textStyle: TextStyle(fontSize: 14),
        );
      },
    );
  }
}
