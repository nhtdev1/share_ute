part of 'react_solution_bloc.dart';

enum ReactSolutionStatus {
  unknown,
  reactedWithLike,
  reactedWithLove,
  reactedWithWow,
  reactedWithAngry,
}

class ReactSolutionState extends Equatable {
  const ReactSolutionState({
    this.emotions = const [],
    this.userStatus = ReactSolutionStatus.unknown,
  });

  final List<Emotion> emotions;
  final ReactSolutionStatus userStatus;

  @override
  List<Object> get props => [
        emotions,
        userStatus,
      ];

  ReactSolutionState copyWith({
    List<Emotion> emotions,
    ReactSolutionStatus userStatus,
  }) {
    return ReactSolutionState(
      emotions: emotions ?? this.emotions,
      userStatus: userStatus ?? this.userStatus,
    );
  }
}
