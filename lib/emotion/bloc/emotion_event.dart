part of 'emotion_bloc.dart';

abstract class EmotionEvent extends Equatable {
  const EmotionEvent();
  @override
  List<Object> get props => [];
}

class EmotionChanged extends EmotionEvent {
  const EmotionChanged(this.emotions);

  final List<Emotion> emotions;

  @override
  List<Object> get props => [emotions];
}

class EmotionReactRequested extends EmotionEvent {
  const EmotionReactRequested(this.id);

  final int id;

  @override
  List<Object> get props => [id];
}
