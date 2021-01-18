import 'package:comment_repository/comment_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_ute/firestore_user/firestore_user.dart';
import 'package:share_ute/notification/notification.dart';
import 'package:share_ute/system_notification/system_notification.dart';
import 'package:share_ute/upload_comment/upload_comment.dart';

class UploadCommentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<UploadCommentCubit>(
      create: (_) => UploadCommentCubit(
        commentRepository: CommentRepository(),
        firestoreUserBloc: context.read<FirestoreUserBloc>(),
        notificationCubit: context.read<NotificationCubit>(),
        systemNotificationCubit: context.read<SystemNotificationCubit>(),
      ),
      child: UploadCommentForm(),
    );
  }
}
