import 'package:equatable/equatable.dart';

// class Emotion extends Equatable {
//   const Emotion({
//     this.id,
//     this.uid,
//     this.postID,
//     this.type,
//   });

//   final String id;
//   final String uid;
//   final String postID;
//   final String type;

//   @override
//   List<Object> get props => [id, uid, postID, type];

//   static const empty = Emotion(id: '', uid: '', postID: '', type: '');
// }

class Emotion extends Equatable {
  const Emotion({
    this.postID,
    this.uid,
    this.id,
  });

  final String postID;
  final String uid;
  final String id;

  @override
  List<Object> get props => [postID, uid, id];

  static const empty = Emotion(postID: '', uid: '', id: '');
}
