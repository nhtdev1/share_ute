import 'package:flutter/material.dart';

class AppUtilities {
  static showSnackBar({BuildContext context, String title, String action}) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          elevation: 10.0,
          backgroundColor: Colors.blue,
          behavior: SnackBarBehavior.floating,
          content: Text(title),
        ),
      );
  }
}
