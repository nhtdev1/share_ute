import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'system_notification_state.dart';

class SystemNotificationCubit extends Cubit<SystemNotificationState> {
  SystemNotificationCubit() : super(const SystemNotificationState()) {
    Stream timer = Stream.periodic(Duration(seconds: 1), (i) {
      return DateTime.now();
    });
    timer.listen(
      (dateTime) => emit(
        state.copyWith(
          dateTime: dateTime,
        ),
      ),
    );
  }

  void onClickedBackButton() {
    emit(state.copyWith(
      systemStatus: SystemStatus.backButtonPressed,
    ));
    emit(state.copyWith(
      systemStatus: SystemStatus.unknown,
    ));
  }
}
