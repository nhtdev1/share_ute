import 'package:equatable/equatable.dart';

class Message extends Equatable {
  const Message({
    this.uid,
    this.photoURL,
    this.username,
    this.messageId,
    this.roomId,
    this.title,
    this.gifURL,
    this.timestamp,
  });

  final String uid;
  final String photoURL;
  final String username;
  final String messageId;
  final String roomId;
  final String title;
  final String gifURL;
  final String timestamp;

  @override
  List<Object> get props => [
        uid,
        photoURL,
        username,
        messageId,
        roomId,
        title,
        gifURL,
        timestamp,
      ];

  static const empty = Message(
    uid: '',
    photoURL: '',
    username: '',
    messageId: '',
    roomId: '',
    title: '',
    gifURL: '',
    timestamp: '',
  );

  Message copyWith({
    String uid,
    String photoURL,
    String username,
    String messageId,
    String roomId,
    String title,
    String gifURL,
    String timestamp,
  }) {
    return Message(
      uid: uid ?? this.uid,
      photoURL: photoURL ?? this.photoURL,
      username: username ?? this.username,
      messageId: messageId ?? this.messageId,
      roomId: roomId ?? this.roomId,
      title: title ?? this.title,
      gifURL: gifURL ?? this.gifURL,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  bool get isNotEmpty => title.isNotEmpty || gifURL.isNotEmpty;
}
