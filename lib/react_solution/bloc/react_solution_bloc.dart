import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:post_repository/post_repository.dart';
import 'package:share_ute/authentication/authentication.dart';
import 'package:solution_repository/solution_repository.dart';

part 'react_solution_event.dart';
part 'react_solution_state.dart';

class ReactSolutionBloc extends Bloc<ReactSolutionEvent, ReactSolutionState> {
  ReactSolutionBloc({
    SolutionRepository solutionRepository,
    AuthenticationBloc authenticationBloc,
    Solution solution,
  })  : assert(solutionRepository != null),
        assert(authenticationBloc != null),
        _solutionRepository = solutionRepository,
        _authenticationBloc = authenticationBloc,
        super(const ReactSolutionState()) {
    _path = '${solution.postID}/solutions/${solution.solutionID}';
    _reactionSubscription =
        solutionRepository.emotions(_path).listen((emotions) {
      add(ReactSolutionChanged(emotions));
    });
  }

  final SolutionRepository _solutionRepository;

  final AuthenticationBloc _authenticationBloc;
  String _path;

  StreamSubscription<List<Emotion>> _reactionSubscription;

  @override
  Future<void> close() {
    _reactionSubscription?.cancel();
    return super.close();
  }

  @override
  Stream<ReactSolutionState> mapEventToState(ReactSolutionEvent event) async* {
    if (event is ReactSolutionChanged) {
      yield _mapEmotionChangedToState(event);
    } else if (event is ReactSolutionRequested) {
      // yield await _mapEmotionReactRequestedToState(event);
      _handleEmotionReactRequested(event);
    }
  }

  _getUserStatusById(String id) {
    if (id == '1') {
      return ReactSolutionStatus.reactedWithLike;
    } else if (id == '2') {
      return ReactSolutionStatus.reactedWithLove;
    } else if (id == '3') {
      return ReactSolutionStatus.reactedWithWow;
    } else if (id == '4') {
      return ReactSolutionStatus.reactedWithAngry;
    } else {
      return ReactSolutionStatus.unknown;
    }
  }

  void _handleEmotionReactRequested(
    ReactSolutionRequested event,
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
      _solutionRepository.setEmotion(_path, e);
    } else {
      if (reactedEmotion.id == event.id.toString()) {
        _solutionRepository.deleteEmotion(_path, e);
      } else {
        _solutionRepository.updateEmotion(_path, e);
      }
    }
  }

  ReactSolutionState _mapEmotionChangedToState(
    ReactSolutionChanged event,
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
