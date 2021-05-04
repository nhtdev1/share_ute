import 'package:equatable/equatable.dart';

class Room extends Equatable {
  const Room({
    this.roomId,
    this.friendId,
    this.friendPhotoUrl,
    this.friendName,
  });
  final String roomId;
  final String friendId;
  final String friendPhotoUrl;
  final String friendName;

  @override
  List<Object> get props => [
        roomId,
        friendId,
        friendPhotoUrl,
        friendName,
      ];

  static const empty = Room(
    roomId: '',
    friendId: '',
    friendPhotoUrl: '',
    friendName: '',
  );

  Room copyWith({
    String roomId,
    String friendId,
    String friendPhotoUrl,
    String friendName,
  }) {
    return Room(
      roomId: roomId ?? this.roomId,
      friendId: friendId ?? this.friendId,
      friendPhotoUrl: friendPhotoUrl ?? this.friendPhotoUrl,
      friendName: friendName ?? this.friendName,
    );
  }
}
