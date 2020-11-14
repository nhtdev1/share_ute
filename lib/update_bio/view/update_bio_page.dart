import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_ute/firestore_user/firestore_user.dart';
import 'package:share_ute/update_bio/update_bio.dart';
import 'package:user_repository/user_repository.dart';

class UpdateBioPage extends StatelessWidget {
  const UpdateBioPage({Key key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const UpdateBioPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.grey,
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: BlocProvider<UpdateBioCubit>(
          create: (_) => UpdateBioCubit(
              firestoreUserRepository: context.read<FirestoreUserRepository>(),
              firestoreUserBloc: context.read<FirestoreUserBloc>(),
          ),
          child: UpdateBioForm(),
        ),
      ),
    );
  }
}
