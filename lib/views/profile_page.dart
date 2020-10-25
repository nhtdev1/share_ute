import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:share_ute/views/edit_profile_page.dart';
import 'package:share_ute/utils/responsive.dart';

class MyProfile extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            Responsive().init(constraints, orientation);
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'UTEShare',
              home: ProfilePage(),
            );
          },
        );
      },
    );
  }
}

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: CupertinoColors.white,
            leading: CupertinoButton(
              child: Icon(
                const IconData(0xf4fd,
                    fontFamily: CupertinoIcons.iconFont,
                    fontPackage: CupertinoIcons.iconFontPackage),
                color: CupertinoColors.systemGrey,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          backgroundColor: CupertinoColors.white,
          body: Stack(
            overflow: Overflow.visible,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xff2980B9), Color(0xff6DD5FA)]),
                ),
                height: 40 * Responsive.heightMultiplier,
                child: Padding(
                  padding: EdgeInsets.only(
                      left: 30.0,
                      right: 30.0,
                      top: 10 * Responsive.heightMultiplier),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            height: 11 * Responsive.heightMultiplier,
                            width: 11 * Responsive.heightMultiplier, //22 * Responsive.widthMultiplier,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage("assets/images/HCMUTE.png"))),
                          ),
                          SizedBox(
                            width: 5 * Responsive.widthMultiplier,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Hoang Thinh",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 3 * Responsive.textMultiplier,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 1 * Responsive.heightMultiplier,
                              ),
                              Row(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Image.asset(
                                        "assets/icons/facebook.png",
                                        height: 3 * Responsive.heightMultiplier,
                                        width: 3 * Responsive.widthMultiplier,
                                      ),
                                      SizedBox(
                                        width: 2 * Responsive.widthMultiplier,
                                      ),
                                      Text(
                                        "Facebook",
                                        style: TextStyle(
                                          color: Colors.white60,
                                          fontSize: 1.5 * Responsive.textMultiplier,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 7 * Responsive.widthMultiplier,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Image.asset(
                                        "assets/icons/instagram.png",
                                        height: 3 * Responsive.heightMultiplier,
                                        width: 3 * Responsive.widthMultiplier,
                                      ),
                                      SizedBox(
                                        width: 2 * Responsive.widthMultiplier,
                                      ),
                                      Text(
                                        "Instagram",
                                        style: TextStyle(
                                          color: Colors.white60,
                                          fontSize: 1.5 * Responsive.textMultiplier,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 3 * Responsive.heightMultiplier,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Text(
                                "10.2K",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 3 * Responsive.textMultiplier,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Stars",
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 1.7 * Responsive.textMultiplier,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Text(
                                "696",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 3 * Responsive.textMultiplier,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Posts",
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 1.7 * Responsive.textMultiplier,
                                ),
                              ),
                            ],
                          ),
                          Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => EditProfilePage()));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "EDIT PROFILE",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 1.8 * Responsive.textMultiplier),
                                  ),
                                ),
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 35 * Responsive.heightMultiplier),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30.0),
                        topLeft: Radius.circular(30.0),
                      )),
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.only(
                                top: 3 * Responsive.heightMultiplier),
                            child: Center(
                              child: Text(
                                "All Posts",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 2.2 * Responsive.textMultiplier),
                              ),
                            )),
                        SizedBox(
                          height: 2 * Responsive.heightMultiplier,
                        ),
                        Container(
                          height: 58 * Responsive.heightMultiplier,
                          child: ListView(
                            scrollDirection: Axis.vertical,
                            children: <Widget>[
                              /// Đặt post tại đây
                              MyPost(),
                              MyPost(),
                              MyPost(),
                              MyPost(),
                              MyPost(),
                              MyPost(),
                              MyPost(),
                              MyPost(),
                              MyPost(),
                              MyPost(),
                              MyPost(),
                              MyPost(),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 2 * Responsive.heightMultiplier,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MyPost extends StatelessWidget {
  final String fileType;
  final String fileName;
  final String fileImage;
  DateTime dateCreated;
  MyPost({this.fileType, this.fileName, this.fileImage, this.dateCreated});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 100,
        decoration: BoxDecoration(
        )
      ),
    );
  }
}