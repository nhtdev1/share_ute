part of 'post_notification_cubit.dart';

enum PostNotificationStatus { unknown, fetched }

class PostNotificationState extends Equatable {
  const PostNotificationState({
    this.posts = const <Post>[],
    this.status = PostNotificationStatus.unknown,
  });

  final List<Post> posts;
  final PostNotificationStatus status;

  @override
  List<Object> get props => [posts, status];

  PostNotificationState copyWith({
    List<Post> posts,
    PostNotificationStatus status,
  }) {
    return PostNotificationState(
      posts: posts ?? this.posts,
      status: status ?? this.status,
    );
  }
}
