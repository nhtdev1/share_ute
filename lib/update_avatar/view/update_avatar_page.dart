import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_ute/update_avatar/update_avatar.dart';
import 'package:storage_repository/storage_repository.dart';
import 'package:file_picker_repository/file_picker_repository.dart';
import 'package:user_repository/user_repository.dart';

class UpdateAvatarPage extends StatelessWidget {
  const UpdateAvatarPage({Key key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const UpdateAvatarPage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UpdateAvatarCubit>(
      create: (_) => UpdateAvatarCubit(
        filePickerRepository: FilePickerRepository(),
        storageRepository: StorageRepository(),
        firestoreUserRepository: context.read<FirestoreUserRepository>(),
      ),
      child: UpdateAvatarForm(),
    );
  }
}
