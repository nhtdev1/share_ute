import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_ute/firestore_user/firestore_user.dart';
import 'package:share_ute/update_info/update_info.dart';
import 'package:user_repository/user_repository.dart';

class UpdateInfoPage extends StatelessWidget {
  const UpdateInfoPage({Key key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const UpdateInfoPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.grey, //change your color here
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: BlocProvider<UpdateInfoCubit>(
          create: (BuildContext context) => UpdateInfoCubit(
            firestoreUserRepository: context.read<FirestoreUserRepository>(),
            firestoreUserBloc: context.read<FirestoreUserBloc>(),
          ),
          child: UpdateInfoForm(),
        ),
      ),
    );
  }
}
