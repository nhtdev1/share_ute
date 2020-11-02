import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_ute/introduction_screen/introduction_screen.dart';


class IntroPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => IntroPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: BlocProvider(
          create: (_) => IntroductionCubit(),
          child: IntroForm(),
        ),
      ),
    );
  }
}

