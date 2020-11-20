part of 'introduction_cubit.dart';

enum IntroductionStatus {
  unknown,
  submissionInProgress,
  submissionSuccess,
  submissionFailure,
}

class IntroductionState extends Equatable {
  const IntroductionState({
    this.user = User.empty,
    this.status = IntroductionStatus.unknown,
  });

  final User user;
  final IntroductionStatus status;

  IntroductionState copyWith({
    User user,
    IntroductionStatus status,
  }) {
    return IntroductionState(
      user: user ?? this.user,
      status: status ?? this.status,
    );
  }

  @override
  // TODO: implement props
  List<Object> get props => [user, status];
}
