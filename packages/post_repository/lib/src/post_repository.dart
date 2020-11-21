import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:post_repository/src/models/models.dart';

class PostRepository {
  PostRepository({
    FirebaseFirestore firebaseFirestore,
    firebase_auth.FirebaseAuth firebaseAuth,
  })
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance,
        _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance;

  final FirebaseFirestore _firebaseFirestore;
  final firebase_auth.FirebaseAuth _firebaseAuth;

  Future<String> createPost({
    Post post,
    String originalFileURL,
  }) async {
    try {
      final result = await _firebaseFirestore.collection('posts').add({
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
        'dateCreated': post.dateCreated,
      });
      return result.id;
    } on Exception {
      return "";
    }
  }

  Future<String> createSolutionFile({
    String postID,
    Post post,
    String solutionFileURL,
  }) async {
    try {
      final result = await _firebaseFirestore.collection('posts')
          .doc(postID)
          .collection('solutions')
          .add({
      'uid': _firebaseAuth.currentUser.uid,
      'postID': postID,
      'title': '',
      'like': '0',
      'disLike': '0',
      'solutionFileURL': solutionFileURL,
      'fileName': post.solutionFile.fileName,
      'fileExtension': post.solutionFile.fileExtension,
      'fileSize': post.solutionFile.fileSize,
      'dateCreated': post.dateCreated,
      });
      return result.id;
    } on Exception {
      return "";
    }
  }
}
