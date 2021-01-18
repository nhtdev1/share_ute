import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:post_repository/post_repository.dart';

part 'post_notification_state.dart';

class PostNotificationCubit extends Cubit<PostNotificationState> {
  PostNotificationCubit({@required PostRepository postRepository})
      : _postRepository = postRepository,
        super(const PostNotificationState()) {
    _postSubscription = postRepository.posts.listen((posts) {
      emit(state.copyWith(
        posts: posts,
        status: PostNotificationStatus.fetched,
      ));
    });
  }

  final PostRepository _postRepository;

  StreamSubscription<List<Post>> _postSubscription;
  @override
  Future<void> close() {
    _postSubscription?.cancel();
    return super.close();
  }

  void addRecentPost(Post post) {
    _postRepository.createRecentPost(post: post);
  }

  Future<void> removeRecentPost(Post post) async {
    return _postRepository.removeRecentPost(post: post);
  }
}
