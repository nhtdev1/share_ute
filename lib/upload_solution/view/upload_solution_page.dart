import 'package:file_picker_repository/file_picker_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_ute/firestore_user/firestore_user.dart';
import 'package:share_ute/notification/notification.dart';
import 'package:share_ute/upload_solution/upload_solution.dart';
import 'package:solution_repository/solution_repository.dart';
import 'package:storage_repository/storage_repository.dart';

class UploadSolutionPage extends StatelessWidget {
  const UploadSolutionPage({Key key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const UploadSolutionPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black54,
        ),
        backgroundColor: Colors.lightBlue,
        elevation: 0.0,
      ),
      body: BlocProvider<UploadSolutionCubit>(
        create: (_) => UploadSolutionCubit(
          filePickerRepository: FilePickerRepository(),
          storageRepository: StorageRepository(),
          solutionRepository: SolutionRepository(),
          firestoreUserBloc: context.read<FirestoreUserBloc>(),
          notificationCubit: context.read<NotificationCubit>(),
        ),
        child: UploadSolutionForm(),
      ),
    );
  }
}
