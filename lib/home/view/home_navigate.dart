import 'package:flutter/material.dart';
import 'package:share_ute/drawer/drawer.dart';
import 'package:share_ute/main_screen/main_screen.dart';
import 'package:share_ute/theme.dart';

// HomeNavigate nới điều hướng tới các màn hình chứa trong drawer và màn hình chính
class HomeNavigate extends StatefulWidget {
  @override
  _HomeNavigateState createState() => _HomeNavigateState();
}

class _HomeNavigateState extends State<HomeNavigate> {
  // Lưu giữ trạng thái màn hình chính
  Widget homeScreen;

  DrawerItemIndex drawerItemIndex;

  @override
  void initState() {
    drawerItemIndex = DrawerItemIndex.HOME;
    homeScreen = const MainPage();
    super.initState();
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
          body: DrawerPage(
            drawerWidth: MediaQuery.of(context).size.width * (3 / 4),
            homeScreen: homeScreen,
            listener: (DrawerItemIndex index) {
              navigateToScreenOf(index);
            },
          ),
        ),
      ),
    );
  }

  void navigateToScreenOf(DrawerItemIndex index) {
    if (drawerItemIndex != index) {
      drawerItemIndex = index;
      if (drawerItemIndex == DrawerItemIndex.HOME) {
        setState(() {
          homeScreen = const MainPage();
        });
      }
    }
  }

}

enum DrawerItemIndex { HOME, RATE, ABOUT, SETTINGS }
