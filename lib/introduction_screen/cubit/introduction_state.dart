part of 'introduction_cubit.dart';

// class IntroductionState extends Equatable {
//   const IntroductionState({
//     this.year = const Year(selectedValue: ""),
//     this.faculty = const Faculty(selectedValue: ""),
//     this.major = const Major(selectedValue: ""),
//     this.hobbies = const Hobbies(selectedValues: []),
//   });
//
//   final Year year;
//   final Faculty faculty;
//   final Major major;
//   final Hobbies hobbies;
//
//   IntroductionState copyWith({
//     String year,
//     String faculty,
//     String major,
//     List<String> hobbies,
//   }) {
//     return IntroductionState(
//       year: year != null ? Year(selectedValue: year) : this.year,
//       faculty: faculty != null ? Faculty(selectedValue: faculty) : this.faculty,
//       major: major != null ? Major(selectedValue: major) : this.major,
//       hobbies:
//           hobbies != null ? Hobbies(selectedValues: hobbies) : this.hobbies,
//     );
//   }
//
//   @override
//   // TODO: implement props
//   List<Object> get props => [year, faculty, major, hobbies];
// }
class IntroductionState extends Equatable {
  const IntroductionState({
    this.year = const Year.pure(),
    this.faculty = const Faculty.pure(),
    this.major = const Major.pure(),
    this.hobbies = const Hobbies.pure(),
  });

  final Year year;
  final Faculty faculty;
  final Major major;
  final Hobbies hobbies;

  IntroductionState copyWith({
    Year year,
    Faculty faculty,
    Major major,
    Hobbies hobbies,
  }) {
    return IntroductionState(
      year: year ?? this.year,
      faculty: faculty ?? this.faculty,
      major: major ?? this.major,
      hobbies: hobbies ?? this.hobbies,
    );
  }

  @override
  // TODO: implement props
  List<Object> get props => [year, faculty, major, hobbies];
}
