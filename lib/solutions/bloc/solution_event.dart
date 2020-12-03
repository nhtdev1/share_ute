part of 'solution_bloc.dart';

// At high level,  it will be responding to user input (scrolling)
// and fetching more solutions in order for the presentation layer to display them
abstract class SolutionEvent extends Equatable {
  @override
  List<Object> get props => [];
}

// Will be added by presentation layer whenever it needs more Solutions to
// present
class SolutionFetched extends SolutionEvent {}
