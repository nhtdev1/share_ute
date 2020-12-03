import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker_repository/file_picker_repository.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:post_repository/post_repository.dart';
import 'models/models.dart';

class SolutionRepository {
  SolutionRepository({
    FirebaseFirestore firebaseFirestore,
    firebase_auth.FirebaseAuth firebaseAuth,
  })  : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance,
        _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance;

  final FirebaseFirestore _firebaseFirestore;
  final firebase_auth.FirebaseAuth _firebaseAuth;

  Stream<Solution> solution(String solutionID) {
    return _firebaseFirestore
        .collection('posts')
        .doc(solutionID)
        .collection('solutions')
        .doc(solutionID)
        .snapshots()
        .map((snapshot) {
      if (snapshot.exists) {
        return Solution(
          uid: snapshot['uid'],
          solutionID: snapshot['solutionID'],
          postID: snapshot['postID'],
          title: snapshot['title'],
          like: List<String>.from(snapshot['like']),
          dislike: List<String>.from(snapshot['disLike']),
          solutionFile: File(
            path: snapshot['solutionFileURL'],
            fileName: snapshot['fileName'],
            fileExtension: snapshot['fileExtension'],
            fileSize: snapshot['fileSize'],
          ),
          dateCreated: snapshot['dateCreated'],
        );
      }
      return Solution.empty;
    });
  }

  Future<String> createSolutionFile({
    Solution solution,
    String solutionFileURL,
  }) async {
    try {
      final result = await _firebaseFirestore
          .collection('posts')
          .doc(solution.postID)
          .collection('solutions')
          .add({
        'uid': _firebaseAuth.currentUser.uid,
        'title': solution.title,
        'like': solution.like,
        'disLike': solution.dislike,
        'solutionFileURL': solutionFileURL,
        'fileName': solution.solutionFile.fileName,
        'fileExtension': solution.solutionFile.fileExtension,
        'fileSize': solution.solutionFile.fileSize,
        'dateCreated': solution.dateCreated,
      });
      return result.id;
    } on Exception {
      return "";
    }
  }

  Future<void> setSolution(
    Solution solution,
  ) {
    WriteBatch batch = FirebaseFirestore.instance.batch();

    final document = _firebaseFirestore
        .collection('posts')
        .doc(solution.postID)
        .collection('solutions')
        .doc();

    batch.set(document, {
      'uid': solution.uid,
      'solutionID': solution.solutionID,
      'postID': solution.postID,
      'title': solution.title,
      'like': solution.like,
      'dislike': solution.dislike,
      'solutionFileURL': solution.solutionFile.path,
      'fileName': solution.solutionFile.fileName,
      'fileExtension': solution.solutionFile.fileSize,
      'fileSize': solution.solutionFile.fileSize,
      'dateCreated': solution.dateCreated,
    });

    return batch.commit();
  }

  Future<List<Solution>> getSolutions(Post post, int limit) async {
    final snapshot = await _firebaseFirestore
        .collection('posts')
        .doc(post.postID)
        .collection('solutions')
        .limit(limit)
        .get();

    return snapshot.docs
        .map((data) => Solution(
              uid: data.data()['uid'],
              solutionID: data.id,
              postID: post.postID,
              like: List<String>.from(data.data()['like']),
              dislike: List<String>.from(data.data()['disLike']),
              solutionFile: File(
                path: data.data()['solutionFileURL'],
                fileName: data.data()['fileName'],
                fileExtension: data.data()['fileExtension'],
                fileSize: data.data()['fileSize'],
              ),
              dateCreated: data.data()['dateCreated'],
            ))
        .toList();
  }
}
