import 'package:equatable/equatable.dart';
import 'package:share_ute/upload_post/models/models.dart';

class Optional extends Equatable {
  const Optional({
    this.solutionFile = const File(),
    this.year = const Year.pure(),
    this.major = const Major.pure(),
    this.semester = const Semester.pure(),
    this.credits = const Credits.pure(),
    this.lecturers = const Lecturers.pure(),
  });

  final File solutionFile;
  final Year year;
  final Major major;
  final Semester semester;
  final Credits credits;
  final Lecturers lecturers;

  @override
  // TODO: implement props
  List<Object> get props => [
        solutionFile,
        year,
        major,
        semester,
        credits,
        lecturers,
      ];

  Optional copyWith({
    File solutionFile,
    Year year,
    Major major,
    Semester semester,
    Credits credits,
    Lecturers lecturers,
  }) {
    return Optional(
      solutionFile: solutionFile ?? this.solutionFile,
      year: year ?? this.year,
      major: major ?? this.major,
      semester: semester ?? this.semester,
      credits: credits ?? this.credits,
      lecturers: lecturers ?? this.lecturers,
    );
  }
}
