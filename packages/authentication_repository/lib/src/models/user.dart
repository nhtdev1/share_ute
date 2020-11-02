import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

// The User model will describe a user in context of authentication domain
class User extends Equatable {
  const User({
    @required this.email,
    @required this.id,
    @required this.name,
    @required this.photo,
    @required this.isNewUser,
  })  : assert(email != null),
        assert(id != null);

  // The current user's email address
  final String email;

  // The current user's id
  final String id;

  // The current user's name (display name)
  final String name;

  // Url for the current user's photo
  final String photo;

  final bool isNewUser;

  // Empty user which represents an unauthenticated user
  static const empty =
      User(email: '', id: '', name: null, photo: null, isNewUser: false);

  @override
  // TODO: implement props
  List<Object> get props => [email, id, name, photo, isNewUser];
}
