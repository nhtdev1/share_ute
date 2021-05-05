part of 'messenger_cubit.dart';

class MessengerState extends Equatable {
  const MessengerState({
    this.users = const [],
    this.rooms = const [],
    this.query = "",
  });

  final List<User> users;
  final List<Room> rooms;
  final String query;
  @override
  List<Object> get props => [
        users,
        rooms,
        query,
      ];

  MessengerState copyWith({
    List<User> users,
    List<Room> rooms,
    String query,
  }) {
    return MessengerState(
      users: users ?? this.users,
      rooms: rooms ?? this.rooms,
      query: query ?? this.query,
    );
  }
}
