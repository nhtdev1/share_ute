// import 'package:authentication_repository/authentication_repository.dart';
// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:share_ute/app.dart';
// import 'package:share_ute/simple_bloc_observer.dart';
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   EquatableConfig.stringify = kDebugMode;
//   //Bloc.observer = SimpleBlocObserver();
//   runApp(App(
//     authenticationRepository: AuthenticationRepository(),
//   ));
// }
import 'package:flutter/material.dart';
import 'package:share_ute/introduction_screen/introduction_screen.dart';

void main() => runApp(MaterialApp(
  home: IntroPage(),
));
