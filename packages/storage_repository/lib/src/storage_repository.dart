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

  // Upload a file of post to fire storage
  Stream<TaskSnapshot> uploadDocument({
    Post post,
  }) {
    final dateCreated = DateTime.now().millisecondsSinceEpoch.toString();
    String filePath = 'posts/${_firebaseAuth.currentUser.uid}/'
        'original/${dateCreated}_${post.originalFile.fileName}';
    return _firebaseStorage
        .ref()
        .child(filePath)
        .putFile(File(post.originalFile.path))
        .snapshotEvents;
  }

  // Upload a file of post to fire storage
  Future<String> uploadFile({
    Post post,
  }) async {
    File file = File(post.solutionFile.path);
    final dateCreated = DateTime.now().millisecondsSinceEpoch.toString();
    String filePath = 'posts/${_firebaseAuth.currentUser.uid}/'
        'solution/${dateCreated}_${post.solutionFile.fileName}';
    try {
      final result = await _firebaseStorage
          .ref()
          .child(filePath)
          .putFile(file);
      return result.metadata.fullPath;
    } on FirebaseException catch (e) {
      return "";
    }
  }

  Future<String> getDownloadURL(String url) async {
    return _firebaseStorage.ref(url).getDownloadURL();
  }
}
