import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';
import 'package:share_ute/notification/notification.dart';
import 'package:solution_repository/solution_repository.dart';

part 'solution_event.dart';
part 'solution_state.dart';

const _solutionLimit = 20;

class SolutionBloc extends Bloc<SolutionEvent, SolutionState> {
  SolutionBloc({
    @required SolutionRepository solutionRepository,
    @required NotificationCubit notificationCubit,
    @required this.httpClient,
  })  : assert(solutionRepository != null),
        assert(notificationCubit != null),
        _solutionRepository = solutionRepository,
        _notificationCubit = notificationCubit,
        super(const SolutionState());

  final SolutionRepository _solutionRepository;
  final NotificationCubit _notificationCubit;
  final http.Client httpClient;
  @override
  Stream<SolutionState> mapEventToState(SolutionEvent event) async* {
    if (event is SolutionFetched) {
      yield await _mapSolutionFetchedToState(state);
    }
  }

  Future<SolutionState> _mapSolutionFetchedToState(SolutionState state) async {
    if (state.hasReachedMax) return state;
    try {
      if (state.status == SolutionStatus.initial) {
        final solutions = await _fetchSolutions();
        return state.copyWith(
          status: SolutionStatus.success,
          solutions: solutions,
          hasReachedMax: _hasReachedMax(solutions.length),
        );
      }

      final solutions = await _fetchSolutions(state.solutions.length);
      return solutions.isEmpty
          ? state.copyWith(hasReachedMax: true)
          : state.copyWith(
              status: SolutionStatus.success,
              solutions: List.of(state.solutions)..addAll(solutions),
              hasReachedMax: _hasReachedMax(solutions.length),
            );
    } on Exception {
      return state.copyWith(status: SolutionStatus.failure);
    }
  }

  bool _hasReachedMax(int solutionsCount) =>
      solutionsCount < _solutionLimit ? true : false;

  // Future<List<Solution>> _fetchSolutions([int startIndex = 0]) async {
  //   try {
  //     final response = await _solutionRepository.getSolutions(
  //         _notificationCubit.state.currentPost, _solutionLimit);

  //     return response;
  //   } catch (_) {
  //     throw Exception('error fetching posts');
  //   }
  // }

  Future<List<Solution>> _fetchSolutions([int startIndex = 0]) async {
    final response = await httpClient.get(
      'https://jsonplaceholder.typicode.com/posts?_start=$startIndex&_postLimit=$_solutionLimit',
    );
    if (response.statusCode == 200) {
      int dem = 0;
      final body = json.decode(response.body) as List;
      return body.map((dynamic json) {
        return Solution(
          uid: '${dem += 1}',
          title: json['title'] as String,
          dateCreated: json['body'] as String,
        );
      }).toList();
    }
    throw Exception('error fetching posts');
  }

//verriding transform allows us to transform the Stream before mapEventToState is called.
// This allows for operations like distinct(), debounceTime(), etc... to be applied.
  @override
  Stream<Transition<SolutionEvent, SolutionState>> transformEvents(
    Stream<SolutionEvent> events,
    TransitionFunction<SolutionEvent, SolutionState> transitionFn,
  ) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }
}
