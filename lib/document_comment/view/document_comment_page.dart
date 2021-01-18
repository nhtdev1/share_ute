import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_ute/comment_notification/comment_notification.dart';
import 'package:share_ute/document_comment/document_comment.dart';
import 'package:comment_repository/comment_repository.dart';
import 'package:share_ute/upload_comment/upload_comment.dart';

class DocumentCommentPage extends StatelessWidget {
  const DocumentCommentPage({Key key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(
        builder: (context) => const DocumentCommentPage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DocumentCommentBloc(
        commentRepository: CommentRepository(),
        commentNotificationCubit: context.read<CommentNotificationCubit>(),
      )..add(DocumentCommentFetched()),
      child: Scaffold(
        body: DocumentCommentForm(),
        bottomNavigationBar: UploadCommentPage(),
      ),
    );
  }
}
