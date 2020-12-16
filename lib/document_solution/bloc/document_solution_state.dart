part of 'document_solution_bloc.dart';

enum DocumentSolutionStatus { initial, success, failure }

class DocumentSolutionState extends Equatable {
  const DocumentSolutionState({
    this.status = DocumentSolutionStatus.initial,
    this.solutions = const <Solution>[],
    this.hasReachedMax = false,
  });

  final DocumentSolutionStatus status;
  final List<Solution> solutions;
  final bool hasReachedMax;

  DocumentSolutionState copyWith({
    DocumentSolutionStatus status,
    List<Solution> solutions,
    bool hasReachedMax,
  }) {
    return DocumentSolutionState(
      status: status ?? this.status,
      solutions: solutions ?? this.solutions,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [status, solutions, hasReachedMax];
}
