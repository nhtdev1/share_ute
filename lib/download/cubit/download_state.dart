part of 'download_cubit.dart';

enum DownloadStatus {
  unknown,
  downloadInProgress,
  downloadSuccess,
  downloadFailure,
}

class DownloadState extends Equatable {
  const DownloadState({
    this.taskId = '',
    this.percentage = 0,
    this.status = DownloadStatus.unknown,
  });

  final String taskId;
  final int percentage;
  final DownloadStatus status;

  DownloadState copyWith({
    String taskId,
    int percentage,
    DownloadStatus status,
  }) {
    return DownloadState(
      taskId: taskId ?? this.taskId,
      percentage: percentage ?? this.percentage,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [taskId, percentage, status];
}
