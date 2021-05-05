import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:messages_repository/messages_repository.dart';
import 'package:user_repository/user_repository.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit({
    this.userRepository,
    this.messagesRepository,
    String roomId,
  }) : super(ChatState()) {
    print(roomId);
    _messagesSubscription = messagesRepository.message(roomId).listen(
      (messages) {
        print(messages);
        emit(state.copyWith(
          messages: messages,
          status: ChatStatus.fetchingSuccess,
        ));
      },
    );
  }

  final FirestoreUserRepository userRepository;
  final MessagesRepository messagesRepository;

  StreamSubscription<List<Message>> _messagesSubscription;

  @override
  Future<void> close() {
    _messagesSubscription?.cancel();
    return super.close();
  }
}
