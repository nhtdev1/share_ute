import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:post_repository/post_repository.dart';
import 'package:report_repository/report_repository.dart';
part 'report_post_state.dart';

class ReportPostCubit extends Cubit<ReportPostState> {
  ReportPostCubit({
    ReportRepository reportRepository,
    Post post,
  })  : _reportRepository = reportRepository,
        _post = post,
        super(const ReportPostState());

  final ReportRepository _reportRepository;
  final Post _post;

  void problemChanged(String name) {
    emit(state.copyWith(name: name));
  }

  void detailChanged(String value) {
    emit(state.copyWith(detail: value));
  }

  void clearedReport() {
    emit(state.copyWith(
      name: '',
      detail: '',
      reportPostProgress: ReportPostProgress.unknown,
    ));
  }

  void submit() async {
    final report = Report(
      postID: _post.postID,
      problem: state.name + ':' + state.detail,
      dateReported: DateTime.now().toString(),
    );
    emit(state.copyWith(
        reportPostProgress: ReportPostProgress.submissionInProgress));
    final result = await _reportRepository.createReport(report: report);
    if (result != Report.empty) {
      emit(state.copyWith(
          reportPostProgress: ReportPostProgress.submissionSuccess));
      clearedReport();
    } else {
      emit(state.copyWith(
          reportPostProgress: ReportPostProgress.submissionFailure));
    }
  }
}
