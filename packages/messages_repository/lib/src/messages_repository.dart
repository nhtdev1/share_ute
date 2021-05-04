import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

import 'models/message.dart';
import 'models/models.dart';

class MessagesRepository {
  MessagesRepository({
    FirebaseFirestore firebaseFirestore,
    firebase_auth.FirebaseAuth firebaseAuth,
  })  : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance,
        _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance;

  final FirebaseFirestore _firebaseFirestore;
  final firebase_auth.FirebaseAuth _firebaseAuth;

  Stream<List<Message>> message(String roomId) {
    return _firebaseFirestore
        .collection('rooms/$roomId/messages')
        .orderBy('dateCreated', descending: false)
        .snapshots()
        .map((snapshot) {
      final List<Message> messages = [];
      snapshot.docs.forEach((doc) {
        messages.add(Message(
          roomId: roomId,
          messageId: doc.id,
          uid: doc['uid'],
          photoURL: doc['photoURL'],
          username: doc['username'],
          title: doc['title'],
          gifURL: doc['gifURL'],
          timestamp: doc['timestamp'],
        ));
      });
      return messages;
    });
  }
}
