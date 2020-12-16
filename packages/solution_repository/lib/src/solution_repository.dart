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

  Stream<List<Solution>> solution(String postId) {
    return _firebaseFirestore
        .collection('posts/$postId/solutions')
        .orderBy('dateCreated', descending: false)
        .snapshots()
        .map((snapshot) {
      final List<Solution> solutions = [];
      snapshot.docs.forEach((doc) {
        solutions.add(Solution(
          solutionID: doc.id,
          uid: doc['uid'],
          photoURL: doc['photoURL'],
          title: doc['title'],
          solutionFile: File(
            path: doc['solutionFileURL'],
            fileName: doc['fileName'],
            fileExtension: doc['fileExtension'],
            fileSize: doc['fileSize'],
          ),
          dateCreated: doc['dateCreated'],
        ));
      });

      return solutions;
    });
  }

  Future<String> createSolutionFile({
    Solution solution,
  }) async {
    try {
      final result = await _firebaseFirestore
          .collection('posts/${solution.postID}/solutions')
          .add({
        'uid': _firebaseAuth.currentUser.uid,
        'photoURL': solution.photoURL,
        'title': solution.title,
        'solutionFileURL': solution.solutionFile.path,
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
        .collection('posts/${solution.postID}/solutions')
        .doc();

    batch.set(document, {
      'uid': solution.uid,
      'solutionID': solution.solutionID,
      'postID': solution.postID,
      'title': solution.title,
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
        .collection('posts/${post.postID}/solutions')
        .limit(limit)
        .get();

    return snapshot.docs
        .map((data) => Solution(
              uid: data.data()['uid'],
              solutionID: data.id,
              postID: post.postID,
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

  Future<List<Solution>> getAllSolutions(Post post) async {
    final snapshot = await _firebaseFirestore
        .collection('posts/${post.postID}/solutions')
        .get();

    return snapshot.docs
        .map((data) => Solution(
              uid: data.data()['uid'],
              solutionID: data.id,
              postID: post.postID,
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

  Stream<List<Emotion>> emotions(
    String path,
  ) {
    return _firebaseFirestore
        .collection('posts/$path/emotions')
        .snapshots()
        .map((snapshot) {
      final List<Emotion> emotions = [];
      snapshot.docs.forEach((doc) {
        emotions.add(Emotion(
          uid: doc['uid'],
          id: doc['id'],
        ));
      });

      return emotions;
    });
  }

  Future<void> setEmotion(
    String path,
    Emotion emotion,
  ) {
    WriteBatch batch = FirebaseFirestore.instance.batch();

    final document =
        _firebaseFirestore.collection('posts/$path/emotions').doc();

    batch.set(document, {
      'uid': emotion.uid,
      'id': emotion.id,
    });

    return batch.commit();
  }

  Future<void> deleteEmotion(
    String path,
    Emotion emotion,
  ) {
    WriteBatch batch = FirebaseFirestore.instance.batch();

    return _firebaseFirestore
        .collection('posts/$path/emotions')
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((document) {
        if (emotion.uid == document['uid']) {
          batch.delete(document.reference);
        }
      });

      return batch.commit();
    });
  }

  Future<void> updateEmotion(
    String path,
    Emotion emotion,
  ) {
    WriteBatch batch = FirebaseFirestore.instance.batch();

    return _firebaseFirestore
        .collection('posts/$path/emotions')
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((document) {
        if (emotion.uid == document['uid']) {
          batch.update(document.reference, {
            'uid': emotion.uid,
            'id': emotion.id,
          });
        }
      });

      return batch.commit();
    });
  }
}
