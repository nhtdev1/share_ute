import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_ute/authentication/authentication.dart';
import 'package:share_ute/firestore_user/firestore_user.dart';
import 'package:share_ute/profile_screen/profile_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Phần dành cho drawer
class DrawerWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FirestoreUserBloc, FirestoreUserState>(
      buildWhen: (previous, current) => previous.user != current.user,
      builder: (context, state) {
        return Drawer(
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    UserAccountsDrawerHeader(
                      accountName: Text(
                        state.user.name,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      accountEmail: Text(
                        state.user.email,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      currentAccountPicture: CircleAvatar(
                        radius: 30.0,
                        backgroundImage: NetworkImage(
                            state.user.photo),
                      ),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/images/cover.jpg"),
                              fit: BoxFit.cover)),
                    ),
                    ListTile(
                      title: Text('Thông tin'),
                      leading: Icon(const IconData(0xf746,
                          fontFamily: CupertinoIcons.iconFont,
                          fontPackage: CupertinoIcons.iconFontPackage)),
                      onTap: () {
                        Navigator.push(
                          context,
                          ProfilePage.route(),
                        );
                      },
                    ),
                    ListTile(
                      title: Text('Cài đặt'),
                      leading: Icon(const IconData(0xf43c,
                          fontFamily: CupertinoIcons.iconFont,
                          fontPackage: CupertinoIcons.iconFontPackage)),
                      onTap: () {},
                    ),
                    ListTile(
                      title: Text('Phản hồi'),
                      leading: Icon(const IconData(0xf78f,
                          fontFamily: CupertinoIcons.iconFont,
                          fontPackage: CupertinoIcons.iconFontPackage)),
                      onTap: () {},
                    ),
                    ListTile(
                      title: Text('Về chúng tôi'),
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
                            'Đăng xuất',
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
                            context
                                .read<AuthenticationBloc>()
                                .add(AuthenticationLogoutRequested());
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
      },
    );
  }
}
