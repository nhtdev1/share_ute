import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:payment_repository/payment_repository.dart';
import 'package:share_ute/firestore_user/firestore_user.dart';
import 'package:user_repository/user_repository.dart';

part 'upgrade_state.dart';

class UpgradeCubit extends Cubit<UpgradeState> {
  UpgradeCubit({
    PaymentRepository paymentRepository,
    FirestoreUserRepository firestoreUserRepository,
    FirestoreUserBloc firestoreUserBloc,
  })  : _paymentRepository = paymentRepository,
        _firestoreUserRepository = firestoreUserRepository,
        _firestoreUserBloc = firestoreUserBloc,
        super(UpgradeState(user: firestoreUserBloc.state.user)) {
    _userSubscription = _firestoreUserBloc.listen((userState) {
      emit(state.copyWith(user: userState.user));
    });
  }
  @override
  Future<void> close() {
    _userSubscription?.cancel();
    return super.close();
  }

  final PaymentRepository _paymentRepository;
  final FirestoreUserRepository _firestoreUserRepository;
  final FirestoreUserBloc _firestoreUserBloc;
  StreamSubscription<FirestoreUserState> _userSubscription;

  pickedOneMonthPackage() {
    if (state.status == UpgradeStatus.pickedOneMonth) {
      emit(state.copyWith(status: UpgradeStatus.unknown));
    } else {
      emit(state.copyWith(status: UpgradeStatus.pickedOneMonth));
    }
  }

  pickedThreeMonthsPackage() {
    if (state.status == UpgradeStatus.pickedThreeMonths) {
      emit(state.copyWith(status: UpgradeStatus.unknown));
    } else {
      emit(state.copyWith(status: UpgradeStatus.pickedThreeMonths));
    }
  }

  pickedOneYearPackage() {
    if (state.status == UpgradeStatus.pickedOneYear) {
      emit(state.copyWith(status: UpgradeStatus.unknown));
    } else {
      emit(state.copyWith(status: UpgradeStatus.pickedOneYear));
    }
  }

  Future<String> checkout() {
    final packageType = state.status == UpgradeStatus.pickedOneMonth
        ? '1'
        : state.status == UpgradeStatus.pickedThreeMonths
            ? '2'
            : '3';
    return _paymentRepository.createCheckout(packageType);
  }

  void upgradePremium() async {
    emit(state.copyWith(upgradeProgress: UpgradeProgress.upgradeInProgress));
    var days = 30;
    if (state.status == UpgradeStatus.pickedThreeMonths) days = 90;
    if (state.status == UpgradeStatus.pickedOneYear) days = 365;
    final date = DateTime.now();
    date.add(Duration(days: days));
    final DateFormat formatter = DateFormat('yyyy-MM-dd hh:mm:ss');
    final result = await _firestoreUserRepository.upgradePremium(
      user: state.user.copyWith(premium: formatter.format(date)),
    );
    if (result) {
      emit(state.copyWith(upgradeProgress: UpgradeProgress.upgradeSuccess));
    } else {
      emit(state.copyWith(upgradeProgress: UpgradeProgress.upgradeFailure));
    }
  }
}
