import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:share_ute/firestore_user/firestore_user.dart';
import 'package:user_repository/user_repository.dart';
import 'package:meta/meta.dart';

part 'introduction_state.dart';

class IntroductionCubit extends Cubit<IntroductionState> {
  IntroductionCubit({@required FirestoreUserRepository firestoreUserRepository})
      : assert(firestoreUserRepository != null),
        _firestoreUserRepository = firestoreUserRepository,
        super(const IntroductionState());

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


  Future<void> done({
    String year,
    String faculty,
    String major,
    List<String> hobbies,
  }) async {
    await _firestoreUserRepository.createUser(
      year: year ?? state.year.value,
      faculty: faculty ?? state.faculty.value,
      major: major ?? state.major.value,
      hobbies: hobbies ?? state.hobbies.value,
    );
  }
}
