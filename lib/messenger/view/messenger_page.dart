import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_ute/messenger/messenger.dart';
import 'package:share_ute/messenger/widgets/widgets.dart';
import 'package:user_repository/user_repository.dart';
import 'package:room_repository/room_repository.dart';

class MessengerPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute(builder: (_) => MessengerPage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MessengerCubit(
        userRepository: context.read<FirestoreUserRepository>(),
        roomRepository: RoomRepository(),
      )..getAllUsers(),
      child: Scaffold(
        appBar: AppBar(
          title: AppBarWidget(),
        ),
        body: MessengerForm(),
      ),
    );
  }
}
