import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_ute/comment_notification/comment_notification.dart';
import 'package:share_ute/document_comment/document_comment.dart';
import 'package:comment_repository/comment_repository.dart';

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
        bottomNavigationBar: Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                width: 15,
              ),
              Icon(Icons.camera_alt_outlined),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: InkWell(
                  child: TextFormField(
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'WorkSans',
                    ),
                    decoration: InputDecoration(
                      hintText: "Thêm bình luận...",
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Icon(Icons.gif_outlined),
              const SizedBox(
                width: 10,
              ),
              Icon(Icons.emoji_emotions_outlined),
              const SizedBox(
                width: 10,
              ),
              const SizedBox(
                width: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
