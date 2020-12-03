part of 'firestore_user_bloc.dart';

abstract class FirestoreUserEvent extends Equatable {
  const FirestoreUserEvent();

  @override
  // ignore: todo
  // TODO: implement props
  List<Object> get props => [];
}

class FirestoreUserUpdated extends FirestoreUserEvent {
  const FirestoreUserUpdated(this.user);

  final User user;

  @override
  List<Object> get props => [user];
}

class FirestoreUserChanged extends FirestoreUserEvent {
  const FirestoreUserChanged(this.user);

  final User user;

  @override
  List<Object> get props => [user];
}
