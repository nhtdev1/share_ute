part of 'emotion_bloc.dart';

enum EmotionInteractionStatus {
  unknown,
  reactedWithLike,
  reactedWithLove,
  reactedWithWow,
  reactedWithAngry,
}

class EmotionState extends Equatable {
  const EmotionState({
    this.emotions = const [],
    this.userStatus = EmotionInteractionStatus.unknown,
  });

  final List<Emotion> emotions;
  final EmotionInteractionStatus userStatus;

  @override
  List<Object> get props => [
        emotions,
        userStatus,
      ];

  EmotionState copyWith({
    List<Emotion> emotions,
    EmotionInteractionStatus userStatus,
  }) {
    return EmotionState(
      emotions: emotions ?? this.emotions,
      userStatus: userStatus ?? this.userStatus,
    );
  }
}
