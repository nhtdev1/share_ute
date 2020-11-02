import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_ute/login/login.dart';

// The LoginPage is responsible for creating and providing an instance of
// LoginCubit to the LoginForm
class LoginPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => LoginPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocProvider(
          create: (_) => LoginCubit(
            context.repository<AuthenticationRepository>(),
          ),
          child: LoginForm(),
        ),
      ),
    );
  }
}
