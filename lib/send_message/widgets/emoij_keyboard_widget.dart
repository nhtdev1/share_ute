import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_ute/select_emoij_type/select_emoij_type.dart';
import 'package:share_ute/send_message/send_message.dart';

class EmoijKeyboardWidget extends StatelessWidget {
  const EmoijKeyboardWidget({
    this.keyboardOptionsWidget,
    this.emoijListWidget,
    this.emoijTypeOptionsWidget,
  });

  final KeyboardOptionsWidget keyboardOptionsWidget;
  final EmoijListWidget emoijListWidget;
  final SelectEmoijTypePage emoijTypeOptionsWidget;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SendMessageCubit, SendMessageState>(
      builder: (context, state) {
        return Offstage(
          child: Container(
            height: 300,
            color: Colors.grey.withOpacity(0.1),
            child: Column(
              children: [
                keyboardOptionsWidget,
                emoijListWidget,
                emoijTypeOptionsWidget,
              ],
            ),
          ),
          offstage: !(state.keyboardStatus == KeyboardStatus.showOptions),
        );
      },
    );
  }
}
