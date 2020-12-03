import 'package:flutter/material.dart';
import 'package:share_ute/document/document.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserAvatar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = context.watch<DocumentCubit>().state.userOfPost;
    return Positioned(
      top: (MediaQuery.of(context).size.width / 1.2) - 24.0 - 25.0,
      right: 15,
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey,
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(60.0)),
          child:
              user.photo.isNotEmpty ? Image.network(user.photo) : Container(),
        ),
      ),
    );
  }
}
