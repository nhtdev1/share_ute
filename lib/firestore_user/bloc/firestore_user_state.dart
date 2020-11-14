part of 'firestore_user_bloc.dart';

enum FirestoreUserStatus {
  authenticatedWithNewUser,
  authenticatedWithOldUser,
  updatedUser,
  unknown,
}

class FirestoreUserState extends Equatable {
  const FirestoreUserState._({
    this.user = FirestoreUser.empty,
    this.status = FirestoreUserStatus.unknown,
  });

  final FirestoreUser user;
  final FirestoreUserStatus status;

  const FirestoreUserState.unknown() : this._();

  const FirestoreUserState.updatedUser(FirestoreUser user)
      : this._(status: FirestoreUserStatus.updatedUser, user: user);

  const FirestoreUserState.authenticatedWithNewUser()
      : this._(status: FirestoreUserStatus.authenticatedWithNewUser);

  const FirestoreUserState.authenticatedWithOldUser(FirestoreUser user)
      : this._(
            status: FirestoreUserStatus.authenticatedWithOldUser, user: user);

  @override
  // TODO: implement props
  List<Object> get props => [user];
}