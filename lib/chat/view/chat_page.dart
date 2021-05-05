import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messages_repository/messages_repository.dart';
import 'package:room_repository/room_repository.dart';
import 'package:share_ute/chat/chat.dart';
import 'package:user_repository/user_repository.dart';

class ChatPage extends StatelessWidget {
  ChatPage({this.room});
  final Room room;

  static Route route({Room room}) {
    return MaterialPageRoute(builder: (_) => ChatPage(room: room));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (_) => ChatCubit(
        userRepository: context.read<FirestoreUserRepository>(),
        messagesRepository: MessagesRepository(),
        roomId: room.roomId,
      ),
      child: ChatForm(),
    );
  }
}
