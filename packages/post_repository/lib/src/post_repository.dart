import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker_repository/file_picker_repository.dart';
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

  // Create a post to fire store, return id of post if create post successfully
  // else return none-id
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

  Stream<Post> post(String postID) {
    return _firebaseFirestore
        .collection('posts')
        .doc(postID)
        .snapshots()
        .map((snapshot) {
      if (snapshot.exists) {
        return Post(
          uid: snapshot['uid'],
          public: snapshot['public'],
          postTitle: snapshot['postTitle'],
          like: snapshot['like'],
          dislike: snapshot['disLike'],
          originalFile: File(
            path: snapshot['originalFileURL'],
            fileName: snapshot['fileName'],
            fileExtension: snapshot['fileExtension'],
            fileSize: snapshot['fileSize'],
          ),
          postYear: snapshot['year'],
          postTags: List<String>.from(snapshot['tags']),
          semester: snapshot['semester'],
          credit: snapshot['credit'],
          major: snapshot['major'],
          lecturer: snapshot['lecturer'],
          dateCreated: snapshot['dateCreated'],
        );
      }
      return Post.empty;
    });
  }

  Future<String> createSolutionFile({
    Post post,
    String solutionFileURL,
  }) async {
    try {
      final result = await _firebaseFirestore
          .collection('posts')
          .doc(post.postID)
          .collection('solutions')
          .add({
        'uid': _firebaseAuth.currentUser.uid,
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
