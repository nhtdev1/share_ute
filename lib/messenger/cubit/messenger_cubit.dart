import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';
import 'package:room_repository/room_repository.dart';

part 'messenger_state.dart';

class MessengerCubit extends Cubit<MessengerState> {
  MessengerCubit({
    this.userRepository,
    this.roomRepository,
  }) : super(MessengerState()) {
    _roomsSubscription = roomRepository.rooms.listen((rooms) {
      emit(state.copyWith(rooms: rooms));
    });
  }

  final FirestoreUserRepository userRepository;
  final RoomRepository roomRepository;

  StreamSubscription<List<Room>> _roomsSubscription;

  @override
  Future<void> close() {
    _roomsSubscription?.cancel();
    return super.close();
  }

  Future<void> init() async {
    final List<User> users = await userRepository.getAllUsers();
    emit(state.copyWith(users: users));
  }

  Future<Room> findRoomWith(User user) async {
    final rooms =
        state.rooms.where((room) => room.roomId.contains(user.id)).toList();
    if (rooms.isEmpty) {
      final Room room = Room(
        friendId: user.id,
        friendPhotoUrl: user.photo,
        friendName: user.name,
      );
      final String roomId = await roomRepository.createRoom(room: room);
      return room.copyWith(roomId: roomId);
    }
    return rooms[0];
  }

  void queryChanged(String value) {
    emit(state.copyWith(query: value.trim().toLowerCase()));
  }

  List<User> getUsersByQuery() {
    return state.users
        .where((u) =>
            u.name.toLowerCase().contains(state.query) ||
            u.email.toLowerCase().contains(state.query))
        .toList();
  }
}
