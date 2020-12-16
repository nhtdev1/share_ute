part of 'solution_notification_cubit.dart';

enum SolutionNotificationStatus { unknown, fetched, newSolutionAdded }

class SolutionNotificationState extends Equatable {
  const SolutionNotificationState({
    this.recentSolution = Solution.empty,
    this.solutions = const <Solution>[],
    this.recentSolutionTotal = 0,
    this.status = SolutionNotificationStatus.unknown,
  });

  final Solution recentSolution;
  final int recentSolutionTotal;
  final List<Solution> solutions;
  final SolutionNotificationStatus status;

  @override
  List<Object> get props =>
      [recentSolution, solutions, recentSolutionTotal, status];

  SolutionNotificationState copyWith({
    Solution recentSolution,
    List<Solution> solutions,
    int recentSolutionTotal,
    SolutionNotificationStatus status,
  }) {
    return SolutionNotificationState(
      recentSolution: recentSolution ?? this.recentSolution,
      solutions: solutions ?? this.solutions,
      recentSolutionTotal: recentSolutionTotal ?? this.recentSolutionTotal,
      status: status ?? this.status,
    );
  }
}
