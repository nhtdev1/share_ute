import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

import 'models/user.dart' as firestore_user;

class FirestoreUserRepository {
  FirestoreUserRepository({
    FirebaseFirestore firebaseFirestore,
    firebase_auth.FirebaseAuth firebaseAuth,
  })  : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance,
        _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance;

  final FirebaseFirestore _firebaseFirestore;
  final firebase_auth.FirebaseAuth _firebaseAuth;

  Stream<firestore_user.User> get user {
    return _firebaseFirestore
        .collection('users')
        .doc(_firebaseAuth.currentUser.uid)
        .snapshots()
        .map((snapshot) {
      if (snapshot.exists) {
        return firestore_user.User(
          name: snapshot['displayName'],
          email: snapshot['email'],
          birthday: snapshot['birthday'],
          phone: snapshot['phone'],
          photo: snapshot['photoURL'],
          year: snapshot['year'],
          faculty: snapshot['faculty'],
          major: snapshot['major'],
          hobbies: List<String>.from(snapshot['hobbies']),
          postTotal: snapshot['postTotal'],
          pointTotal: snapshot['pointTotal'],
          dateCreated: snapshot['dateCreated'],
          disabled: snapshot['disabled'],
          premium: snapshot['premium'],
        );
      }

      return firestore_user.User.empty;
    });
  }

  Future<bool> updateUserInfo({
    firestore_user.User user,
  }) async {
    try {
      await _firebaseFirestore
          .collection('users')
          .doc(_firebaseAuth.currentUser.uid)
          .update({
        'displayName': user.name,
        'birthday': user.birthday,
        'phone': user.phone,
      });
      return true;
    } on Exception {
      return false;
    }
  }

  Future<bool> upgradePremium({
    firestore_user.User user,
  }) async {
    try {
      await _firebaseFirestore
          .collection('users')
          .doc(_firebaseAuth.currentUser.uid)
          .update({
        'premium': user.premium,
      });
      return true;
    } on Exception {
      return false;
    }
  }

  Future<bool> updateUserBio({
    firestore_user.User user,
  }) async {
    try {
      await _firebaseFirestore
          .collection('users')
          .doc(_firebaseAuth.currentUser.uid)
          .update({
        'year': user.year,
        'faculty': user.faculty,
        'major': user.major,
        'hobbies': user.hobbies,
      });
      return true;
    } on Exception {
      return false;
    }
  }

  Future<bool> createUser({
    firestore_user.User user,
  }) async {
    try {
      await _firebaseFirestore
          .collection('users')
          .doc(_firebaseAuth.currentUser.uid)
          .set({
        'email': _firebaseAuth.currentUser.email,
        'displayName': _firebaseAuth.currentUser.displayName,
        'photoURL': _firebaseAuth.currentUser.photoURL,
        'birthday': user.birthday,
        'phone': user.phone,
        'year': user.year,
        'faculty': user.faculty,
        'major': user.major,
        'hobbies': user.hobbies,
        'postTotal': user.postTotal,
        'pointTotal': user.pointTotal,
        'dateCreated': DateTime.now().toString(),
        'disabled': user.disabled,
        'premium': user.premium,
      });
      return true;
    } on Exception {
      return false;
    }
  }

  Future<bool> updateUserAvatar({
    String photoURL,
  }) async {
    try {
      await _firebaseFirestore
          .collection('users')
          .doc(_firebaseAuth.currentUser.uid)
          .update({
        'photoURL': photoURL,
      });
      return true;
    } on Exception {
      return false;
    }
  }

  Future<firestore_user.User> findUserById(String id) async {
    final snapshot = await _firebaseFirestore.collection('users').doc(id).get();
    if (snapshot.exists) {
      return firestore_user.User(
        email: snapshot.data()['email'],
        name: snapshot.data()['displayName'],
        birthday: snapshot.data()['birthday'],
        phone: snapshot.data()['photo'],
        photo: snapshot.data()['photoURL'],
        year: snapshot.data()['year'],
        faculty: snapshot.data()['faculty'],
        major: snapshot.data()['major'],
        hobbies: List<String>.from(snapshot['hobbies']),
        postTotal: snapshot['postTotal'],
        pointTotal: snapshot['pointTotal'],
        dateCreated: snapshot['dateCreated'],
        disabled: snapshot['disabled'],
        premium: snapshot['premium'],
      );
    } else {
      return firestore_user.User.empty;
    }
  }

  Future<List<firestore_user.User>> getAllUsers() async {
    final snapshot = await _firebaseFirestore.collection('users').get();
    return snapshot.docs
        .map(
          (data) => firestore_user.User(
            id: data.id,
            name: data.data()['displayName'],
            email: data.data()['email'],
            birthday: data.data()['birthday'],
            phone: data.data()['phone'],
            photo: data.data()['photoURL'],
            year: data.data()['year'],
            faculty: data.data()['faculty'],
            major: data.data()['major'],
            hobbies: List<String>.from(data.data()['hobbies']),
            postTotal: data.data()['postTotal'],
            pointTotal: data.data()['pointTotal'],
            dateCreated: data.data()['dateCreated'],
            disabled: data.data()['disabled'],
            premium: data.data()['premium'],
          ),
        )
        .toList();
  }
}
