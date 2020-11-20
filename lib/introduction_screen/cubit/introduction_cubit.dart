import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';
import 'package:meta/meta.dart';

part 'introduction_state.dart';

class IntroductionCubit extends Cubit<IntroductionState> {
  IntroductionCubit({
    @required FirestoreUserRepository firestoreUserRepository,
  })  : assert(firestoreUserRepository != null),
        _firestoreUserRepository = firestoreUserRepository,
        super(const IntroductionState());

  final FirestoreUserRepository _firestoreUserRepository;

  void yearChanged(String value) {
    emit(
      state.copyWith(
        user: state.user.copyWith(
          year: value,
        ),
      ),
    );
  }

  void facultyChanged(String value) {
    emit(
      state.copyWith(
        user: state.user.copyWith(
          faculty: value,
        ),
      ),
    );
  }

  void majorChanged(String value) {
    emit(
      state.copyWith(
        user: state.user.copyWith(
          major: value,
        ),
      ),
    );
  }

  void hobbiesChanged(List<String> value) {
    emit(
      state.copyWith(
        user: state.user.copyWith(
          hobbies: value,
        ),
      ),
    );
  }

  Future<void> done({
    User user,
  }) async {
    emit(state.copyWith(status: IntroductionStatus.submissionInProgress));
    final result = await _firestoreUserRepository.createUser(
      user: user ?? state.user,
    );
    result
        ? emit(state.copyWith(status: IntroductionStatus.submissionSuccess))
        : emit(state.copyWith(status: IntroductionStatus.submissionFailure));
  }
}
