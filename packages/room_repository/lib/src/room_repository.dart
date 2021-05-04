import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

import 'models/models.dart';

class RoomRepository {
  RoomRepository({
    FirebaseFirestore firebaseFirestore,
    firebase_auth.FirebaseAuth firebaseAuth,
  })  : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance,
        _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance;

  final FirebaseFirestore _firebaseFirestore;
  final firebase_auth.FirebaseAuth _firebaseAuth;

  Stream<List<Room>> get rooms {
    return _firebaseFirestore.collection('rooms').snapshots().map((snapshot) {
      final List<Room> rooms = [];
      snapshot.docs.forEach((doc) {
        if (doc.id.contains(_firebaseAuth.currentUser.uid)) {
          rooms.add(Room(
            roomId: doc.id,
            friendId: doc['friendId'],
            friendPhotoUrl: doc['friendPhotoUrl'],
            friendName: doc['friendName'],
          ));
        }
      });
      return rooms;
    });
  }

  Future<bool> createRoom({Room room}) async {
    try {
      await _firebaseFirestore
          .collection('rooms')
          .doc("${_firebaseAuth.currentUser.uid}-${room.friendId}")
          .set({
        "roomId": _firebaseAuth.currentUser.uid + room.friendId,
        "friendId": room.friendId,
        "friendPhotoUrl": room.friendPhotoUrl,
        "friendName": room.friendName,
      });
      return true;
    } on Exception {
      return false;
    }
  }

  Future<bool> checkRoomById(String friendId) async {
    String roomId = "${_firebaseAuth.currentUser.uid}-$friendId";
    final snapshot =
        await _firebaseFirestore.collection('rooms').doc(roomId).get();
    if (snapshot.exists) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<Room>> getAllRooms() async {
    final snapshot = await _firebaseFirestore.collection('rooms').get();

    return snapshot.docs
        .where((element) => element.id.contains(_firebaseAuth.currentUser.uid))
        .map(
          (data) => Room(
            roomId: data.data()['roomId'],
            friendId: data.data()['friendId'],
            friendPhotoUrl: data.data()['friendPhotoUrl'],
            friendName: data.data()['friendName'],
          ),
        )
        .toList();
  }
}
