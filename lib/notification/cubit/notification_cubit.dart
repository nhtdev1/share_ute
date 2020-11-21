import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:post_repository/post_repository.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(const NotificationState());

  void postCreated(Post post) {
    emit(state.copyWith(
      post: post,
      status: NotificationStatus.postCreated,
    ));
  }
}
