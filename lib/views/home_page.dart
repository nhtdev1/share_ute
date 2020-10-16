// import 'package:flutter/material.dart';
//
// class HomePage extends StatelessWidget {
//   const HomePage();
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return MaterialApp(
//       title: 'SHAREute',
//       theme: ThemeData(
//           primarySwatch: Colors.blue,
//           visualDensity: VisualDensity.adaptivePlatformDensity),
//       home: MyHomePage(
//         title: 'SHAREute',
//       ),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   final String title;
//
//   MyHomePage({Key key, this.title}) : super(key: key);
//
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// // Tickers can be used by any object that wants to be notified whenever a frame triggers.
// // AnimationControllers need a TickerProvider to obtain their Ticker.
// // If you are creating an AnimationController from a State,
// // then you can use the TickerProviderStateMixin and SingleTickerProviderStateMixin classes to obtain a suitable TickerProvider.
// class _MyHomePageState extends State<MyHomePage>
//     with SingleTickerProviderStateMixin {
//   //TabController _tabController;
//
//   //ScrollController _scrollViewController;
//
//   int _page = 0;
//   GlobalKey _bottomNavigationKey = GlobalKey();
//
//   PageController _pageViewController;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     // take a vsync tag if you this tabController to be synced to the frame of the screen
//     // take a length to specify the amount of tabs that were going to have in this tabController
//     // _tabController = TabController(vsync: this, length: 4);
//     //_scrollViewController = ScrollController();
//
//     _pageViewController = PageController();
//   }
//
//   @override
//   void dispose() {
//     // TODO: implement dispose
//     // when a new state object comes into scope it will instantiate a new set of controllers us
//     //_tabController.dispose();
//     //_scrollViewController.dispose();
//     _pageViewController.dispose();
//     super.dispose();
//   }
//
//   // Version 1
//   // @override
//   // Widget build(BuildContext context) {
//   //   return Scaffold(
//   //     body: SafeArea(
//   //       // A NestedScrollView which allow us to have a few different scroll inside of this scroll view
//   //       child: NestedScrollView(
//   //         controller: _scrollViewController,
//   //         //boxIsScrolled which basically asks the question of whether or not
//   //         // we have scrolled up or down
//   //         headerSliverBuilder: (context,boxIsScrolled){
//   //           return <Widget>[
//   //             SliverAppBar(
//   //               // Custom title as a search bar
//   //               title: Container(
//   //                 // Material widget is a piece of material.
//   //                 // Material clips its widget sub-tree to the shape specified
//   //                 // Material elevates its widget sub-tree on the Z axis by elevation pixels
//   //                 // Ink effects
//   //                 child: Material(
//   //                   elevation: 2,
//   //                   borderRadius: BorderRadius.all(Radius.circular(10.0)),
//   //                   child: Container(
//   //                     child: TextFormField(
//   //                     ),
//   //                   ),
//   //                 ),
//   //               ),
//   //               pinned: true,
//   //               floating: true,
//   //               forceElevated: boxIsScrolled,
//   //               bottom: TabBar(
//   //                 controller: _tabController,
//   //                 tabs: <Widget>[
//   //                   Tab(
//   //                     text: 'Home',
//   //                     icon: Icon(Icons.home),
//   //                   ),
//   //                   Tab(
//   //                     text: 'History',
//   //                     icon: Icon(Icons.history),
//   //                   ),
//   //                   Tab(
//   //                     text: 'Group',
//   //                     icon: Icon(Icons.group),
//   //                   ),
//   //                   Tab(
//   //                     text: 'Files',
//   //                     icon: Icon(Icons.folder),
//   //                   )
//   //                 ],
//   //               ),
//   //             )
//   //           ];
//   //         },
//   //         body: TabBarView(
//   //           controller: _tabController,
//   //           children: [
//   //             Container(),
//   //             Container(),
//   //             Container(),
//   //             Container()
//   //           ],
//   //         ),
//   //       ),
//   //     ),
//   //   );
//   // }
//
//   // Version 2
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Container(
//           // Material widget is a piece of material.
//           // Material clips its widget sub-tree to the shape specified
//           // Material elevates its widget sub-tree on the Z axis by elevation pixels
//           // Ink effects
//           child: Material(
//             elevation: 2,
//             borderRadius: BorderRadius.all(Radius.circular(10.0)),
//             child: Container(
//               height: 50,
//               child: TextFormField(
//                 decoration: InputDecoration(
//                     hintText: 'Search assets',
//                     border: InputBorder.none,
//                     icon: Container(
//                       margin: EdgeInsets.only(left: 10.0),
//                       child: Icon(Icons.dehaze),
//                     ),
//                     suffixIcon: Container(
//                       height: 5,
//                       width: 5,
//                       margin: EdgeInsets.all(5),
//                       child: CircleAvatar(
//                         radius: 14,
//                         backgroundColor: Colors.green,
//                       ),
//                     )),
//               ),
//             ),
//           ),
//         ),
//       ),
//       bottomNavigationBar: CurvedNavigationBar(
//         key: _bottomNavigationKey,
//         backgroundColor: Colors.grey,
//         items: [
//           Icon(CupertinoIcons.home),
//           Icon(CupertinoIcons.eye),
//           Icon(CupertinoIcons.group),
//           Icon(CupertinoIcons.folder),
//         ],
//         onTap: (index) {
//           setState(() {
//             _page = index;
//             _pageViewController.animateToPage(_page,
//                 duration: Duration(milliseconds: 200), curve: Curves.linear);
//           });
//         },
//       ),
//       body: PageView(
//         controller: _pageViewController,
//         children: [
//           Container(
//             child: Text(
//               '1',
//             ),
//             color: Colors.red,
//           ),
//           Container(
//             child: Text(
//               '2',
//             ),
//             color: Colors.yellowAccent,
//           ),
//           Container(
//             child: Text(
//               '3',
//             ),
//             color: Colors.blue,
//           ),
//           Container(
//             child: Text(
//               '4',
//             ),
//             color: Colors.green,
//           ),
//         ],
//         onPageChanged: (index) {
//           setState(() {
//             _page = index;
//             final CurvedNavigationBarState navBarState =
//                 _bottomNavigationKey.currentState;
//             navBarState.setPage(_page);
//           });
//         },
//       ),
//     );
//   }
// }
