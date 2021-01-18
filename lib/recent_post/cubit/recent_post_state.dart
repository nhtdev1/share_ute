part of 'recent_post_cubit.dart';

enum PostViewMode {
  isList,
  isGrid,
}

enum RecentPostStatus {
  unknown,
  fetched,
  changed,
  sorted,
}

class RecentPostState extends Equatable {
  const RecentPostState({
    this.posts = const [],
    this.viewMode = PostViewMode.isList,
    this.status = RecentPostStatus.unknown,
  });

  final List<Post> posts;
  final PostViewMode viewMode;
  final RecentPostStatus status;

  @override
  List<Object> get props => [posts, viewMode, status];

  RecentPostState copyWith({
    List<Post> posts,
    PostViewMode viewMode,
    RecentPostStatus status,
  }) {
    return RecentPostState(
      posts: posts ?? this.posts,
      viewMode: viewMode ?? this.viewMode,
      status: status ?? this.status,
    );
  }
}
