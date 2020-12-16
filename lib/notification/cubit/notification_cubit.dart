import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:post_repository/post_repository.dart';
import 'package:user_repository/user_repository.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(const NotificationState());

  void newPostCreated({
    Post post,
  }) {
    emit(state.copyWith(
      currentPost: post,
      status: NotificationStatus.newPostCreated,
    ));
  }
}
