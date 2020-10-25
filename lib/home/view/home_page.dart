import 'dart:ui';

import 'package:badges/badges.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_ute/drawer/drawer.dart';
import 'package:share_ute/main_screen/main_screen.dart';
import 'package:share_ute/search_screen/search_screen.dart';
import 'package:share_ute/theme.dart';
import 'package:share_ute/upload_screen/upload_screen.dart';
import 'package:share_ute/views/folder_page.dart';
import 'package:share_ute/views/recent_page.dart';

class HomePage extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => HomePage());
  }

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  GlobalKey<ConvexAppBarState> _bottomNavigationKey =
      GlobalKey<ConvexAppBarState>();

  ScrollController _scrollController;
  PageController _pageController;

  @override
  void initState() {
    _pageController = PageController();
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.nearlyWhite,
      child: SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          backgroundColor: AppTheme.nearlyWhite,
          body: NestedScrollView(
            controller: _scrollController,
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return <Widget>[
                // SliverAppBar custom SearchBar
                SliverAppBar(
                  iconTheme:
                      new IconThemeData(color: CupertinoColors.systemGrey),
                  toolbarHeight: 80,
                  pinned: innerBoxIsScrolled == true ? false : true,
                  floating: true,
                  backgroundColor: CupertinoColors.white,
                  title: Container(
                    child: Material(
                      elevation: 8,
                      borderRadius: BorderRadius.all(Radius.circular(7.0)),
                      child: Container(
                        height: 45,
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: InkWell(
                                child: TextFormField(
                                  enabled: false,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 16, fontFamily: 'WorkSans'),
                                  decoration: InputDecoration(
                                    hintText: "Search for Documents",
                                    border: InputBorder.none,
                                  ),
                                ),
                                onTap: () async {
                                  await showSearch(
                                      context: context, delegate: SearchPage());
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ];
            },
            body: Container(
              child: PageView(
                controller: _pageController,
                children: [
                  ListPost(),
                  RecentPage(),
                  UploadPage(),
                  MyFolderPage(),
                ],
                onPageChanged: (index) {
                  _bottomNavigationKey.currentState.animateTo(index);
                },
              ),
            ),
          ),
          bottomNavigationBar: ConvexAppBar(
            height: 60,
            key: _bottomNavigationKey,
            backgroundColor: AppTheme.notWhite,
            items: [
              TabItem(
                  icon: Badge(
                      animationDuration: Duration(milliseconds: 1000),
                      animationType: BadgeAnimationType.fade,
                      toAnimate: true,
                      badgeContent: Text('5'),
                      child: Icon(const IconData(63715,
                          fontFamily: CupertinoIcons.iconFont,
                          fontPackage: CupertinoIcons.iconFontPackage)))),
              TabItem(
                  icon: Icon(const IconData(0xf4be,
                      fontFamily: CupertinoIcons.iconFont,
                      fontPackage: CupertinoIcons.iconFontPackage))),
              TabItem(
                  icon: Icon(const IconData(0xf8c6,
                      fontFamily: CupertinoIcons.iconFont,
                      fontPackage: CupertinoIcons.iconFontPackage))),
              TabItem(
                  icon: Icon(const IconData(0xf677,
                      fontFamily: CupertinoIcons.iconFont,
                      fontPackage: CupertinoIcons.iconFontPackage))),
            ],
            onTap: (index) {
              _pageController.jumpToPage(index);
            },
          ),
          drawer: DrawerWidget(),
        ),
      ),
    );
  }
}
