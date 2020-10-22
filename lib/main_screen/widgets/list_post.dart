import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_ute/document_info_screen/document_info_screen.dart';
import 'package:share_ute/main_screen/main_screen.dart';

class ListPost extends StatefulWidget {
  @override
  _ListPostState createState() => _ListPostState();
}

class _ListPostState extends State<ListPost> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: Document.randomList.length,
        itemBuilder: (context, index) => Card(
              color: CupertinoColors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Icon, Label, Optional Menu
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              color: CupertinoColors.white,
                              height: 40,
                              width: 40,
                              child: Icon(const IconData(0xf62d,
                                  fontFamily: CupertinoIcons.iconFont,
                                  fontPackage: CupertinoIcons.iconFontPackage)),
                            ),
                            const SizedBox(
                              width: 10.0,
                            ),
                            Text(
                              Document.randomList[index].title,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: CupertinoColors.label),
                            )
                          ],
                        ),
                        CupertinoButton(
                          child: Icon(
                            const IconData(63706,
                                fontFamily: CupertinoIcons.iconFont,
                                fontPackage: CupertinoIcons.iconFontPackage),
                            color: CupertinoColors.systemGrey,
                          ),
                          onPressed: () async {
                            await showCupertinoModalPopup(
                                context: context,
                                builder: (context) => CupertinoActionSheet(
                                      title: Text(
                                        Document.randomList[index].title,
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      actions: [
                                        CupertinoActionSheetAction(
                                          child: Row(
                                            children: [
                                              Icon(const IconData(0xf63b,
                                                  fontFamily:
                                                      CupertinoIcons.iconFont,
                                                  fontPackage: CupertinoIcons
                                                      .iconFontPackage)),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              Text(
                                                'Open with',
                                                style: TextStyle(fontSize: 16),
                                              )
                                            ],
                                          ),
                                          onPressed: () {},
                                        ),
                                        CupertinoActionSheetAction(
                                          child: Row(
                                            children: [
                                              Icon(const IconData(62516,
                                                  fontFamily:
                                                      CupertinoIcons.iconFont,
                                                  fontPackage: CupertinoIcons
                                                      .iconFontPackage)),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              Text(
                                                'Add to Local',
                                                style: TextStyle(fontSize: 16),
                                              )
                                            ],
                                          ),
                                          onPressed: () {},
                                        ),
                                        CupertinoActionSheetAction(
                                          child: Row(
                                            children: [
                                              Icon(const IconData(0xf8c4,
                                                  fontFamily:
                                                      CupertinoIcons.iconFont,
                                                  fontPackage: CupertinoIcons
                                                      .iconFontPackage)),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              Text(
                                                'Download',
                                                style: TextStyle(fontSize: 16),
                                              )
                                            ],
                                          ),
                                          onPressed: () {},
                                        )
                                      ],
                                    ));
                          },
                        )
                      ],
                    ),
                  ),
                  //
                  // Fileholder

                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                    child: GestureDetector(
                      child: Container(
                        decoration: BoxDecoration(
                            color: CupertinoColors.quaternaryLabel,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10.0))),
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10.0)),
                          child: AspectRatio(
                            aspectRatio: 2.5,
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DocumentInfoPage(
                                    document: Document.randomList[index],
                                  )),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 5, bottom: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(Document.randomList[index].dateCreated),
                        Row(
                          children: [
                            Icon(
                              const IconData(
                                0xf4fb,
                                fontFamily: CupertinoIcons.iconFont,
                                fontPackage: CupertinoIcons.iconFontPackage,
                              ),
                              color: CupertinoColors.systemGrey,
                              size: 14,
                            ),
                            const SizedBox(
                              width: 3,
                            ),
                            Text(
                              Random().nextInt(500).toString(),
                              style: TextStyle(fontSize: 14),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ));
  }
}
