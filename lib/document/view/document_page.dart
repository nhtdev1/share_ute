import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post_repository/post_repository.dart';
import 'package:share_ute/document/document.dart';
import 'package:share_ute/notification/notification.dart';

class DocumentPage extends StatelessWidget {
  const DocumentPage({Key key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (context) => const DocumentPage());
  }


  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (_) => PostRepository(),
      child: BlocProvider(
        create: (context) => DocumentCubit(
          notificationCubit: context.read<NotificationCubit>(),
        ),
        child: DocumentForm(),
      ),
    );
  }
}
