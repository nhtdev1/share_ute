part of 'report_post_cubit.dart';

enum ReportPostProgress {
  unknown,
  submissionInProgress,
  submissionSuccess,
  submissionFailure,
}

class ReportPostState extends Equatable {
  const ReportPostState({
    this.name = '',
    this.detail = '',
    this.reportPostProgress = ReportPostProgress.unknown,
  });

  final String name;
  final String detail;
  final ReportPostProgress reportPostProgress;

  ReportPostState copyWith({
    String name,
    String detail,
    ReportPostProgress reportPostProgress,
  }) {
    return ReportPostState(
      name: name ?? this.name,
      detail: detail ?? this.detail,
      reportPostProgress: reportPostProgress ?? this.reportPostProgress,
    );
  }

  @override
  List<Object> get props => [name, detail, reportPostProgress];
}
