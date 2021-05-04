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

  Future<void> getAllUsers() async {
    final List<User> users = await userRepository.getAllUsers();
    emit(state.copyWith(users: users));
  }

  Future<void> joinRoomWith(User user) async {
    bool isExistRoom = state.rooms
        .where((room) => room.roomId.contains(user.id))
        .toList()
        .isNotEmpty;
    if (!isExistRoom) {
      final Room room = Room(
        friendId: user.id,
        friendPhotoUrl: user.photo,
        friendName: user.name,
      );
      await roomRepository.createRoom(room: room);
    }
  }

  void queryChanged(String value) {
    final query = value.trim().toLowerCase();
    final filter = state.users
        .where((u) =>
            u.name.toLowerCase().contains(query) ||
            u.email.toLowerCase().contains(query))
        .toList();
    emit(state.copyWith(query: value, filter: filter));
  }
}
