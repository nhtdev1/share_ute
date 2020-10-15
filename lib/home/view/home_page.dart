import 'package:flutter/material.dart';
import 'package:share_ute/home/home.dart';

class HomePage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => HomePage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomeNavigate(),
    );
  }
}
