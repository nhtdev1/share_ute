part of 'react_post_bloc.dart';

abstract class ReactPostEvent extends Equatable {
  const ReactPostEvent();
  @override
  List<Object> get props => [];
}

class ReactPostChanged extends ReactPostEvent {
  const ReactPostChanged(this.emotions);

  final List<Emotion> emotions;

  @override
  List<Object> get props => [emotions];
}

class ReactPostRequested extends ReactPostEvent {
  const ReactPostRequested(this.id);

  final int id;

  @override
  List<Object> get props => [id];
}
