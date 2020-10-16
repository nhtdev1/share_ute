import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_ute/home/home.dart';
import 'package:share_ute/theme.dart';

// Phần dành cho drawer
class DrawerWidget extends StatefulWidget {
  const DrawerWidget(
      {@required this.iconAnimationController, @required this.listener});

  final AnimationController iconAnimationController;

  final Function(DrawerItemIndex) listener;

  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  List<DrawerItem> drawerItems;

  @override
  void initState() {
    initDrawerItems();
    super.initState();
  }

  void initDrawerItems() {
    drawerItems = <DrawerItem>[
      DrawerItem(
          labelName: 'Home',
          icon: Icon(const IconData(0xf6ca,
              fontFamily: CupertinoIcons.iconFont,
              fontPackage: CupertinoIcons.iconFontPackage)),
          drawerItem: DrawerItemIndex.HOME),
      DrawerItem(
          labelName: 'Rate the app',
          icon: Icon(const IconData(0xf822,
              fontFamily: CupertinoIcons.iconFont,
              fontPackage: CupertinoIcons.iconFontPackage)),
          drawerItem: DrawerItemIndex.RATE),
      DrawerItem(
          labelName: 'About Us',
          icon: Icon(const IconData(0xf6cf,
              fontFamily: CupertinoIcons.iconFont,
              fontPackage: CupertinoIcons.iconFontPackage)),
          drawerItem: DrawerItemIndex.ABOUT),
      DrawerItem(
          labelName: 'Settings',
          icon: Icon(const IconData(0xf43d,
              fontFamily: CupertinoIcons.iconFont,
              fontPackage: CupertinoIcons.iconFontPackage)),
          drawerItem: DrawerItemIndex.SETTINGS),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.notWhite.withOpacity(0.5),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Vùng chứa  user avatar và name user
          Container(
            width: double.infinity,
            // Độ rộng từ viền container đến viền child của container
            padding: const EdgeInsets.only(top: 40.0),
            child: Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Avatar
                  AnimatedBuilder(
                    animation: widget.iconAnimationController,
                    builder: (_, __) {
                      // Scale Avatar
                      return ScaleTransition(
                        scale: AlwaysStoppedAnimation<double>(
                            1.0 - (widget.iconAnimationController.value * 0.2)),
                        // Rotate Avatar
                        child: RotationTransition(
                          turns: AlwaysStoppedAnimation<double>(Tween<double>(
                                      begin: 0.0, end: 24.0)
                                  .animate(CurvedAnimation(
                                      parent: widget.iconAnimationController,
                                      curve: Curves.fastOutSlowIn))
                                  .value /
                              360),
                          // Circle custome
                          child: Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey,
                                      offset: const Offset(2.0, 4.0),
                                      blurRadius: 8)
                                ]),
                            child: ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(60.0)),
                              child: Image.asset('assets/images/userImage.png'),
                            ),
                          ),
                        ),
                      );
                    },
                  ),

                  // Username
                  Padding(
                    padding: const EdgeInsets.only(top: 8, left: 4),
                    child: Text(
                      'Hoang Thinh',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: AppTheme.grey,
                          fontSize: 18),
                    ),
                  )
                ],
              ),
            ),
          ),

          const SizedBox(
            height: 4,
          ),

          Divider(
            height: 1,
            color: AppTheme.grey.withOpacity(0.5),
          ),

          // Vùng chứa icon
          Expanded(
            child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(0.0),
                itemCount: drawerItems.length,
                itemBuilder: (BuildContext context, int index) {
                  return inkWellDrawerItem(drawerItems[index]);
                }),
          ),

          Divider(
            height: 1,
            color: AppTheme.grey.withOpacity(0.5),
          ),

          // Vùng đăng xuất
          Container(
            height: 60,
            child: Column(
              children: [
                ListTile(
                  title: Text(
                    'Sign Out',
                    style: TextStyle(
                        fontFamily: AppTheme.fontName,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: AppTheme.darkText),
                    textAlign: TextAlign.left,
                  ),
                  trailing: Icon(const IconData(0xf90e,
                      fontFamily: CupertinoIcons.iconFont,
                      fontPackage: CupertinoIcons.iconFontPackage),
                  color: Colors.redAccent,),
                  onTap: () {
                    print('Sign Out here');
                  },
                )
              ],
            ),
          ),

          SizedBox(
            height: MediaQuery.of(context).padding.bottom,
          )
        ],
      ),
    );
  }

  Widget inkWellDrawerItem(DrawerItem item) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Colors.grey.withOpacity(0.1),
        highlightColor: Colors.transparent,
        onTap: () {
          navigateToScreenOf(item.drawerItem);
        },
        child: Stack(
          children: [
            // Phần Icon và Tên
            Container(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Row(
                children: [
                  Container(
                    width: 6.0,
                    height: 46.0,
                  ),
                  const Padding(
                    padding: EdgeInsets.all(4.0),
                  ),
                  Icon(
                    item.icon.icon,
                    color: Colors.grey,
                  ),
                  const Padding(padding: EdgeInsets.all(4.0)),
                  Text(
                    item.labelName,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: AppTheme.nearlyBlack),
                    textAlign: TextAlign.left,
                  )
                ],
              ),
            )

            // Phần animation
          ],
        ),
      ),
    );
  }

  Future<void> navigateToScreenOf(DrawerItemIndex index) async {
    widget.listener(index);
  }
}

class DrawerItem {
  DrawerItem({
    this.labelName,
    this.icon,
    this.drawerItem,
  });

  String labelName;
  Icon icon;
  DrawerItemIndex drawerItem;
}
