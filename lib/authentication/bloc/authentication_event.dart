part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  // ignore: todo
  // TODO: implement props
  List<Object> get props => [];
}

// AuthenticationUserChanged which notifies the bloc that the current user has
// changed
class AuthenticationUserChanged extends AuthenticationEvent {
  const AuthenticationUserChanged(this.user);

  final User user;

  @override
  // ignore: todo
  // TODO: implement props
  List<Object> get props => [user];
}

// AuthenticationLogoutRequested which notifies the bloc that the current user
// has requested to be logged out
class AuthenticationLogoutRequested extends AuthenticationEvent {}
