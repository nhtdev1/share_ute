part of 'update_bio_cubit.dart';

enum BioStatus {
  unknown,
  unchanged,
  yearChanged,
  facultyChanged,
  majorChanged,
  hobbiesChanged,
}

enum UpdateBioProgress {
  unknown,
  submissionInProgress,
  submissionSuccess,
  submissionFailure,
}

class UpdateBioState extends Equatable {
  const UpdateBioState({
    this.user = User.empty,
    this.bioStatus = BioStatus.unknown,
    this.updateProgress = UpdateBioProgress.unknown,
  });

  final User user;
  final BioStatus bioStatus;
  final UpdateBioProgress updateProgress;

  @override
  List<Object> get props => [user, bioStatus, updateProgress];

  UpdateBioState copyWith({
    User user,
    BioStatus bioStatus,
    UpdateBioProgress updateProgress,
  }) {
    return UpdateBioState(
      user: user ?? this.user,
      bioStatus: bioStatus ?? this.bioStatus,
      updateProgress: updateProgress ?? this.updateProgress,
    );
  }
}
