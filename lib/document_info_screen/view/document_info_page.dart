import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_ute/document_info_screen/view/view.dart';
import 'package:share_ute/main_screen/main_screen.dart';

class DocumentInfoPage extends StatelessWidget {
  const DocumentInfoPage({this.document});

  final Document document;

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => DocumentInfoPage());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
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
                Navigator.pop(context,false);
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
              ],
            ),
          ),
          body: TabBarView(
            children: [
              DocumentInfoView(
                document: document,
              ),
              DistributionView()
            ],
          ),
        ),
      ),
    );
  }
}
