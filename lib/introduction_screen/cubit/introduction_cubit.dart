import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:share_ute/introduction_screen/models/models.dart';

part 'introduction_state.dart';

class IntroductionCubit extends Cubit<IntroductionState> {
  IntroductionCubit() : super(const IntroductionState());

  void yearChanged(String value) {
    emit(state.copyWith(
      selectedYear: value,
      selectedHobbies: state.selectedHobbies.currentSelected,
    ));
  }

  void facultyChanged(String value) {
    emit(state.copyWith(
      selectedFaculty: value,
    ));
  }

  void majorChanged(String value) {
    emit(state.copyWith(
      selectedMajor: value,
    ));
  }

  void hobbiesChanged(List<String> values) {
    emit(state.copyWith(
      selectedYear: state.selectedYear.currentSelected,
      selectedHobbies: values,
    ));
  }
}
