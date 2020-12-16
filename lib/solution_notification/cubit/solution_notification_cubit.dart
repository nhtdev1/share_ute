import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:share_ute/authentication/authentication.dart';
import 'package:share_ute/notification/notification.dart';
import 'package:solution_repository/solution_repository.dart';

part 'solution_notification_state.dart';

class SolutionNotificationCubit extends Cubit<SolutionNotificationState> {
  SolutionNotificationCubit({
    @required SolutionRepository solutionRepository,
    @required NotificationCubit notificationCubit,
    @required AuthenticationBloc authenticationBloc,
  })  : assert(solutionRepository != null),
        assert(notificationCubit != null),
        assert(authenticationBloc != null),
        _solutionRepository = solutionRepository,
        _notificationCubit = notificationCubit,
        _authenticationBloc = authenticationBloc,
        super(const SolutionNotificationState()) {
    final postId = notificationCubit.state.currentPost.postID;
    _solutionSubscription =
        solutionRepository.solution(postId).listen((solutions) {
      emit(state.copyWith(
        solutions: solutions,
        status: SolutionNotificationStatus.fetched,
      ));
    });
  }

  final SolutionRepository _solutionRepository;
  final NotificationCubit _notificationCubit;
  final AuthenticationBloc _authenticationBloc;
  StreamSubscription<List<Solution>> _solutionSubscription;
  @override
  Future<void> close() {
    _solutionSubscription?.cancel();
    return super.close();
  }

  void _handleSolutionsChanged(List<Solution> solutions) {
    emit(state.copyWith(
      solutions: solutions,
      status: SolutionNotificationStatus.fetched,
    ));
  }
}
