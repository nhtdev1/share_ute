part of 'notification_cubit.dart';

enum NotificationStatus {
  unknown,
  newPostCreated,
}

class NotificationState extends Equatable {
  const NotificationState({
    this.currentPost = Post.empty,
    this.userOfCurrentPost = User.empty,
    this.status = NotificationStatus.unknown,
  });

  //Current post which is viewed by guest/user
  final Post currentPost;
  final User userOfCurrentPost;
  final NotificationStatus status;

  @override
  List<Object> get props => [currentPost, userOfCurrentPost, status];

  NotificationState copyWith({
    Post currentPost,
    User userOfCurrentPost,
    NotificationStatus status,
  }) {
    return NotificationState(
      currentPost: currentPost ?? this.currentPost,
      userOfCurrentPost: userOfCurrentPost ?? this.userOfCurrentPost,
      status: status ?? this.status,
    );
  }
}
