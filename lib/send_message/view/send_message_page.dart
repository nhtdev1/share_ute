import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_ute/select_emoij_type/select_emoij_type.dart';
import 'package:share_ute/send_message/send_message.dart';

class SendMessagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SendMessageCubit>(
          create: (BuildContext context) =>
              SendMessageCubit()..onKeyboardListener(),
        ),
        BlocProvider<SelectEmoijTypeCubit>(
          create: (BuildContext context) => SelectEmoijTypeCubit(),
        ),
      ],
      child: SendMessageInput(),
    );
  }
}
