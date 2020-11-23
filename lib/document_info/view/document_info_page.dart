import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post_repository/post_repository.dart';
import 'package:share_ute/document_info/bloc/document_info_bloc.dart';
import 'package:share_ute/document_info/document_info.dart';
import 'package:share_ute/notification/notification.dart';

class DocumentInfoPage extends StatelessWidget {

  const DocumentInfoPage({Key key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (context) => const DocumentInfoPage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DocumentInfoBloc(
        postRepository: context.read<PostRepository>(),
         notificationCubit: context.read<NotificationCubit>()
      ),
      child: DocumentInfoForm(),
    );
  }
}
