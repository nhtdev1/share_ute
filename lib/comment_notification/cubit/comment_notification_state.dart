part of 'comment_notification_cubit.dart';

enum CommentNotificationStatus { unknown, fetched, newCommentAdded }

class CommentNotificationState extends Equatable {
  const CommentNotificationState({
    this.newComments = const <Comment>[],
    this.comments = const <Comment>[],
    this.status = CommentNotificationStatus.unknown,
  });

  final List<Comment> newComments;
  final List<Comment> comments;
  final CommentNotificationStatus status;

  @override
  List<Object> get props => [newComments, comments, status];

  CommentNotificationState copyWith({
    List<Comment> newComments,
    List<Comment> comments,
    CommentNotificationStatus status,
  }) {
    return CommentNotificationState(
      newComments: newComments ?? this.newComments,
      comments: comments ?? this.comments,
      status: status ?? this.status,
    );
  }
}
