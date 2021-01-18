import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:post_repository/post_repository.dart';

part 'recent_post_state.dart';

enum SortType {
  byName,
  byDateCreatedDesc,
  byDateCreatedAsc,
  byFileSizeDesc,
  byFileSizeAsc,
  byDownloadTotalDesc,
  byDownloadTotalAsc,
}

class RecentPostCubit extends Cubit<RecentPostState> {
  RecentPostCubit({PostRepository postRepository})
      : super(const RecentPostState()) {
    _recentPostsSubscription = postRepository.recentPosts.listen((posts) {
      emit(state.copyWith(
        posts: posts,
        status: RecentPostStatus.fetched,
      ));
    });
  }

  StreamSubscription<List<Post>> _recentPostsSubscription;
  @override
  Future<void> close() {
    _recentPostsSubscription?.cancel();
    return super.close();
  }

  void switchViewMode() {
    if (state.viewMode == PostViewMode.isList) {
      emit(state.copyWith(viewMode: PostViewMode.isGrid));
    } else {
      emit(state.copyWith(viewMode: PostViewMode.isList));
    }
  }

  void sortBy(SortType type) {
    switch (type) {
      case SortType.byName:
        state.posts.sort((a, b) => a.postTitle.compareTo(b.postTitle));
        emit(state.copyWith(status: RecentPostStatus.sorted));
        emit(state.copyWith(status: RecentPostStatus.unknown));
        break;
      case SortType.byDateCreatedDesc:
        state.posts.sort((b, a) => a.dateCreated.compareTo(b.dateCreated));
        emit(state.copyWith(status: RecentPostStatus.sorted));
        emit(state.copyWith(status: RecentPostStatus.unknown));
        break;
      case SortType.byDateCreatedAsc:
        state.posts.sort((a, b) => a.dateCreated.compareTo(b.dateCreated));
        emit(state.copyWith(status: RecentPostStatus.sorted));
        emit(state.copyWith(status: RecentPostStatus.unknown));
        break;
      case SortType.byFileSizeDesc:
        state.posts.sort((b, a) =>
            a.originalFile.fileSize.compareTo(b.originalFile.fileSize));
        emit(state.copyWith(status: RecentPostStatus.sorted));
        emit(state.copyWith(status: RecentPostStatus.unknown));
        break;
      case SortType.byFileSizeAsc:
        state.posts.sort((a, b) =>
            a.originalFile.fileSize.compareTo(b.originalFile.fileSize));
        emit(state.copyWith(status: RecentPostStatus.sorted));
        emit(state.copyWith(status: RecentPostStatus.unknown));
        break;
      case SortType.byDownloadTotalDesc:
        state.posts.sort((a, b) => a.postTitle.compareTo(b.postTitle));
        emit(state.copyWith(status: RecentPostStatus.sorted));
        emit(state.copyWith(status: RecentPostStatus.unknown));
        break;
      case SortType.byDownloadTotalAsc:
        state.posts.sort((a, b) => a.postTitle.compareTo(b.postTitle));
        emit(state.copyWith(status: RecentPostStatus.sorted));
        emit(state.copyWith(status: RecentPostStatus.unknown));
        break;
      default:
        break;
    }
  }
}
