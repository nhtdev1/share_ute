part of 'chat_cubit.dart';

enum ChatStatus {
  unknown,
  fetchingInProgress,
  fetchingSuccess,
  fetchingFailure,
}

class ChatState extends Equatable {
  ChatState({
    this.messages = const [],
    this.status = ChatStatus.unknown,
  });

  final List<Message> messages;
  final ChatStatus status;
  @override
  List<Object> get props => [messages, status];

  ChatState copyWith({
    List<Message> messages,
    ChatStatus status,
  }) {
    return ChatState(
      messages: messages ?? this.messages,
      status: status ?? this.status,
    );
  }
}
