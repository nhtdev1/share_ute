import 'package:flutter/material.dart';
import 'package:share_ute/theme.dart';

// HomeView nới chứa drawer và màn hình chính
class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // Màn hình chính
  Widget mainView;

  DrawerItems drawerItems;

  @override
  void initState() {
    drawerItems = DrawerItems.HOME;
    mainView = Container(child: Text('Màn hình chính'),);
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
        ),
      ),
    );
  }
}

enum DrawerItems { HOME, RATE, ABOUT, SETTINGS }
