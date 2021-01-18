import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:post_repository/post_repository.dart';
import 'models/models.dart';

class CommentRepository {
  CommentRepository({
    FirebaseFirestore firebaseFirestore,
    firebase_auth.FirebaseAuth firebaseAuth,
  })  : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance,
        _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance;

  final FirebaseFirestore _firebaseFirestore;
  final firebase_auth.FirebaseAuth _firebaseAuth;

  Stream<List<Comment>> comment(String postId) {
    return _firebaseFirestore
        .collection('posts/$postId/comments')
        .orderBy('dateCreated', descending: false)
        .snapshots()
        .map((snapshot) {
      final List<Comment> comments = [];
      snapshot.docs.forEach((doc) {
        comments.add(Comment(
          postId: postId,
          commentId: doc.id,
          uid: doc['uid'],
          photoURL: doc['photoURL'],
          username: doc['username'],
          title: doc['title'],
          gifURL: doc['gifURL'],
          dateCreated: doc['dateCreated'],
        ));
      });

      return comments;
    });
  }

  Future<String> createComment({
    Comment comment,
  }) async {
    try {
      final result = await _firebaseFirestore
          .collection('posts/${comment.postId}/comments')
          .add({
        'uid': _firebaseAuth.currentUser.uid,
        'photoURL': comment.photoURL,
        'title': comment.title,
        'username': comment.username,
        'gifURL': comment.gifURL,
        'dateCreated': comment.dateCreated,
      });
      return result.id;
    } on Exception {
      return "";
    }
  }

  Future<void> setComment(
    Comment comment,
  ) {
    WriteBatch batch = FirebaseFirestore.instance.batch();

    final document =
        _firebaseFirestore.collection('posts/${comment.postId}/comments').doc();

    batch.set(document, {
      'uid': comment.uid,
      'commentId': comment.commentId,
      'postId': comment.postId,
      'title': comment.title,
      'dateCreated': comment.dateCreated,
    });

    return batch.commit();
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
          postID: doc['postID'],
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
      'postID': emotion.postID,
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
            'postID': emotion.postID,
            'uid': emotion.uid,
            'id': emotion.id,
          });
        }
      });

      return batch.commit();
    });
  }
}
