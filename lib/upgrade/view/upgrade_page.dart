import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_ute/firestore_user/firestore_user.dart';
import 'package:share_ute/upgrade/upgrade.dart';
import 'package:payment_repository/payment_repository.dart';
import 'package:user_repository/user_repository.dart';

class UpgradePage extends StatelessWidget {
  const UpgradePage({Key key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const UpgradePage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UpgradeCubit>(
      create: (_) => UpgradeCubit(
        paymentRepository: PaymentRepository(),
        firestoreUserRepository: context.read<FirestoreUserRepository>(),
        firestoreUserBloc: context.read<FirestoreUserBloc>(),
      ),
      child: UpgradeForm(),
    );
  }
}
