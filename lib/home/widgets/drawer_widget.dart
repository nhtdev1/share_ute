import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_ute/authentication/authentication.dart';
import 'package:share_ute/firestore_user/firestore_user.dart';
import 'package:share_ute/profile_screen/profile_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_ute/upgrade/upgrade.dart';

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
                        state.user.email == null ? 'unknown' : state.user.email,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      currentAccountPicture: CircleAvatar(
                        radius: 30.0,
                        backgroundImage: NetworkImage(state.user.photo),
                      ),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/images/cover.jpg"),
                              fit: BoxFit.cover)),
                    ),
                    ListTile(
                      title: Text('Thông tin'),
                      leading: Icon(
                        const IconData(
                          0xf746,
                          fontFamily: CupertinoIcons.iconFont,
                          fontPackage: CupertinoIcons.iconFontPackage,
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          ProfilePage.route(),
                        );
                      },
                    ),
                    ListTile(
                      title: Text('Cài đặt'),
                      leading: Icon(
                        const IconData(
                          0xf43c,
                          fontFamily: CupertinoIcons.iconFont,
                          fontPackage: CupertinoIcons.iconFontPackage,
                        ),
                      ),
                      onTap: () {},
                    ),
                    ListTile(
                      title: Text('Về ứng dụng'),
                      leading: Icon(
                        const IconData(
                          0xf44c,
                          fontFamily: CupertinoIcons.iconFont,
                          fontPackage: CupertinoIcons.iconFontPackage,
                        ),
                      ),
                      onTap: () {
                        showAboutDialog(
                          context: context,
                          applicationVersion: 'Phiên bản 0.1',
                          applicationIcon: Container(
                            width: 70,
                            height: 70,
                            child: Image.asset('assets/images/logo_utes.png'),
                          ),
                          children: [
                            Text('Tiểu luận chuyên ngành 2020'),
                            const SizedBox(height: 10),
                            Text('Sinh viên thực hiện:'),
                            ListTile(
                              leading: Icon(Icons.person),
                              title: Text('Nguyễn Hoàng Thịnh  17110372'),
                            ),
                            ListTile(
                              leading: Icon(Icons.person),
                              title: Text('Lưu Văn Quận  17110355:'),
                            ),
                            const SizedBox(height: 10),
                            Text('Giảng viên hướng dẫn:'),
                            ListTile(
                              leading: Icon(Icons.integration_instructions),
                              title: Text('TS. Nguyễn Thiên Bảo'),
                            )
                          ],
                        );
                      },
                    ),
                    ListTile(
                      title: Text('Nâng cấp'),
                      leading: Icon(
                        const IconData(
                          0xf526,
                          fontFamily: CupertinoIcons.iconFont,
                          fontPackage: CupertinoIcons.iconFontPackage,
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          UpgradePage.route(),
                        );
                      },
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
