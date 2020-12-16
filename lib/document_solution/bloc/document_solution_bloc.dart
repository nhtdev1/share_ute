import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:share_ute/solution_notification/cubit/solution_notification_cubit.dart';
import 'package:solution_repository/solution_repository.dart';

part 'document_solution_event.dart';
part 'document_solution_state.dart';

const _solutionLimit = 20;

class DocumentSolutionBloc
    extends Bloc<DocumentSolutionEvent, DocumentSolutionState> {
  DocumentSolutionBloc({
    @required SolutionRepository solutionRepository,
    @required SolutionNotificationCubit solutionNotificationCubit,
  })  : _solutionNotificationCubit = solutionNotificationCubit,
        super(DocumentSolutionState()) {
    _solutionSubscription =
        _solutionNotificationCubit.listen((solutionNotificationState) {
      solutionList = solutionNotificationState.solutions;
      add(DocumentSolutionRefreshed());
    });
  }

  final SolutionNotificationCubit _solutionNotificationCubit;
  List<Solution> solutionList = [];
  StreamSubscription<SolutionNotificationState> _solutionSubscription;

  @override
  Future<void> close() {
    _solutionSubscription?.cancel();
    return super.close();
  }

  @override
  Stream<DocumentSolutionState> mapEventToState(
      DocumentSolutionEvent event) async* {
    if (event is DocumentSolutionFetched) {
      yield await _mapSolutionFetchedToState();
    } else if (event is DocumentSolutionRefreshed) {
      yield await _mapDocumentSolutionRefreshedToState();
    }
  }

  Future<DocumentSolutionState> _mapDocumentSolutionRefreshedToState() async {
    final solutions = _fetchSolutions(state.solutions.length);
    return solutions.isEmpty
        ? state.copyWith(hasReachedMax: true)
        : state.copyWith(
            status: DocumentSolutionStatus.success,
            solutions: List.of(state.solutions)..addAll(solutions),
            hasReachedMax: _hasReachedMax(solutions.length),
          );
  }

  Future<DocumentSolutionState> _mapSolutionFetchedToState() async {
    if (state.hasReachedMax) return state;
    if (state.status == DocumentSolutionStatus.initial) {
      final solutions = _fetchSolutions();
      return state.copyWith(
        status: DocumentSolutionStatus.success,
        solutions: solutions,
        hasReachedMax: _hasReachedMax(solutions.length),
      );
    }

    final solutions = _fetchSolutions(state.solutions.length);
    return solutions.isEmpty
        ? state.copyWith(hasReachedMax: true)
        : state.copyWith(
            status: DocumentSolutionStatus.success,
            solutions: List.of(state.solutions)..addAll(solutions),
            hasReachedMax: _hasReachedMax(solutions.length),
          );
  }

  bool _hasReachedMax(int solutionsCount) =>
      solutionsCount < _solutionLimit ? true : false;

  List<Solution> _fetchSolutions([int startIndex = 0]) {
    solutionList = _solutionNotificationCubit.state.solutions;
    if (startIndex + _solutionLimit <= solutionList.length) {
      return solutionList
          .getRange(startIndex, startIndex + _solutionLimit)
          .toList();
    } else if (startIndex < solutionList.length) {
      return solutionList.getRange(startIndex, solutionList.length).toList();
    } else {
      return [];
    }
  }

//verriding transform allows us to transform the Stream before mapEventToState is called.
// This allows for operations like distinct(), debounceTime(), etc... to be applied.
  @override
  Stream<Transition<DocumentSolutionEvent, DocumentSolutionState>>
      transformEvents(
    Stream<DocumentSolutionEvent> events,
    TransitionFunction<DocumentSolutionEvent, DocumentSolutionState>
        transitionFn,
  ) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 100)),
      transitionFn,
    );
  }
}
