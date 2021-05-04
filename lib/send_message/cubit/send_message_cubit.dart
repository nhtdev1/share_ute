import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'send_message_state.dart';

class SendMessageCubit extends Cubit<SendMessageState> {
  SendMessageCubit() : super(const SendMessageState());

  final TextEditingController textEditingController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  void onKeyboardListener() {
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        emit(state.copyWith(keyboardStatus: KeyboardStatus.showText));
      }
    });
  }

  void keyBoardChanged() {
    if (state.keyboardStatus != KeyboardStatus.showOptions) {
      if (focusNode.hasFocus) focusNode.unfocus();
      emit(state.copyWith(
        keyboardStatus: KeyboardStatus.showOptions,
        textKeyboardStatus: TextKeyboardStatus.unCursor,
      ));
    } else {
      focusNode.requestFocus();
    }
  }

  void textKeyboardFocused() {
    emit(state.copyWith(textKeyboardStatus: TextKeyboardStatus.hasCursor));
  }

  void textKeyboardUnfocused() {
    emit(state.copyWith(textKeyboardStatus: TextKeyboardStatus.unCursor));
  }

  void messageChanged(String value) {
    if (value.trim().isNotEmpty) {
      emit(state.copyWith(
        messsage: value.trim(),
        textKeyboardStatus: TextKeyboardStatus.hasCursor,
      ));
    } else {
      emit(state.copyWith(messsage: value.trim()));
    }
  }

  @override
  Future<void> close() {
    textEditingController.dispose();
    focusNode.dispose();
    return super.close();
  }
}
