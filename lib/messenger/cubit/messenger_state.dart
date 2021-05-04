part of 'messenger_cubit.dart';

class MessengerState extends Equatable {
  const MessengerState({
    this.users = const [],
    this.filter = const [],
    this.rooms = const [],
    this.query = "",
  });

  final List<User> users;
  final List<User> filter;
  final List<Room> rooms;
  final String query;
  @override
  List<Object> get props => [
        users,
        filter,
        rooms,
        query,
      ];

  MessengerState copyWith({
    List<User> users,
    List<User> filter,
    List<Room> rooms,
    String query,
  }) {
    return MessengerState(
      users: users ?? this.users,
      filter: filter ?? this.filter,
      rooms: rooms ?? this.rooms,
      query: query ?? this.query,
    );
  }
}
