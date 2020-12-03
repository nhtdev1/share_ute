import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_ute/document_info/document_info.dart';
import 'package:share_ute/document_solution/document_solution.dart';

class DocumentForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: CupertinoColors.white,
            leading: CupertinoButton(
              child: Icon(
                const IconData(0xf4fd,
                    fontFamily: CupertinoIcons.iconFont,
                    fontPackage: CupertinoIcons.iconFontPackage),
                color: CupertinoColors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            bottom: TabBar(
              indicatorColor: CupertinoColors.activeBlue,
              tabs: [
                Tab(
                  icon: Icon(
                    const IconData(0xf62d,
                        fontFamily: CupertinoIcons.iconFont,
                        fontPackage: CupertinoIcons.iconFontPackage),
                    color: CupertinoColors.darkBackgroundGray,
                  ),
                ),
                Tab(
                  icon: Icon(
                    const IconData(0xf6dd,
                        fontFamily: CupertinoIcons.iconFont,
                        fontPackage: CupertinoIcons.iconFontPackage),
                    color: CupertinoColors.darkBackgroundGray,
                  ),
                ),
                Tab(
                  icon: Icon(
                    const IconData(0xf5a4,
                        fontFamily: CupertinoIcons.iconFont,
                        fontPackage: CupertinoIcons.iconFontPackage),
                    color: CupertinoColors.darkBackgroundGray,
                  ),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              const DocumentInfoPage(),
              DocumentSolutionPage(),
              const Center(
                child: Text('Chưa có'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
