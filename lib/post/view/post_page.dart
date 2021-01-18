import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post_repository/post_repository.dart';
import 'package:share_ute/post/post.dart';
import 'package:share_ute/post_notification/post_notification.dart';

class PostPage extends StatelessWidget {
  const PostPage({Key key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (context) => const PostPage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PostBloc(
        postRepository: context.read<PostRepository>(),
        postNotificationCubit: context.read<PostNotificationCubit>(),
      )..add(PostFetched()),
      child: PostForm(),
    );
  }
}
