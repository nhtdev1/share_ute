part of 'introduction_cubit.dart';

class IntroductionState extends Equatable {
  const IntroductionState({
    this.selectedYear = const SelectedYear(currentSelected: ""),
    this.selectedFaculty = const SelectedFaculty(currentSelected: ""),
    this.selectedMajor = const SelectedMajor(currentSelected: ""),
    this.selectedHobbies = const SelectedHobbies(currentSelected: []),
  });

  final SelectedYear selectedYear;
  final SelectedFaculty selectedFaculty;
  final SelectedMajor selectedMajor;
  final SelectedHobbies selectedHobbies;

  @override
  // TODO: implement props
  List<Object> get props =>
      [selectedYear, selectedFaculty, selectedMajor, selectedHobbies];

  IntroductionState copyWith({
    String selectedYear,
    String selectedFaculty,
    String selectedMajor,
    List<String> selectedHobbies,
  }) {
    return IntroductionState(
      selectedYear:
          SelectedYear(currentSelected: selectedYear) ?? this.selectedYear,
      selectedFaculty: SelectedFaculty(currentSelected: selectedFaculty) ??
          this.selectedFaculty,
      selectedMajor:
          SelectedMajor(currentSelected: selectedMajor) ?? this.selectedMajor,
      selectedHobbies: SelectedHobbies(currentSelected: selectedHobbies) ??
          this.selectedHobbies,
    );
  }
}
