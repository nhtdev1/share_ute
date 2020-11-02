// import 'package:flutter/material.dart';
// import 'package:share_ute/home/home.dart';
//
// class App extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return AppView();
//   }
// }
//
// class AppView extends StatefulWidget {
//   @override
//   _AppViewState createState() => _AppViewState();
// }
//
// class _AppViewState extends State<AppView> {
//   final _navigatorKey = GlobalKey<NavigatorState>();
//
//   NavigatorState get _navigator => _navigatorKey.currentState;
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       navigatorKey: _navigatorKey,
//       initialRoute: '/',
//       routes: {
//         '/': (context) => HomePage(),
//       },
//     );
//   }
// }

import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_ute/authentication/authentication.dart';
import 'package:share_ute/home/view/home_page2.dart';
import 'package:share_ute/introduction_screen/introduction_screen.dart';
import 'package:share_ute/login/login.dart';
import 'package:share_ute/splash/splash.dart';
import 'package:share_ute/views/introduction_page.dart';

import 'home/home.dart';

// app.dart will provide an instance of the AuthenticationRepository to the
// application via RepositoryProvider and also creates and provides an instance
// of AuthenticationBloc. Then AppView consumes the AuthenticationBloc and
// handles updating the current route based on the AuthenticationState
class App extends StatelessWidget {
  const App({
    Key key,
    @required this.authenticationRepository,
  })  : assert(authenticationRepository != null),
        super(key: key);

  final AuthenticationRepository authenticationRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: authenticationRepository,
      child: BlocProvider(
        create: (_) => AuthenticationBloc(
          authenticationRepository: authenticationRepository,
        ),
        child: AppView(),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      builder: (context, child) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            switch (state.status) {
              case AuthenticationStatus.authenticated:
                state.user.isNewUser
                    ? _navigator.pushAndRemoveUntil(
                        IntroPage.route(),
                        (route) => false,
                      )
                    : _navigator.pushAndRemoveUntil(
                        HomePage.route(),
                        (route) => false,
                      );
                break;
              case AuthenticationStatus.unauthenticated:
                _navigator.pushAndRemoveUntil(
                  LoginPage.route(),
                  (route) => false,
                );
                break;
              default:
                break;
            }
          },
          child: child,
        );
      },
      onGenerateRoute: (_) => SplashPage.route(),
    );
  }
}
