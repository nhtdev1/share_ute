part of 'react_solution_bloc.dart';

abstract class ReactSolutionEvent extends Equatable {
  const ReactSolutionEvent();
  @override
  List<Object> get props => [];
}

class ReactSolutionChanged extends ReactSolutionEvent {
  const ReactSolutionChanged(this.emotions);

  final List<Emotion> emotions;

  @override
  List<Object> get props => [emotions];
}

class ReactSolutionRequested extends ReactSolutionEvent {
  const ReactSolutionRequested(this.id);

  final int id;

  @override
  List<Object> get props => [id];
}
