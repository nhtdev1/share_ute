part of 'update_avatar_cubit.dart';

enum AvatarStatus {
  unknown,
  cropped,
  croppedError,
  cleared,
  pickedOverSize,
  pickedAcceptableSize,
  pickedError,
}

enum UpdateAvatarProgress {
  unknown,
  submissionInProgress,
  submissionSuccess,
  submissionFailure,
}

class UpdateAvatarState extends Equatable {
  const UpdateAvatarState({
    this.file = File.empty,
    this.avatarStatus = AvatarStatus.unknown,
    this.updateAvatarProgress = UpdateAvatarProgress.unknown,
  });

  final File file;
  final AvatarStatus avatarStatus;
  final UpdateAvatarProgress updateAvatarProgress;

  @override
  List<Object> get props => [
        file,
        avatarStatus,
        updateAvatarProgress,
      ];

  UpdateAvatarState copyWith({
    File file,
    AvatarStatus avatarStatus,
    UpdateAvatarProgress updateAvatarProgress,
  }) {
    return UpdateAvatarState(
      file: file ?? this.file,
      avatarStatus: avatarStatus ?? this.avatarStatus,
      updateAvatarProgress: updateAvatarProgress ?? this.updateAvatarProgress,
    );
  }
}
