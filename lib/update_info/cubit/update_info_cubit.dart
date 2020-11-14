import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:share_ute/firestore_user/firestore_user.dart';
import 'package:share_ute/firestore_user/models/birthday.dart';
import 'package:user_repository/user_repository.dart';

part 'update_info_state.dart';

class UpdateInfoCubit extends Cubit<UpdateInfoState> {
  UpdateInfoCubit(this._firestoreUserRepository, this._firestoreUserBloc)
      : assert(_firestoreUserRepository != null),
        super(UpdateInfoState(
          name: Name.dirty(_firestoreUserBloc.state.user.name),
          birthday: Birthday(date: _firestoreUserBloc.state.user.birthday),
          mobile: Mobile.dirty(_firestoreUserBloc.state.user.phone),
        ));



  final FirestoreUserRepository _firestoreUserRepository;
  final FirestoreUserBloc _firestoreUserBloc;

  void nameChanged(String value) {
    final name = Name.dirty(value);
    emit(state.copyWith(
      name: name,
      status: Formz.validate([name, state.mobile]),
    ));
  }

  void birthdayChanged(String value) {
    final birthday = Birthday(date: value);
    emit(state.copyWith(
      birthday: birthday,
      status: Formz.validate([state.name, state.mobile]),
    ));
  }

  void mobileChanged(String value) {
    final mobile = Mobile.dirty(value);
    emit(state.copyWith(
      mobile: mobile,
      status: Formz.validate([state.name, mobile]),
    ));
  }

  Future<void> updateFirestoreUser() async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      await _firestoreUserRepository.updateUser(
          name: state.name.value,
          birthday: state.birthday.date,
          mobile: state.mobile.value);
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on Exception {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }
}
