import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_ute/views/home_screen.dart';

class HomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'SHAREute',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity:VisualDensity.adaptivePlatformDensity
      ),
      home: MyHomePage(title: 'SHAREute',),
    );
  }

}

class MyHomePage extends StatefulWidget{

  final String title;

  MyHomePage({Key key, this.title}): super(key:key);

  @override
  _MyHomePageState createState() => _MyHomePageState();

}

// Tickers can be used by any object that wants to be notified whenever a frame triggers.
// AnimationControllers need a TickerProvider to obtain their Ticker.
// If you are creating an AnimationController from a State,
// then you can use the TickerProviderStateMixin and SingleTickerProviderStateMixin classes to obtain a suitable TickerProvider.
class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin{

  //TabController _tabController;

  //ScrollController _scrollViewController;

  int _currentItem = 0;

  PageController _pageViewController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // take a vsync tag if you this tabController to be synced to the frame of the screen
    // take a length to specify the amount of tabs that were going to have in this tabController
   // _tabController = TabController(vsync: this, length: 4);
    //_scrollViewController = ScrollController();

    _pageViewController = PageController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // when a new state object comes into scope it will instantiate a new set of controllers us
    //_tabController.dispose();
    //_scrollViewController.dispose();
    _pageViewController.dispose();
    super.dispose();
  }

  // Version 1
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: SafeArea(
  //       // A NestedScrollView which allow us to have a few different scroll inside of this scroll view
  //       child: NestedScrollView(
  //         controller: _scrollViewController,
  //         //boxIsScrolled which basically asks the question of whether or not
  //         // we have scrolled up or down
  //         headerSliverBuilder: (context,boxIsScrolled){
  //           return <Widget>[
  //             SliverAppBar(
  //               // Custom title as a search bar
  //               title: Container(
  //                 // Material widget is a piece of material.
  //                 // Material clips its widget sub-tree to the shape specified
  //                 // Material elevates its widget sub-tree on the Z axis by elevation pixels
  //                 // Ink effects
  //                 child: Material(
  //                   elevation: 2,
  //                   borderRadius: BorderRadius.all(Radius.circular(10.0)),
  //                   child: Container(
  //                     child: TextFormField(
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //               pinned: true,
  //               floating: true,
  //               forceElevated: boxIsScrolled,
  //               bottom: TabBar(
  //                 controller: _tabController,
  //                 tabs: <Widget>[
  //                   Tab(
  //                     text: 'Home',
  //                     icon: Icon(Icons.home),
  //                   ),
  //                   Tab(
  //                     text: 'History',
  //                     icon: Icon(Icons.history),
  //                   ),
  //                   Tab(
  //                     text: 'Group',
  //                     icon: Icon(Icons.group),
  //                   ),
  //                   Tab(
  //                     text: 'Files',
  //                     icon: Icon(Icons.folder),
  //                   )
  //                 ],
  //               ),
  //             )
  //           ];
  //         },
  //         body: TabBarView(
  //           controller: _tabController,
  //           children: [
  //             Container(),
  //             Container(),
  //             Container(),
  //             Container()
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }


  // Version 2
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          // Material widget is a piece of material.
          // Material clips its widget sub-tree to the shape specified
          // Material elevates its widget sub-tree on the Z axis by elevation pixels
          // Ink effects
          child: Material(
            elevation: 2,
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            child: Container(
              height: 50,
              child: TextFormField(
                decoration: InputDecoration(
                  hintText:'Search assets',
                  border:InputBorder.none,
                  icon: Container(
                    margin: EdgeInsets.only(left: 10.0),
                    child: Icon(Icons.dehaze),
                  ),
                  suffixIcon: Container(
                    height: 5,
                    width: 5,
                    margin: EdgeInsets.all(5),
                    child: CircleAvatar(
                      radius: 14,
                      backgroundColor: Colors.green,
                    ),
                  )
                ),
              ),
            ),
          ),
        ),
      ),
      body: PageView(
        controller: _pageViewController,
        children: [
          Container(
            child: Text(
              '1',
            ),
          color: Colors.red,),
          Container(
            child: Text(
            '2',
          ),
            color: Colors.yellowAccent,),
          Container(
            child: Text(
            '3',
          ),
            color: Colors.blue,),
          Container(
            child: Text(
            '4',
          ),
            color: Colors.green,),
        ],
        onPageChanged: (index){
          setState(() {
            _currentItem = index;
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        // The length of items must be at least two and each item's icon and title must not be null.
        // If type is null then BottomNavigationBarType.fixed is used when there are two or three items,
        // BottomNavigationBarType.shifting otherwise.
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home')
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.history),
              title: Text('History')
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.group),
              title: Text('Group')
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.folder),
              title: Text('Files')
          )
        ],
        currentIndex: _currentItem,
        onTap: (index){
          setState(() {
            _currentItem = index;
            _pageViewController.animateToPage(_currentItem,duration: Duration(milliseconds: 200),curve: Curves.linear);
          });
        },
      ),
    );
  }
}