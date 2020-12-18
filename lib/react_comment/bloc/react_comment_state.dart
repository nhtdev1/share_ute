part of 'react_comment_bloc.dart';

enum ReactCommentStatus {
  unknown,
  reactedWithLike,
  reactedWithLove,
  reactedWithWow,
  reactedWithAngry,
}

class ReactCommentState extends Equatable {
  const ReactCommentState({
    this.emotions = const [],
    this.userStatus = ReactCommentStatus.unknown,
  });

  final List<Emotion> emotions;
  final ReactCommentStatus userStatus;

  @override
  List<Object> get props => [
        emotions,
        userStatus,
      ];

  ReactCommentState copyWith({
    List<Emotion> emotions,
    ReactCommentStatus userStatus,
  }) {
    return ReactCommentState(
      emotions: emotions ?? this.emotions,
      userStatus: userStatus ?? this.userStatus,
    );
  }
}
