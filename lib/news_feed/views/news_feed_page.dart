import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:share_ute/news_feed/news_feed.dart';

class NewsFeedScreen extends StatefulWidget {
  @override
  _NewsFeedScreenState createState() => _NewsFeedScreenState();
}

class _NewsFeedScreenState extends State<NewsFeedScreen>
    with TickerProviderStateMixin {
  AnimationController animationController;
  List<FileItem> hotelList = FileItem.fileItem;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: DesignCourseAppTheme.nearlyWhite,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverList(
                delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  return TagPage();
                }, childCount: 1),
              ),
            ];
          },
          body: Container(
            color: FileAppTheme.buildLightTheme().backgroundColor,
            child: ListView(
              children: <Widget>[
                ListTile(
                  title: Text(
                    'File types',
                    style: TextStyle(fontFamily: 'WorkSans'),
                  ),
                ),
                ListTile(
                  leading: Icon(
                    const IconData(0xf62d,
                        fontFamily: CupertinoIcons.iconFont,
                        fontPackage: CupertinoIcons.iconFontPackage),
                    color: Colors.red,
                  ),
                  title: Text('PDFs'),
                ),
                ListTile(
                  leading: Icon(
                    const IconData(0xf62d,
                        fontFamily: CupertinoIcons.iconFont,
                        fontPackage: CupertinoIcons.iconFontPackage),
                    color: Colors.blue,
                  ),
                  title: Text('Documents'),
                ),
                ListTile(
                  leading: Icon(
                    const IconData(0xf62d,
                        fontFamily: CupertinoIcons.iconFont,
                        fontPackage: CupertinoIcons.iconFontPackage),
                    color: Colors.green,
                  ),
                  title: Text('Spreadsheets'),
                ),
                ListTile(
                  leading: Icon(
                    const IconData(0xf62d,
                        fontFamily: CupertinoIcons.iconFont,
                        fontPackage: CupertinoIcons.iconFontPackage),
                    color: Colors.yellow,
                  ),
                  title: Text('Presentations'),
                ),
                ListTile(
                  leading: Icon(
                    const IconData(0xf434,
                        fontFamily: CupertinoIcons.iconFont,
                        fontPackage: CupertinoIcons.iconFontPackage),
                  ),
                  title: Text('Folders'),
                ),
                ListTile(
                  title: Text('Date modified'),
                ),
                ListTile(
                  leading: Icon(
                    const IconData(0xf5b0,
                        fontFamily: CupertinoIcons.iconFont,
                        fontPackage: CupertinoIcons.iconFontPackage),
                  ),
                  title: Text('Today'),
                ),
                ListTile(
                  leading: Icon(
                    const IconData(0xf5b0,
                        fontFamily: CupertinoIcons.iconFont,
                        fontPackage: CupertinoIcons.iconFontPackage),
                  ),
                  title: Text('Yesterday'),
                ),
                ListTile(
                  leading: Icon(
                    const IconData(0xf5b0,
                        fontFamily: CupertinoIcons.iconFont,
                        fontPackage: CupertinoIcons.iconFontPackage),
                  ),
                  title: Text('Last 7 days'),
                ),
                ListTile(
                  leading: Icon(
                    const IconData(0xf5b0,
                        fontFamily: CupertinoIcons.iconFont,
                        fontPackage: CupertinoIcons.iconFontPackage),
                  ),
                  title: Text('Last 30 days'),
                ),
                ListTile(
                  leading: Icon(
                    const IconData(0xf5b0,
                        fontFamily: CupertinoIcons.iconFont,
                        fontPackage: CupertinoIcons.iconFontPackage),
                  ),
                  title: Text('Last 90 days'),
                ),
                ListTile(
                  title: Text('Owned by'),
                ),
                ListTile(
                  leading: Icon(
                    const IconData(0xf748,
                        fontFamily: CupertinoIcons.iconFont,
                        fontPackage: CupertinoIcons.iconFontPackage),
                    color: Colors.green,
                  ),
                  title: Text('Not owned by me'),
                ),
                ListTile(
                  leading: Icon(
                    const IconData(0xf74c,
                        fontFamily: CupertinoIcons.iconFont,
                        fontPackage: CupertinoIcons.iconFontPackage),
                    color: Colors.green,
                  ),
                  title: Text('Owned by my friends'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
