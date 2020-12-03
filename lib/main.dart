import 'package:authentication_repository/authentication_repository.dart';
import 'package:user_repository/user_repository.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:share_ute/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  EquatableConfig.stringify = kDebugMode;
  //Bloc.observer = SimpleBlocObserver();
  runApp(
    App(
      authenticationRepository: AuthenticationRepository(),
      firestoreUserRepository: FirestoreUserRepository(),
    ),
  );
}
