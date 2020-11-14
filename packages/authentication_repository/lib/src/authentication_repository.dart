import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';

import 'models/models.dart';

// Thrown during the sign up process if a failure occurs
class SignUpFailure implements Exception {}

// Thrown during the login process if a failure occurs
class LogInWithEmailAndPasswordFailure implements Exception {}

// Thrown during the sign in with google process if a failure occurs
class LogInWithGoogleFailure implements Exception {}

// Thrown during the logout process if a failure occurs
class LogOutFailure implements Exception {}

// The AuthenticationRepository is responsible for abstracting the underlying
// implementation of how a user is authentication as well as how a user is fetched
class AuthenticationRepository {
  AuthenticationRepository({
    firebase_auth.FirebaseAuth firebaseAuth,
    GoogleSignIn googleSignIn,
  })  : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn.standard();

  final firebase_auth.FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;


  // Stream of [User] which emit the current user when the authentication state
  // changes. Emits [User.empty] if the user is not authenticated
  Stream<User> get user {
    return _firebaseAuth.authStateChanges().map((user) {
      if (user == null) {
        return User.empty;
      } else {
        return user.toUser();
      }
    });
  }

  // Create a new user with the provided [email] and [password]
  // Thrown a [SignUpFailure] if an exception occurs
  Future<void> signUp({
    @required String email,
    @required String password,
  }) async {
    assert(email != null && password != null);
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on Exception {
      throw SignUpFailure();
    }
  }

  // Starts the Sign In with Google Flow
  // Thrown a [LogInWithGoogleFailure] if an exception occurs
  Future<void> logInWithGoogle() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      final googleAuth = await googleUser.authentication;
      final credential = firebase_auth.GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await _firebaseAuth.signInWithCredential(credential);
    } on Exception {
      throw LogInWithGoogleFailure();
    }
  }

  // Signs in with the provided [email] and [password]
  // Thrown a [LogInWithEmailAndPasswordFailure] if an exception occurs
  Future<void> logInWithEmailAndPassword({
    @required String email,
    @required String password,
  }) async {
    assert(email != null && password != null);
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on Exception {
      throw LogInWithEmailAndPasswordFailure();
    }
  }

  // Signs out the current user which will emit
  // [User.empty] from the [user] Stream
  // Throws a [LogOutFailure] if an exception occurs
  Future<void> logOut() async {
    try {
      await Future.wait([_firebaseAuth.signOut(), _googleSignIn.signOut()]);
    } on Exception {
      throw LogOutFailure();
    }
  }
}

extension on firebase_auth.User {
  User toUser({bool isNewUser}) {
    return User(
        id: uid,
        email: email,
        name: displayName,
        photo: photoURL,
        isNewUser: isNewUser);
  }
}
