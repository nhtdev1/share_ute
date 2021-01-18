part of 'system_notification_cubit.dart';

enum SystemStatus {
  unknown,
  backButtonPressed,
}

class SystemNotificationState extends Equatable {
  const SystemNotificationState({
    this.systemStatus = SystemStatus.unknown,
    this.dateTime,
  });

  final SystemStatus systemStatus;
  final DateTime dateTime;

  @override
  List<Object> get props => [systemStatus, dateTime];

  SystemNotificationState copyWith({
    SystemStatus systemStatus,
    DateTime dateTime,
  }) {
    return SystemNotificationState(
      systemStatus: systemStatus ?? this.systemStatus,
      dateTime: dateTime ?? this.dateTime,
    );
  }
}
