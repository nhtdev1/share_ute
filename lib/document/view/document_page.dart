import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post_repository/post_repository.dart';
import 'package:share_ute/authentication/authentication.dart';
import 'package:share_ute/document/document.dart';
import 'package:share_ute/emotion/bloc/emotion_bloc.dart';
import 'package:share_ute/notification/notification.dart';
import 'package:share_ute/solutions/solutions.dart';
import 'package:solution_repository/solution_repository.dart';

import 'package:http/http.dart' as http;

class DocumentPage extends StatelessWidget {
  const DocumentPage({Key key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (context) => const DocumentPage());
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          lazy: false,
          create: (context) => DocumentCubit(
            notificationCubit: context.read<NotificationCubit>(),
          ),
        ),
        BlocProvider(
          lazy: false,
          create: (context) => EmotionBloc(
            postRepository: context.read<PostRepository>(),
            notificationCubit: context.read<NotificationCubit>(),
            authenticationBloc: context.read<AuthenticationBloc>(),
          ),
        ),
        BlocProvider(
          create: (context) => SolutionBloc(
            solutionRepository: SolutionRepository(),
            notificationCubit: context.read<NotificationCubit>(),
            httpClient: http.Client(),
          )..add(SolutionFetched()),
        ),
      ],
      child: DocumentForm(),
    );
  }
}
