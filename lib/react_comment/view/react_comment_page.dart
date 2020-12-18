import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_ute/authentication/authentication.dart';
import 'package:share_ute/react_comment/react_comment.dart';
import 'package:comment_repository/comment_repository.dart';

class ReactCommentPage extends StatelessWidget {
  const ReactCommentPage({Key key, @required this.comment}) : super(key: key);

  final Comment comment;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ReactCommentBloc>(
      create: (context) => ReactCommentBloc(
        commentRepository: CommentRepository(),
        authenticationBloc: context.read<AuthenticationBloc>(),
        comment: comment,
      ),
      child: ReactCommentForm(),
    );
  }
}
