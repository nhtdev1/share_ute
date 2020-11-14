part of 'update_bio_cubit.dart';

class UpdateBioState extends Equatable {
  const UpdateBioState({
    this.year = const Year.pure(),
    this.faculty = const Faculty.pure(),
    this.major = const Major.pure(),
    this.hobbies = const Hobbies.pure(),
    this.status = FormzStatus.pure,
  });

  final Year year;
  final Faculty faculty;
  final Major major;
  final Hobbies hobbies;
  final FormzStatus status;

  @override
  // TODO: implement props
  List<Object> get props => [year, faculty, major, hobbies,status];

  UpdateBioState copyWith({
    Year year,
    Faculty faculty,
    Major major,
    Hobbies hobbies,
    FormzStatus status,
  }) {
    return UpdateBioState(
      year: year ?? this.year,
      faculty: faculty ?? this.faculty,
      major: major ?? this.major,
      hobbies: hobbies ?? this.hobbies,
      status: status??this.status,
    );
  }
}
