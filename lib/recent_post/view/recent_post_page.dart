import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post_repository/post_repository.dart';
import 'package:share_ute/recent_post/recent_post.dart';

class RecentPostPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RecentPostCubit(postRepository: PostRepository()),
      child: MediaQuery.removePadding(
        removeTop: true,
        context: context,
        child: RecentPostForm(),
      ),
    );
  }
}
