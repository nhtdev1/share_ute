part of 'update_avatar_cubit.dart';

enum UpdateAvatarStatus {
  running,
  success,
  error,
  unknown,
  cropped,
  cleared,
  picked,
}


class UpdateAvatarState extends Equatable {
  const UpdateAvatarState({
    this.avatar = const Avatar.none(),
    this.status = UpdateAvatarStatus.unknown,
  });

  final Avatar avatar;
  final UpdateAvatarStatus status;

  @override
  // TODO: implement props
  List<Object> get props => [avatar, status];

  UpdateAvatarState copyWith({
    Avatar avatar,
    UpdateAvatarStatus status,
  }) {
    return UpdateAvatarState(
      avatar: avatar ?? this.avatar,
      status: status ?? this.status,
    );
  }
}
