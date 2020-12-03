part of 'solution_bloc.dart';

enum SolutionStatus { initial, success, failure }

class SolutionState extends Equatable {
  const SolutionState({
    this.status = SolutionStatus.initial,
    this.solutions = const <Solution>[],
    this.hasReachedMax = false,
  });

  final SolutionStatus status;
  final List<Solution> solutions;
  final bool hasReachedMax;

  SolutionState copyWith({
    SolutionStatus status,
    List<Solution> solutions,
    bool hasReachedMax,
  }) {
    return SolutionState(
      status: status ?? this.status,
      solutions: solutions ?? this.solutions,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [status, solutions, hasReachedMax];
}
