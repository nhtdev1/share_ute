import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:share_ute/authentication/authentication.dart';

class HomePage2 extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => HomePage2());
  }

  @override
  Widget build(BuildContext context) {
    final user = context.bloc<AuthenticationBloc>().state.user;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            key: const Key('homePage_logout_iconButton'),
            icon: const Icon(Icons.exit_to_app),
            onPressed: () => context
                .bloc<AuthenticationBloc>()
                .add(AuthenticationLogoutRequested()),
          )
        ],
      ),
      body: Align(
        alignment: const Alignment(0, -1 / 3),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 4.0,
            ),
            Text(user.email),
            const SizedBox(
              height: 4.0,
            ),
            Text(user.name ?? '')
          ],
        ),
      ),
    );
  }
}
