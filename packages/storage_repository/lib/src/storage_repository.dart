import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:post_repository/post_repository.dart';
import 'package:solution_repository/solution_repository.dart';

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

  // Store a file of post to firestorage
  Stream<TaskSnapshot> uploadDocument({
    Post post,
  }) {
    File file = File(post.originalFile.path);
    String path = 'posts/${_firebaseAuth.currentUser.uid}/'
        'original/${post.dateCreated}_${post.originalFile.fileName}';
    return _firebaseStorage.ref().child(path).putFile(file).snapshotEvents;
  }

// Store a solution of post to fire storage
  Stream<TaskSnapshot> uploadSolution({
    Solution solution,
  }) {
    File file = File(solution.solutionFile.path);
    String path = 'posts/${_firebaseAuth.currentUser.uid}/'
        'solution/${solution.dateCreated}_${solution.solutionFile.fileName}';
    return _firebaseStorage.ref().child(path).putFile(file).snapshotEvents;
  }

  // Store a solution of post to fire storage
  Future<String> uploadFile({
    Post post,
  }) async {
    File file = File(post.solutionFile.path);
    String path = 'posts/${_firebaseAuth.currentUser.uid}/'
        'solution/${post.dateCreated}_${post.solutionFile.fileName}';
    try {
      final result = await _firebaseStorage.ref().child(path).putFile(file);
      return result.metadata.fullPath;
    } on Exception {
      return "";
    }
  }

  Future<String> getDownloadURL(String url) async {
    return _firebaseStorage.ref(url).getDownloadURL();
  }
}
