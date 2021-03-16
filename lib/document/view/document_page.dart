import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post_repository/post_repository.dart';
import 'package:share_ute/authentication/authentication.dart';
import 'package:share_ute/comment_notification/comment_notification.dart';
import 'package:share_ute/document/document.dart';
import 'package:share_ute/notification/notification.dart';
import 'package:share_ute/react_post/react_post.dart';
import 'package:share_ute/solution_notification/cubit/solution_notification_cubit.dart';
import 'package:share_ute/system_notification/system_notification.dart';
import 'package:solution_repository/solution_repository.dart';
import 'package:comment_repository/comment_repository.dart';

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
          create: (context) => ReactPostBloc(
            postRepository: context.read<PostRepository>(),
            notificationCubit: context.read<NotificationCubit>(),
            authenticationBloc: context.read<AuthenticationBloc>(),
          ),
        ),
        BlocProvider(
          lazy: false,
          create: (context) => SolutionNotificationCubit(
            solutionRepository: SolutionRepository(),
            notificationCubit: context.read<NotificationCubit>(),
          ),
        ),
        BlocProvider(
          lazy: false,
          create: (context) => CommentNotificationCubit(
            commentRepository: CommentRepository(),
            notificationCubit: context.read<NotificationCubit>(),
          ),
        ),
      ],
      child: WillPopScope(
        child: DocumentForm(),
        onWillPop: () => _onClickedBackButton(context),
      ),
    );
  }

  Future<bool> _onClickedBackButton(BuildContext context) {
    context.read<SystemNotificationCubit>().onClickedBackButton();
    return Future.value(false);
  }
}
