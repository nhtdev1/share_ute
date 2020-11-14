import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_ute/firestore_user/firestore_user.dart';
import 'package:share_ute/home/view/view.dart';
import 'package:share_ute/introduction_screen/introduction_screen.dart';
import 'package:share_ute/splash/splash.dart';
import 'package:user_repository/user_repository.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (context) => const HomePage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FirestoreUserBloc>(
      create: (_) => FirestoreUserBloc(
        firestoreUserRepository:
        context.read<FirestoreUserRepository>(),
      ),
      child: HomeView(),
    );
  }
}

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      builder: (context, child) {
        return BlocListener<FirestoreUserBloc, FirestoreUserState>(
          listener: (context, state) {
            switch (state.status) {
              case FirestoreUserStatus.authenticatedWithNewUser:
                _navigator.pushAndRemoveUntil(
                  IntroPage.route(),
                  (route) => false,
                );
                break;
              case FirestoreUserStatus.authenticatedWithOldUser:
                _navigator.pushAndRemoveUntil(
                  HomeForm.route(),
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
