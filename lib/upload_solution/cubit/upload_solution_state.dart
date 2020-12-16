part of 'upload_solution_cubit.dart';

enum SolutionStatus {
  unknown,
  unchanged,
  changed,
}

enum FileStatus {
  unknown,
  cleared,
  pickFileInProgress,
  pickedWithOverSize,
  pickedWithAcceptableSize,
  pickedError,
}

enum UploadSolutionProgress {
  unknown,
  submissionInProgress,
  submissionSuccess,
  submissionFailure,
}

class UploadSolutionState extends Equatable {
  const UploadSolutionState({
    this.solution = Solution.empty,
    this.solutionStatus = SolutionStatus.unknown,
    this.fileStatus = FileStatus.unknown,
    this.uploadSolutionProgress = UploadSolutionProgress.unknown,
  });

  final Solution solution;
  final SolutionStatus solutionStatus;
  final FileStatus fileStatus;
  final UploadSolutionProgress uploadSolutionProgress;

  @override
  List<Object> get props => [
        solution,
        solutionStatus,
        fileStatus,
        uploadSolutionProgress,
      ];

  UploadSolutionState copyWith({
    Solution solution,
    SolutionStatus solutionStatus,
    FileStatus fileStatus,
    UploadSolutionProgress uploadSolutionProgress,
  }) {
    return UploadSolutionState(
      solution: solution ?? this.solution,
      solutionStatus: solutionStatus ?? this.solutionStatus,
      fileStatus: fileStatus ?? this.fileStatus,
      uploadSolutionProgress:
          uploadSolutionProgress ?? this.uploadSolutionProgress,
    );
  }
}
