import 'dart:math';

import 'package:badges/badges.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:share_ute/news_feed/news_feed.dart';
import 'package:share_ute/theme.dart';

class MainPage extends StatefulWidget {
  const MainPage({this.animation, this.listener});

  final AnimationController animation;

  final Function() listener;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  GlobalKey<ConvexAppBarState> _bottomNavigationKey =
      GlobalKey<ConvexAppBarState>();
  PageController _pageController;
  ScrollController _scrollController;

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
    return Scaffold(
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
              icon: Icon(const IconData(0xf3e7,
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
      body: SafeArea(
        child: NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                toolbarHeight: 80,
                pinned: innerBoxIsScrolled == true ? false : true,
                floating: true,
                backgroundColor: Colors.white,
                title: Container(
                  child: Material(
                    elevation: 2,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    child: Container(
                      height: 45,
                      child: Row(
                        children: [
                          Container(
                            child: InkWell(
                              borderRadius: BorderRadius.circular(
                                  AppBar().preferredSize.height),
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: MediaQuery.of(context).padding.top + 5,
                                    left: 10),
                                child: AnimatedIcon(
                                  color: Colors.grey,
                                  icon: AnimatedIcons.arrow_menu,
                                  progress: widget.animation,
                                ),
                              ),
                              onTap: () {
                                widget.listener();
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: TextFormField(
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: 16, fontFamily: 'WorkSans'),
                              decoration: InputDecoration(
                                  hintText: "Search for Documents",
                                  border: InputBorder.none,
                                  suffixIcon: IconButton(
                                    icon: Icon(const IconData(0xf4a5,
                                        fontFamily: CupertinoIcons.iconFont,
                                        fontPackage:
                                            CupertinoIcons.iconFontPackage)),
                                    onPressed: () {
                                      showSearch(
                                          context: context,
                                          delegate: DataSearch());
                                    },
                                  )),
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
                InstaList(),
                Container(
                  color: Colors.lightBlueAccent,
                ),
                Container(
                  color: Colors.lightGreenAccent,
                ),
                Container(
                  color: Colors.white54,
                ),
              ],
              onPageChanged: (index) {
                _bottomNavigationKey.currentState.animateTo(index);
              },
            ),
          ),
        ),
      ),
    );
  }
}

class DataSearch extends SearchDelegate<String> {
  final cities = [
    'AAA',
    'CCC',
    'DDD',
    'EEE',
    'MMM',
    'LLL',
    'KKK',
    'OOO',
    'PPP',
    'III',
    'UUU',
    'YYY',
    'TTT',
    'RRR',
    'FFF',
  ];

  final recentCities = ['AAA', 'DDD', 'CCC', 'aaa', 'ddd', 'adc'];

  @override
  // Actions for AppBar
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  // Leading Icon on the left of AppBar
  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  // Show some results based on the selection
  @override
  Widget buildResults(BuildContext context) {
    return Text(query);
  }

  // Show when someone searches for something
  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? recentCities
        : cities.where((p) => p.startsWith(query)).toList();
    return NewsFeedScreen();
  }
}

class InstaList extends StatefulWidget {
  @override
  _InstaListState createState() => _InstaListState();
}

class _InstaListState extends State<InstaList> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) => Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Divider(
              height: 1,
              color: Colors.grey.withOpacity(0.5),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        height: 40.0,
                        width: 40.0,
                        child: Icon(const IconData(0xf62d,
                            fontFamily: CupertinoIcons.iconFont,
                            fontPackage: CupertinoIcons.iconFontPackage)),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Text(
                        "TLCN",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black.withOpacity(0.8)),
                      )
                    ],
                  ),
                  IconButton(
                    icon: Icon(const IconData(63706,
                        fontFamily: CupertinoIcons.iconFont,
                        fontPackage: CupertinoIcons.iconFontPackage)),
                    onPressed: () async {
                      await showCupertinoModalPopup(
                          context: context,
                          builder: (context) => CupertinoActionSheet(
                                title: Text('TLCN',
                                    style: TextStyle(fontSize: 16)),
                                actions: [
                                  CupertinoActionSheetAction(
                                    child: Row(
                                      children: [
                                        Icon(const IconData(0xf63b,
                                            fontFamily: CupertinoIcons.iconFont,
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
                                    onPressed: () => {},
                                  ),
                                  CupertinoActionSheetAction(
                                    child: Row(
                                      children: [
                                        Icon(const IconData(62516,
                                            fontFamily: CupertinoIcons.iconFont,
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
                                    onPressed: () => {},
                                  ),
                                  CupertinoActionSheetAction(
                                    child: Row(
                                      children: [
                                        Icon(const IconData(63684,
                                            fontFamily: CupertinoIcons.iconFont,
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
                                    onPressed: () => {},
                                  ),
                                ],
                              ));
                    },
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.1),
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  child: AspectRatio(
                    aspectRatio: 2.5,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('2 hours ago'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(const IconData(63157,
                            fontFamily: CupertinoIcons.iconFont,
                            fontPackage: CupertinoIcons.iconFontPackage)),
                        color: Colors.grey.withOpacity(0.7),
                        onPressed: null,
                      ),
                      IconButton(
                        icon: new Icon(const IconData(63159,
                            fontFamily: CupertinoIcons.iconFont,
                            fontPackage: CupertinoIcons.iconFontPackage)),
                        color: isPressed
                            ? Colors.lightBlueAccent
                            :  Colors.grey.withOpacity(0.7),
                        onPressed: () {
                          setState(() {
                            isPressed = !isPressed;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Divider(
              height: 1,
              color: Colors.grey.withOpacity(0.5),
            ),
          ],
        ),
      ),
    );
  }
}
