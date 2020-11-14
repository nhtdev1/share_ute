import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:meta/meta.dart';
import 'package:share_ute/firestore_user/firestore_user.dart';
import 'package:user_repository/user_repository.dart';

part 'update_bio_state.dart';

class UpdateBioCubit extends Cubit<UpdateBioState> {
  UpdateBioCubit({
    @required FirestoreUserRepository firestoreUserRepository,
    @required FirestoreUserBloc firestoreUserBloc,
  })  : assert(firestoreUserRepository != null),
        assert(firestoreUserBloc != null),
        _firestoreUserRepository = firestoreUserRepository,
        super(
          UpdateBioState(
            year: Year.dirty(firestoreUserBloc.state.user.year),
            faculty: Faculty.dirty(firestoreUserBloc.state.user.faculty),
            major: Major.dirty(firestoreUserBloc.state.user.major),
            hobbies: Hobbies.dirty(firestoreUserBloc.state.user.hobbies),
          ),
        );

  final FirestoreUserRepository _firestoreUserRepository;

  void yearChanged(String value) {
    final year = Year.dirty(value);
    emit(state.copyWith(
      year: year,
    ));
  }

  void facultyChanged(String value) {
    final faculty = Faculty.dirty(value);
    emit(state.copyWith(
      faculty: faculty,
    ));
  }

  void majorChanged(String value) {
    final major = Major.dirty(value);
    emit(state.copyWith(
      major: major,
    ));
  }

  void hobbiesChanged(List<String> value) {
    final hobbies = Hobbies.dirty(value);
    emit(state.copyWith(
      hobbies: hobbies,
    ));
  }

  Future<void> updateBioUser() async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      await _firestoreUserRepository.updateUserBio(
        year: state.year.value,
        faculty: state.faculty.value,
        major: state.major.value,
        hobbies: state.hobbies.value,
      );
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on Exception {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }
}
