import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_ute/main_screen/main_screen.dart';

class ListPost extends StatefulWidget {
  @override
  _ListPostState createState() => _ListPostState();
}

class _ListPostState extends State<ListPost> {
  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: ListView.builder(
        itemCount: Document.randomList.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 1.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.max,
              children: [
                // Icon, Label, Optional Menu
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(right: 10.0),
                        color: CupertinoColors.white,
                        child: Icon(
                          const IconData(
                            0xf62d,
                            fontFamily: CupertinoIcons.iconFont,
                            fontPackage: CupertinoIcons.iconFontPackage,
                          ),
                        ),
                      ),
                      Text(
                        Document.randomList[index].title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: CupertinoColors.label,
                        ),
                      ),
                      Spacer(),
                      CupertinoButton(
                        child: Icon(
                          const IconData(
                            63706,
                            fontFamily: CupertinoIcons.iconFont,
                            fontPackage: CupertinoIcons.iconFontPackage,
                          ),
                          color: CupertinoColors.label,
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
                                          fontFamily: CupertinoIcons.iconFont,
                                          fontPackage:
                                              CupertinoIcons.iconFontPackage)),
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
                                          fontFamily: CupertinoIcons.iconFont,
                                          fontPackage:
                                              CupertinoIcons.iconFontPackage)),
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
                                          fontFamily: CupertinoIcons.iconFont,
                                          fontPackage:
                                              CupertinoIcons.iconFontPackage)),
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
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),

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

                    },
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 8, bottom: 8),
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
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
