import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

import 'models/models.dart';

class FirestoreUserRepository {
  FirestoreUserRepository({
    FirebaseFirestore firebaseFirestore,
    firebase_auth.FirebaseAuth firebaseAuth,
  })  : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance,
        _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance;

  final FirebaseFirestore _firebaseFirestore;
  final firebase_auth.FirebaseAuth _firebaseAuth;

  Stream<FirestoreUser> get user {
    return _firebaseFirestore
        .collection('users')
        .doc(_firebaseAuth.currentUser.uid)
        .snapshots()
        .map((snapshot) {
      if (snapshot.exists) {
        return FirestoreUser(
          name: snapshot['displayName'],
          email: snapshot['email'],
          birthday: snapshot['birthday'],
          phone: snapshot['mobile'],
          photo: snapshot['photoURL'],
          year: snapshot['year'],
          faculty: snapshot['faculty'],
          major: snapshot['major'],
          hobbies: List<String>.from(snapshot['hobbies']),
        );
      }

      return FirestoreUser.empty;
    });
  }

  Future<void> updateUser({
    String name,
    String birthday,
    String mobile,
  }) async {
    return _firebaseFirestore
        .collection('users')
        .doc(_firebaseAuth.currentUser.uid)
        .update({
          'displayName': name,
          'birthday': birthday,
          'mobile': mobile,
        })
        .then((value) => print('User info updated successfully!'))
        .catchError((onError) => print('Failed to update user info:$onError'));
  }

  Future<void> updateUserBio({
    String year,
    String faculty,
    String major,
    List<String> hobbies,
  }) {
    return _firebaseFirestore
        .collection('users')
        .doc(_firebaseAuth.currentUser.uid)
        .update({
          'year': year,
          'faculty': faculty,
          'major': major,
          'hobbies': hobbies,
        })
        .then((value) => print('User bio updated successfully!'))
        .catchError((onError) => print('Failed to update user bio: $onError'));
  }

  Future<void> createUser({
    String year,
    String faculty,
    String major,
    List<String> hobbies,
  }) {
    return _firebaseFirestore
        .collection('users')
        .doc(_firebaseAuth.currentUser.uid)
        .set({
          'email': _firebaseAuth.currentUser.email,
          'displayName': _firebaseAuth.currentUser.displayName,
          'photoURL': _firebaseAuth.currentUser.photoURL,
          'birthday': '',
          'mobile': '',
          'year': year ?? '',
          'faculty': faculty ?? '',
          'major': major ?? '',
          'hobbies': hobbies ?? '',
        })
        .then((value) => print('Create user on firestore successfully!'))
        .catchError((onError) => print('Failed to create user: $onError'));
  }

  Future<void> updateAvatarUrl({
    String url,
  }) async {
    return _firebaseFirestore
        .collection('users')
        .doc(_firebaseAuth.currentUser.uid)
        .update({
          'photoURL': url,
        })
        .then((value) => print('User avatar updated successfully!'))
        .catchError(
            (onError) => print('Failed to update user avatar:$onError'));
  }
}
