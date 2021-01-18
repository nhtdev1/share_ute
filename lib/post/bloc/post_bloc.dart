import 'dart:async';
import 'package:rxdart/rxdart.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:post_repository/post_repository.dart';
import 'package:share_ute/post_notification/post_notification.dart';

part 'post_state.dart';
part 'post_event.dart';

const _postLimit = 20;

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc({
    @required PostRepository postRepository,
    @required PostNotificationCubit postNotificationCubit,
  })  : _postNotificationCubit = postNotificationCubit,
        super(PostState()) {
    _postSubscription = _postNotificationCubit.listen((postNotificationState) {
      postList = postNotificationState.posts;
      add(PostRefreshed());
    });
  }

  final PostNotificationCubit _postNotificationCubit;
  List<Post> postList = [];
  StreamSubscription<PostNotificationState> _postSubscription;

  @override
  Future<void> close() {
    _postSubscription?.cancel();
    return super.close();
  }

  @override
  Stream<PostState> mapEventToState(PostEvent event) async* {
    if (event is PostFetched) {
      yield await _mapPostFetchedToState();
    } else if (event is PostRefreshed) {
      yield await _mapPostRefreshedToState();
    }
  }

  Future<PostState> _mapPostRefreshedToState() async {
    final posts = _fetchPosts(state.posts.length);
    return posts.isEmpty
        ? state.copyWith(hasReachedMax: true)
        : state.copyWith(
            status: PostStatus.success,
            posts: List.of(state.posts)..addAll(posts),
            hasReachedMax: _hasReachedMax(posts.length),
          );
  }

  Future<PostState> _mapPostFetchedToState() async {
    if (state.hasReachedMax) return state;
    if (state.status == PostStatus.initial) {
      final posts = _fetchPosts();
      return state.copyWith(
        status: PostStatus.success,
        posts: posts,
        hasReachedMax: _hasReachedMax(posts.length),
      );
    }

    final posts = _fetchPosts(state.posts.length);
    return posts.isEmpty
        ? state.copyWith(hasReachedMax: true)
        : state.copyWith(
            status: PostStatus.success,
            posts: List.of(state.posts)..addAll(posts),
            hasReachedMax: _hasReachedMax(posts.length),
          );
  }

  bool _hasReachedMax(int postsCount) => postsCount < _postLimit ? true : false;

  List<Post> _fetchPosts([int startIndex = 0]) {
    postList = _postNotificationCubit.state.posts;
    if (startIndex + _postLimit <= postList.length) {
      return postList.getRange(startIndex, startIndex + _postLimit).toList();
    } else if (startIndex < postList.length) {
      return postList.getRange(startIndex, postList.length).toList();
    } else {
      return [];
    }
  }

//verriding transform allows us to transform the Stream before mapEventToState is called.
// This allows for operations like distinct(), debounceTime(), etc... to be applied.
  @override
  Stream<Transition<PostEvent, PostState>> transformEvents(
    Stream<PostEvent> events,
    TransitionFunction<PostEvent, PostState> transitionFn,
  ) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 100)),
      transitionFn,
    );
  }
}
