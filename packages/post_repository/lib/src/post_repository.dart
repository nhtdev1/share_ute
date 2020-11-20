import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:post_repository/src/models/models.dart';

class PostRepository {
  PostRepository({
    FirebaseFirestore firebaseFirestore,
    firebase_auth.FirebaseAuth firebaseAuth,
  })  : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance,
        _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance;

  final FirebaseFirestore _firebaseFirestore;
  final firebase_auth.FirebaseAuth _firebaseAuth;

  Future<bool> createPost({
    Post post,
    String originalFileURL,
  }) async {
    final dateCreated = DateTime.now().toString();
    try {
      await _firebaseFirestore.collection('posts').add({
        'uid': _firebaseAuth.currentUser.uid,
        'public': post.public,
        'postTitle': post.postTitle,
        'like': post.like,
        'disLike': post.dislike,
        'originalFileURL': originalFileURL,
        'fileName': post.originalFile.fileName,
        'fileExtension': post.originalFile.fileExtension,
        'fileSize': post.originalFile.fileSize,
        'year': post.postYear,
        'tags': post.postTags,
        'semester': post.semester,
        'credit': post.credit,
        'major': post.major,
        'lecturer': post.lecturer,
        'dateCreated': dateCreated,
      });
      return true;
    } on Exception {
      return false;
    }
  }
}
