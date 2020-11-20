import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:share_ute/firestore_user/firestore_user.dart';
import 'package:share_ute/update_info/models/models.dart';
import 'package:user_repository/user_repository.dart';

part 'update_info_state.dart';

class UpdateInfoCubit extends Cubit<UpdateInfoState> {
  UpdateInfoCubit({
    FirestoreUserRepository firestoreUserRepository,
    FirestoreUserBloc firestoreUserBloc,
  })  : assert(firestoreUserRepository != null),
        _firestoreUserRepository = firestoreUserRepository,
        super(
          UpdateInfoState(
            name: Name.dirty(firestoreUserBloc.state.user.name),
            birthday: Birthday.dirty(firestoreUserBloc.state.user.birthday),
            phone: Phone.dirty(firestoreUserBloc.state.user.phone),
          ),
        );

  final FirestoreUserRepository _firestoreUserRepository;

  void nameChanged(String value) {
    final name = Name.dirty(value);
    emit(state.copyWith(
      name: name,
      status: Formz.validate([name, state.phone]),
      infoStatus: InfoStatus.changed,
    ));
  }

  void birthdayChanged(String value) {
    final birthday = Birthday.dirty(value);
    emit(state.copyWith(
      birthday: birthday,
      status: Formz.validate([state.name, state.phone]),
      infoStatus: InfoStatus.changed,
    ));
  }

  void phoneChanged(String value) {
    final phone = Phone.dirty(value);
    emit(state.copyWith(
      phone: phone,
      status: Formz.validate([state.name, phone]),
      infoStatus: InfoStatus.changed,
    ));
  }

  Future<void> updateUser() async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));

    final result = await _firestoreUserRepository.updateUserInfo(
      user: User(
        name: state.name.value,
        birthday: state.birthday.value,
        phone: state.phone.value,
      ),
    );
    result
        ? emit(state.copyWith(status: FormzStatus.submissionSuccess))
        : emit(state.copyWith(status: FormzStatus.submissionFailure));
    emit(state.copyWith(
      infoStatus: InfoStatus.unchanged,
      status: FormzStatus.pure,
    ));
  }
}
