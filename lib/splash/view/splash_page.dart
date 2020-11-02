import 'dart:async';

import 'package:flutter/material.dart';

// The SplashPage is shown while the application determines the authentication state
// of the user.
class SplashPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => SplashPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/images/logo_utes.png',
          key: const Key('splash_bloc_image'),
          width: 150,
        ),
      ),
    );
  }
}
