part of 'firestore_user_bloc.dart';

abstract class FirestoreUserEvent extends Equatable {
  const FirestoreUserEvent();

  @override
  // TODO: implement props
  List<Object> get props => [];
}


class FirestoreUserUpdated extends FirestoreUserEvent {
  const FirestoreUserUpdated(this.user);

  final FirestoreUser user;

  @override
  // TODO: implement props
  List<Object> get props => [user];
}

class FirestoreUserChanged extends FirestoreUserEvent {
  const FirestoreUserChanged(this.user);

  final FirestoreUser user;

  @override
  // TODO: implement props
  List<Object> get props => [user];
}


