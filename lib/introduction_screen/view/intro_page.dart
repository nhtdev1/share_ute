import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_ute/introduction_screen/introduction_screen.dart';
import 'package:user_repository/user_repository.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({Key key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const IntroPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: BlocProvider(
          create: (_) => IntroductionCubit(
            firestoreUserRepository: context.read<FirestoreUserRepository>(),
          ),
          child: IntroForm(),
        ),
      ),
    );
  }
}
