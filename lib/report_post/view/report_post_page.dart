import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post_repository/post_repository.dart';
import 'package:share_ute/report_post/report_post.dart';
import 'package:report_repository/report_repository.dart';

class ReportPostPage extends StatelessWidget {
  const ReportPostPage({Key key, this.post}) : super(key: key);

  static Route route(Post post) {
    return MaterialPageRoute<void>(
        builder: (context) => ReportPostPage(post: post));
  }

  final Post post;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ReportPostCubit(
        reportRepository: ReportRepository(),
        post: post,
      ),
      child: ReportPostForm(),
    );
  }
}
