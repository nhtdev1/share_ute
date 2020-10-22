import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Phần dành cho drawer
class DrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                UserAccountsDrawerHeader(
                  accountName: Text(
                    'Hoang Thinh',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  accountEmail: Text(
                    'blv.tu97@gmail.com',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  currentAccountPicture: CircleAvatar(
                    backgroundImage:
                        ExactAssetImage('assets/images/userImage.png'),
                  ),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/cover.png"),
                          fit: BoxFit.cover)),
                ),
                ListTile(
                  title: Text('Profile'),
                  leading: Icon(const IconData(0xf746,
                      fontFamily: CupertinoIcons.iconFont,
                      fontPackage: CupertinoIcons.iconFontPackage)),
                  onTap: () {},
                ),
                ListTile(
                  title: Text('Settings'),
                  leading: Icon(const IconData(0xf43c,
                      fontFamily: CupertinoIcons.iconFont,
                      fontPackage: CupertinoIcons.iconFontPackage)),
                  onTap: () {},
                ),
                ListTile(
                  title: Text('Help & feedback'),
                  leading: Icon(const IconData(0xf78f,
                      fontFamily: CupertinoIcons.iconFont,
                      fontPackage: CupertinoIcons.iconFontPackage)),
                  onTap: () {},
                ),
                ListTile(
                  title: Text('About Us'),
                  leading: Icon(const IconData(0xf44c,
                      fontFamily: CupertinoIcons.iconFont,
                      fontPackage: CupertinoIcons.iconFontPackage)),
                  onTap: () {},
                ),
              ],
            ),
          ),
          Container(
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: Container(
                child: Column(
                  children: [
                    Divider(),
                    ListTile(
                      title: Text(
                        'Sign Out',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: CupertinoColors.label),
                        textAlign: TextAlign.left,
                      ),
                      trailing: Icon(
                        const IconData(0xf90e,
                            fontFamily: CupertinoIcons.iconFont,
                            fontPackage: CupertinoIcons.iconFontPackage),
                        color: CupertinoColors.systemRed,
                      ),
                      onTap: () {
                        print('Sign Out here');
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).padding.bottom,
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
