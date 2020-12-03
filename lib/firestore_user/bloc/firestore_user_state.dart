part of 'firestore_user_bloc.dart';

enum FirestoreUserStatus {
  authenticatedWithNewUser,
  authenticatedWithOldUser,
  updatedUser,
  unknown,
}

class FirestoreUserState extends Equatable {
  const FirestoreUserState._({
    this.user = User.empty,
    this.status = FirestoreUserStatus.unknown,
  });

  final User user;
  final FirestoreUserStatus status;

  const FirestoreUserState.unknown() : this._();

  const FirestoreUserState.updatedUser(User user)
      : this._(status: FirestoreUserStatus.updatedUser, user: user);

  const FirestoreUserState.authenticatedWithNewUser()
      : this._(status: FirestoreUserStatus.authenticatedWithNewUser);

  const FirestoreUserState.authenticatedWithOldUser(User user)
      : this._(
            status: FirestoreUserStatus.authenticatedWithOldUser, user: user);

  @override
  List<Object> get props => [user, status];
}
