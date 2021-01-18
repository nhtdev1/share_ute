import 'package:flutter/material.dart';
import 'package:post_repository/post_repository.dart';
import 'package:share_ute/user_rating/user_rating.dart';

class UserAvatar extends StatelessWidget {
  UserAvatar(this.post);

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: (MediaQuery.of(context).size.width / 1.2) - 24.0 - 25.0,
        right: 15,
        child: GestureDetector(
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey,
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(60.0)),
              child: post.photoURL.isNotEmpty
                  ? Image.network(post.photoURL)
                  : Container(),
            ),
          ),
          onTap: () {
            Navigator.push(
              context,
              UserRatingPage.route(post.username, post.photoURL),
            );
          },
        ));
  }
}
