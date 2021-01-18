part of 'upgrade_cubit.dart';

enum UpgradeStatus {
  unknown,
  pickedOneMonth,
  pickedThreeMonths,
  pickedOneYear,
}

enum UpgradeProgress {
  unknown,
  upgradeInProgress,
  upgradeSuccess,
  upgradeFailure,
}

class UpgradeState extends Equatable {
  const UpgradeState({
    this.user,
    this.status = UpgradeStatus.unknown,
    this.upgradeProgress = UpgradeProgress.unknown,
  });
  final User user;
  final UpgradeStatus status;
  final UpgradeProgress upgradeProgress;

  UpgradeState copyWith({
    User user,
    UpgradeStatus status,
    UpgradeProgress upgradeProgress,
  }) {
    return UpgradeState(
      user: user ?? this.user,
      status: status ?? this.status,
      upgradeProgress: upgradeProgress ?? this.upgradeProgress,
    );
  }

  @override
  List<Object> get props => [user, status, upgradeProgress];
}
