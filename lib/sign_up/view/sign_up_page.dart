import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_ute/sign_up/sign_up.dart';

// The SignUpPage is just responsible for creating and providing an instance of
// the SignUpCubit to the SignUpForm
class SignUpPage extends StatelessWidget {
  const SignUpPage({Key key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const SignUpPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.grey, //change your color here
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8),
        child: BlocProvider<SignUpCubit>(
          create: (_) => SignUpCubit(
            context.repository<AuthenticationRepository>(),
          ),
          child: SignUpForm(),
        ),
      ),
    );
  }
}
