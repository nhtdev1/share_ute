import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:share_ute/notification/notification.dart';
import 'package:solution_repository/solution_repository.dart';

part 'solution_notification_state.dart';

class SolutionNotificationCubit extends Cubit<SolutionNotificationState> {
  SolutionNotificationCubit({
    @required SolutionRepository solutionRepository,
    @required NotificationCubit notificationCubit,
  }) : super(const SolutionNotificationState()) {
    final postId = notificationCubit.state.currentPost.postID;
    _solutionSubscription =
        solutionRepository.solution(postId).listen((solutions) {
      emit(state.copyWith(
        solutions: solutions,
        status: SolutionNotificationStatus.fetched,
      ));
    });
  }

  StreamSubscription<List<Solution>> _solutionSubscription;
  @override
  Future<void> close() {
    _solutionSubscription?.cancel();
    return super.close();
  }
}
