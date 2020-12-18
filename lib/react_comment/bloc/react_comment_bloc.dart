import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:post_repository/post_repository.dart';
import 'package:share_ute/authentication/authentication.dart';
import 'package:comment_repository/comment_repository.dart';

part 'react_comment_event.dart';
part 'react_comment_state.dart';

class ReactCommentBloc extends Bloc<ReactCommentEvent, ReactCommentState> {
  ReactCommentBloc({
    CommentRepository commentRepository,
    AuthenticationBloc authenticationBloc,
    Comment comment,
  })  : assert(commentRepository != null),
        assert(authenticationBloc != null),
        _commentRepository = commentRepository,
        _authenticationBloc = authenticationBloc,
        super(const ReactCommentState()) {
    _path = '${comment.postId}/comments/${comment.commentId}';
    _reactionSubscription =
        _commentRepository.emotions(_path).listen((emotions) {
      add(ReactCommentChanged(emotions));
    });
  }

  final CommentRepository _commentRepository;

  final AuthenticationBloc _authenticationBloc;
  String _path;

  StreamSubscription<List<Emotion>> _reactionSubscription;

  @override
  Future<void> close() {
    _reactionSubscription?.cancel();
    return super.close();
  }

  @override
  Stream<ReactCommentState> mapEventToState(ReactCommentEvent event) async* {
    if (event is ReactCommentChanged) {
      yield _mapReactCommentChangedToState(event);
    } else if (event is ReactCommentRequested) {
      // yield await _mapEmotionReactRequestedToState(event);
      _handleReactCommentRequested(event);
    }
  }

  _getUserStatusById(String id) {
    if (id == '1') {
      return ReactCommentStatus.reactedWithLike;
    } else if (id == '2') {
      return ReactCommentStatus.reactedWithLove;
    } else if (id == '3') {
      return ReactCommentStatus.reactedWithWow;
    } else if (id == '4') {
      return ReactCommentStatus.reactedWithAngry;
    } else {
      return ReactCommentStatus.unknown;
    }
  }

  void _handleReactCommentRequested(
    ReactCommentRequested event,
  ) async {
    final uid = _authenticationBloc.state.user.id;
    // Get current emotions of Post
    final currentEmotions = state.emotions.map((e) => e).toList();

    final reactedEmotion = currentEmotions.firstWhere(
        (emotion) => emotion.uid == uid,
        orElse: () => Emotion.empty);

    final e = Emotion(
      uid: uid,
      id: event.id.toString(),
    );

    if (reactedEmotion == Emotion.empty) {
      _commentRepository.setEmotion(_path, e);
    } else {
      if (reactedEmotion.id == event.id.toString()) {
        _commentRepository.deleteEmotion(_path, e);
      } else {
        _commentRepository.updateEmotion(_path, e);
      }
    }
  }

  ReactCommentState _mapReactCommentChangedToState(
    ReactCommentChanged event,
  ) {
    final emotions = event.emotions.map((e) => e).toList();

    final reactedEmotionByUser = emotions.firstWhere(
        (emotion) => emotion.uid == _authenticationBloc.state.user.id,
        orElse: () => Emotion.empty);

    final userStatus = _getUserStatusById(reactedEmotionByUser.id);

    return state.copyWith(
      emotions: event.emotions,
      userStatus: userStatus,
    );
  }
}
