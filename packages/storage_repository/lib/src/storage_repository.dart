import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:post_repository/post_repository.dart';

class StorageRepository {
  StorageRepository({
    FirebaseStorage firebaseStorage,
    firebase_auth.FirebaseAuth firebaseAuth,
  })  : _firebaseStorage = firebaseStorage ?? FirebaseStorage.instance,
        _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance;

  final FirebaseStorage _firebaseStorage;
  final firebase_auth.FirebaseAuth _firebaseAuth;

  Stream<TaskSnapshot> uploadImage({
    String path,
  }) {
    String filePath =
        'users/${_firebaseAuth.currentUser.uid}/avatars/${DateTime.now()}.png';
    return _firebaseStorage
        .ref()
        .child(filePath)
        .putFile(File(path))
        .snapshotEvents;
  }

  Stream<TaskSnapshot> uploadDocument({
    Post post,
  }) {
    String filePath = 'posts/${_firebaseAuth.currentUser.uid}/'
        'original/${DateTime.now()}_${post.originalFile.fileName}';
    return _firebaseStorage
        .ref()
        .child(filePath)
        .putFile(File(post.originalFile.path))
        .snapshotEvents;
  }

  Future<String> getDownloadURL(String url) async {
    return _firebaseStorage.ref(url).getDownloadURL();
  }
}
