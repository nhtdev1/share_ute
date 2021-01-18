import 'package:flutter/material.dart';
import 'package:share_ute/user_rating/view/view.dart';

class UserRatingPage extends StatelessWidget {
  UserRatingPage({this.username, this.photoURL});
  final String username;
  final String photoURL;
  static Route route(String username, String photoURL) {
    return MaterialPageRoute<void>(
        builder: (context) => UserRatingPage(
              username: username,
              photoURL: photoURL,
            ));
  }

  @override
  Widget build(BuildContext context) {
    return UserRatingForm(
      username: username,
      photoURL: photoURL,
    );
  }
}
