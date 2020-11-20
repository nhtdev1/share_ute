import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
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
            user: User(
              year: firestoreUserBloc.state.user.year,
              faculty: firestoreUserBloc.state.user.faculty,
              major: firestoreUserBloc.state.user.major,
              hobbies: firestoreUserBloc.state.user.hobbies,
            ),
          ),
        );

  final FirestoreUserRepository _firestoreUserRepository;

  void yearChanged(String value) {
    emit(
      state.copyWith(
        user: state.user.copyWith(
          year: value,
        ),
        bioStatus: BioStatus.yearChanged,
      ),
    );
  }

  void facultyChanged(String value) {
    emit(
      state.copyWith(
        user: state.user.copyWith(
          faculty: value,
        ),
        bioStatus: BioStatus.facultyChanged,
      ),
    );
  }

  void majorChanged(String value) {
    emit(
      state.copyWith(
        user: state.user.copyWith(
          major: value,
        ),
        bioStatus: BioStatus.majorChanged,
      ),
    );
  }

  void hobbiesChanged(List<String> value) {
    emit(
      state.copyWith(
        user: state.user.copyWith(
          hobbies: value,
        ),
        bioStatus: BioStatus.hobbiesChanged,
      ),
    );
  }

  Future<void> updateBioUser() async {
    emit(
        state.copyWith(updateProgress: UpdateBioProgress.submissionInProgress));
    final result = await _firestoreUserRepository.updateUserBio(
      user: state.user,
    );
    result
        ? emit(
            state.copyWith(updateProgress: UpdateBioProgress.submissionSuccess))
        : emit(state.copyWith(
            updateProgress: UpdateBioProgress.submissionFailure));
    emit(state.copyWith(
      bioStatus: BioStatus.unchanged,
      updateProgress: UpdateBioProgress.unknown,
    ));
  }
}
