import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:post_repository/post_repository.dart';
import 'package:share_ute/authentication/authentication.dart';
import 'package:share_ute/notification/notification.dart';
import 'package:user_repository/user_repository.dart';

part 'document_info_event.dart';

part 'document_info_state.dart';

class DocumentInfoBloc extends Bloc<DocumentInfoEvent, DocumentInfoState> {
  DocumentInfoBloc({
    @required PostRepository postRepository,
    @required FirestoreUserRepository firestoreUserRepository,
    @required NotificationCubit notificationCubit,
    @required AuthenticationBloc authenticationBloc,
  })  : assert(postRepository != null),
        assert(firestoreUserRepository != null),
        assert(notificationCubit != null),
        assert(authenticationBloc != null),
        _postRepository = postRepository,
        _firestoreUserRepository = firestoreUserRepository,
        _notificationCubit = notificationCubit,
        _authenticationBloc = authenticationBloc,
        super(const DocumentInfoState.unknown()) {
    // When user open a post, _postRepository will listen to this post on firestore
    _postRepository
        .emotions(notificationCubit.state.currentPost.postID)
        .listen((reactions) {
      print(reactions.length);
    });
  }

  final PostRepository _postRepository;

  final FirestoreUserRepository _firestoreUserRepository;

  final AuthenticationBloc _authenticationBloc;

  final NotificationCubit _notificationCubit;

  StreamSubscription<Post> _postSubscription;

  @override
  Future<void> close() {
    _postSubscription?.cancel();
    return super.close();
  }

  @override
  Stream<DocumentInfoState> mapEventToState(DocumentInfoEvent event) async* {
    if (event is DocumentInfoChanged) {
      yield await _mapDocumentInfoChangedState(event);
    } else if (event is DocumentInfoLikeRequested) {
      yield await _mapDocumentInfoLikeRequestedToState(event);
    }
  }

  Future<DocumentInfoState> _mapDocumentInfoLikeRequestedToState(
    DocumentInfoLikeRequested event,
  ) async {
    final post = state.post.copyWith();

    bool likePressed = true;
    // Get list of like
    final like = post.like.map((element) => element).toList();
    if (like.contains(_authenticationBloc.state.user.id)) {
      like.remove(_authenticationBloc.state.user.id);
      likePressed = false;
    } else {
      like.add(_authenticationBloc.state.user.id);
    }

    final result = await _postRepository.updateLike(
      postID: _notificationCubit.state.currentPost.postID,
      like: like,
    );

    // Update like successfully
    if (result) {
      if (likePressed) {
        if (state.userOfPost.id == _authenticationBloc.state.user.id) {
          return DocumentInfoState.ownerLiked(
            post: state.post.copyWith(
              like: like,
            ),
            user: state.userOfPost,
          );
        } else {
          return DocumentInfoState.guestLiked(
            post: state.post.copyWith(
              like: like,
            ),
            user: state.userOfPost,
          );
        }
      } else {
        if (state.post.uid == _authenticationBloc.state.user.id) {
          return DocumentInfoState.ownerUnliked(
            post: state.post.copyWith(
              like: like,
            ),
            user: state.userOfPost,
          );
        } else {
          return DocumentInfoState.guestUnliked(
            post: state.post.copyWith(
              like: like,
            ),
            user: state.userOfPost,
          );
        }
      }
    } else {
      return DocumentInfoState.postChanged(
        post: state.post,
        user: state.userOfPost,
      );
    }
  }

  Future<DocumentInfoState> _mapDocumentInfoChangedState(
    DocumentInfoChanged event,
  ) async {
    // Find user of post
    final userOfPost =
        await _firestoreUserRepository.findUserById(event.post.uid);
    if (state.status == DocumentInfoStatus.unknown) {
      return state.copyWith(
        post: event.post,
        userOfPost: userOfPost.copyWith(
          id: _authenticationBloc.state.user.id,
        ),
        status: DocumentInfoStatus.dataChanged,
      );
    }
    if (state.status == DocumentInfoStatus.dataChanged) {}
    return DocumentInfoState.postChanged(
      post: event.post,
      user: userOfPost.copyWith(
        id: _authenticationBloc.state.user.id,
      ),
    );
  }
}
