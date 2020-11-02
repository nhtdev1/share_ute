part of 'authentication_bloc.dart';

enum AuthenticationStatus { authenticated, unauthenticated, unknown }

// The AuthenticationState consists of an AuthenticationStatus and a User. Three
// named constructors are exposed: authenticated, unauthenticated, unknown to
// make it easier to work with
class AuthenticationState extends Equatable {
  const AuthenticationState._({
    this.status = AuthenticationStatus.unknown,
    this.user = User.empty,
  });

  final AuthenticationStatus status;
  final User user;

  const AuthenticationState.unknown() : this._();

  const AuthenticationState.authenticated(User user)
      : this._(status: AuthenticationStatus.authenticated, user: user);

  const AuthenticationState.unauthenticated()
      : this._(status: AuthenticationStatus.unauthenticated);

  @override
  // TODO: implement props
  List<Object> get props => [status, user];
}
