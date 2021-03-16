import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post_repository/post_repository.dart';
import 'package:share_ute/play_video/play_video.dart';

class PlayVideoPage extends StatelessWidget {
  PlayVideoPage(this.post);

  final Post post;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PlayVideoCubit()..initialized(post),
      child: PlayVideoForm(),
    );
  }
}
