part of 'notification_cubit.dart';

enum NotificationStatus {
  unknown,
  postCreated,
}

class NotificationState extends Equatable {
  const NotificationState({
    this.post = Post.empty,
    this.status = NotificationStatus.unknown,
  });

  final Post post;
  final NotificationStatus status;

  @override
  // TODO: implement props
  List<Object> get props => [post, status];

  NotificationState copyWith({
    Post post,
    NotificationStatus status,
  }) {
    return NotificationState(
      post: post ?? this.post,
      status: status ?? this.status,
    );
  }
}
