part of 'react_comment_bloc.dart';

abstract class ReactCommentEvent extends Equatable {
  const ReactCommentEvent();
  @override
  List<Object> get props => [];
}

class ReactCommentChanged extends ReactCommentEvent {
  const ReactCommentChanged(this.emotions);

  final List<Emotion> emotions;

  @override
  List<Object> get props => [emotions];
}

class ReactCommentRequested extends ReactCommentEvent {
  const ReactCommentRequested(this.id);

  final int id;

  @override
  List<Object> get props => [id];
}
