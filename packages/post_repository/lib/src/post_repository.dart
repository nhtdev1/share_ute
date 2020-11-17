import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

class PostRepository {
  PostRepository({
    FirebaseFirestore firebaseFirestore,
    firebase_auth.FirebaseAuth firebaseAuth,
  })  : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance,
        _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance;

  final FirebaseFirestore _firebaseFirestore;
  final firebase_auth.FirebaseAuth _firebaseAuth;

  Future<void> createPost({
    String postAccessModifiers,
    String postTitle,
    String fileName,
    String fileExtension,
    String fileSize,
    String fileURL,
    List<String> postTags,
  }) {
    final dateCreated = DateTime.now().toString();
    return _firebaseFirestore
        .collection('posts')
        .add({
      'uid': _firebaseAuth.currentUser.uid,
      'postAccessModifiers': postAccessModifiers ?? '',
      'postTitle': postTitle ?? '',
      'fileName': fileName ?? '',
      'fileExtension': fileExtension ?? '',
      'fileSize': fileSize ?? '',
      'fileURL': fileURL ?? '',
      'postTags': postTags ?? '',
      'dateCreated': dateCreated,
    })
        .then((value) => print('Create post on firestore successfully!'))
        .catchError((onError) => print('Failed to create post: $onError'));
    // return _firebaseFirestore
    //     .collection('posts')
    //     .doc(_firebaseAuth.currentUser.uid +
    //         '_' +
    //         dateCreated.millisecond.toString())
    //     .set({
    //       'uid': _firebaseAuth.currentUser.uid,
    //       'postAccessModifiers': postAccessModifiers ?? '',
    //       'postTitle': postTitle ?? '',
    //       'fileName': fileName ?? '',
    //       'fileExtension': fileExtension ?? '',
    //       'fileSize': fileSize ?? '',
    //       'fileURL': fileURL ?? '',
    //       'postTags': postTags ?? '',
    //       'dateCreated': dateCreated.toString(),
    //     })
    //     .then((value) => print('Create post on firestore successfully!'))
    //     .catchError((onError) => print('Failed to create post: $onError'));
  }
}
