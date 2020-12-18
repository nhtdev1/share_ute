import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:post_repository/post_repository.dart';
import 'package:share_ute/authentication/authentication.dart';
import 'package:share_ute/notification/notification.dart';

part 'react_post_event.dart';
part 'react_post_state.dart';

class ReactPostBloc extends Bloc<ReactPostEvent, ReactPostState> {
  ReactPostBloc({
    @required PostRepository postRepository,
    @required NotificationCubit notificationCubit,
    @required AuthenticationBloc authenticationBloc,
  })  : assert(postRepository != null),
        assert(notificationCubit != null),
        assert(authenticationBloc != null),
        _postRepository = postRepository,
        _notificationCubit = notificationCubit,
        _authenticationBloc = authenticationBloc,
        super(const ReactPostState()) {
    final postID = notificationCubit.state.currentPost.postID;
    _reactionSubscription = postRepository.emotions(postID).listen((emotions) {
      add(ReactPostChanged(emotions));
    });
  }

  final PostRepository _postRepository;

  final NotificationCubit _notificationCubit;

  final AuthenticationBloc _authenticationBloc;

  StreamSubscription<List<Emotion>> _reactionSubscription;

  @override
  Future<void> close() {
    _reactionSubscription?.cancel();
    return super.close();
  }

  @override
  Stream<ReactPostState> mapEventToState(ReactPostEvent event) async* {
    if (event is ReactPostChanged) {
      yield _mapReactPostChangedToState(event);
    } else if (event is ReactPostRequested) {
      _handleReactPostRequested(event);
    }
  }

  _getUserStatusById(String id) {
    if (id == '1') {
      return ReactPostStatus.reactedWithLike;
    } else if (id == '2') {
      return ReactPostStatus.reactedWithLove;
    } else if (id == '3') {
      return ReactPostStatus.reactedWithWow;
    } else if (id == '4') {
      return ReactPostStatus.reactedWithAngry;
    } else {
      return ReactPostStatus.unknown;
    }
  }

  void _handleReactPostRequested(
    ReactPostRequested event,
  ) async {
    final uid = _authenticationBloc.state.user.id;
    // Get current emotions of Post
    final currentEmotions = state.emotions.map((e) => e).toList();

    final reactedEmotion = currentEmotions.firstWhere(
        (emotion) => emotion.uid == uid,
        orElse: () => Emotion.empty);

    final e = Emotion(
      postID: _notificationCubit.state.currentPost.postID,
      uid: uid,
      id: event.id.toString(),
    );

    if (reactedEmotion == Emotion.empty) {
      _postRepository.setEmotion(e);
    } else {
      if (reactedEmotion.id == event.id.toString()) {
        _postRepository.deleteEmotion(e);
      } else {
        _postRepository.updateEmotion(e);
      }
    }
  }

  ReactPostState _mapReactPostChangedToState(
    ReactPostChanged event,
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
