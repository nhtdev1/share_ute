import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker_repository/file_picker_repository.dart';
import 'package:post_repository/src/models/models.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

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
  Future<Post> createPost({
    Post post,
  }) async {
    try {
      final result = await _firebaseFirestore.collection('posts').add({
        'uid': _firebaseAuth.currentUser.uid,
        'photoURL': post.photoURL,
        'public': post.public,
        'postTitle': post.postTitle,
        'like': post.like,
        'disLike': post.dislike,
        'originalFileURL': post.originalFile.path,
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

      return post.copyWith(
        postID: result.id,
      );
    } on Exception {
      return Post.empty;
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
          like: List<String>.from(snapshot['like']),
          dislike: List<String>.from(snapshot['disLike']),
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
  }) async {
    try {
      final result = await _firebaseFirestore
          .collection('posts')
          .doc(post.postID)
          .collection('solutions')
          .add({
        'uid': _firebaseAuth.currentUser.uid,
        'photoURL': post.photoURL,
        'title': '',
        'solutionFileURL': post.solutionFile.path,
        'fileName': post.solutionFile.fileName,
        'fileExtension': post.solutionFile.fileExtension,
        'fileSize': post.solutionFile.fileSize,
        'dateCreated': post.dateCreated,
      });
      return result.id;
    } on Exception {
      return '';
    }
  }

  Future<bool> updateLike({
    String postID,
    List<String> like,
  }) async {
    try {
      await _firebaseFirestore.collection('posts').doc(postID).update({
        'like': like,
      });
      return true;
    } on Exception {
      return false;
    }
  }

  // Get all emotion document of a post in emotions collection
  Stream<List<Emotion>> emotions(
    String postID,
  ) {
    return _firebaseFirestore
        .collection('posts')
        .doc(postID)
        .collection('emotions')
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

  Future<String> addEmotion({
    Emotion emotion,
  }) async {
    try {
      final result = await _firebaseFirestore
          .collection('posts')
          .doc(emotion.postID)
          .collection('emotions')
          .add({
        'postID': emotion.postID,
        'uid': emotion.uid,
        'id': emotion.id,
      });
      return result.id;
    } on Exception {
      return "";
    }
  }

  Future<List<Emotion>> findEmotion(
    Emotion emotion,
  ) async {
    final snapshot = await _firebaseFirestore
        .collection('posts')
        .doc(emotion.postID)
        .collection('emotions')
        .where('uid', isEqualTo: emotion.uid)
        .get();

    final List<Emotion> emotions = [];
    snapshot.docs.forEach((doc) {
      emotions.add(Emotion(
        id: doc.id,
        postID: doc['postID'],
        uid: doc['uid'],
      ));
    });
    return emotions;
  }

  Future<void> removeEmotion(
    Emotion emotion,
  ) async {
    return _firebaseFirestore
        .collection('posts')
        .doc(emotion.postID)
        .collection('emotions')
        .doc(emotion.id)
        .delete()
        .then((value) =>
            print("Emotion:${emotion.id} of post:${emotion.postID} deleted"))
        .catchError((error) => print(
            "Error: $error. Failed to delete emotion:${emotion.id} of post:${emotion.postID}"));
  }

  Future<void> setEmotion(
    Emotion emotion,
  ) {
    WriteBatch batch = FirebaseFirestore.instance.batch();

    final document = _firebaseFirestore
        .collection('posts')
        .doc(emotion.postID)
        .collection('emotions')
        .doc();

    batch.set(document, {
      'postID': emotion.postID,
      'uid': emotion.uid,
      'id': emotion.id,
    });

    return batch.commit();
  }

  Future<void> deleteEmotion(
    Emotion emotion,
  ) {
    WriteBatch batch = FirebaseFirestore.instance.batch();

    return _firebaseFirestore
        .collection('posts')
        .doc(emotion.postID)
        .collection('emotions')
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
    Emotion emotion,
  ) {
    WriteBatch batch = FirebaseFirestore.instance.batch();

    return _firebaseFirestore
        .collection('posts')
        .doc(emotion.postID)
        .collection('emotions')
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
