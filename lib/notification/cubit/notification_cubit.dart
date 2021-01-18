import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:post_repository/post_repository.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(const NotificationState());

  void newPostCreated({Post post}) {
    emit(state.copyWith(
        currentPost: post, status: NotificationStatus.newPostCreated));
  }

  void recentPostAdded() {
    emit(state.copyWith(status: NotificationStatus.recentPostAdded));
    emit(state.copyWith(status: NotificationStatus.unknown));
  }

  void newReportCreated() {
    emit(state.copyWith(status: NotificationStatus.newReportCreated));
    emit(state.copyWith(status: NotificationStatus.unknown));
  }

  void premiumRequested() {
    emit(state.copyWith(status: NotificationStatus.premiumRequested));
    emit(state.copyWith(status: NotificationStatus.unknown));
  }

  void currentPostChanged({Post post}) {
    emit(state.copyWith(
        currentPost: post, status: NotificationStatus.currentPostChanged));
    emit(state.copyWith(status: NotificationStatus.unknown));
  }
}
