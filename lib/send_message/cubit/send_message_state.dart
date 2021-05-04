part of 'send_message_cubit.dart';

enum KeyboardStatus {
  showOptions,
  showEmoji,
  showText,
  showGif,
  showEffets,
  showStickers,
  hidden,
}

enum TextKeyboardStatus {
  hasCursor,
  unCursor,
}

class SendMessageState extends Equatable {
  const SendMessageState({
    this.messsage = "",
    this.keyboardStatus = KeyboardStatus.hidden,
    this.textKeyboardStatus = TextKeyboardStatus.unCursor,
  });
  final String messsage;
  final KeyboardStatus keyboardStatus;
  final TextKeyboardStatus textKeyboardStatus;
  @override
  List<Object> get props => [
        messsage,
        keyboardStatus,
        textKeyboardStatus,
      ];
  SendMessageState copyWith({
    String messsage,
    KeyboardStatus keyboardStatus,
    TextKeyboardStatus textKeyboardStatus,
  }) {
    return SendMessageState(
      messsage: messsage ?? this.messsage,
      keyboardStatus: keyboardStatus ?? this.keyboardStatus,
      textKeyboardStatus: textKeyboardStatus ?? this.textKeyboardStatus,
    );
  }
}
