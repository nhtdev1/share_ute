import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:share_ute/notification/notification.dart';
import 'package:comment_repository/comment_repository.dart';

part 'comment_notification_state.dart';

class CommentNotificationCubit extends Cubit<CommentNotificationState> {
  CommentNotificationCubit({
    @required CommentRepository commentRepository,
    @required NotificationCubit notificationCubit,
  }) : super(const CommentNotificationState()) {
    final postId = notificationCubit.state.currentPost.postID;
    _commentSubscription = commentRepository.comment(postId).listen((comments) {
      emit(state.copyWith(
        comments: comments,
        status: CommentNotificationStatus.fetched,
      ));
    });
  }

  StreamSubscription<List<Comment>> _commentSubscription;
  @override
  Future<void> close() {
    _commentSubscription?.cancel();
    return super.close();
  }
}
