import 'package:equatable/equatable.dart';

class Report extends Equatable {
  const Report({
    this.id,
    this.uid,
    this.postID,
    this.problem,
    this.dateReported,
  });

  final String id;
  final String uid;
  final String postID;
  final String problem;
  final String dateReported;

  @override
  List<Object> get props => [
        id,
        uid,
        postID,
        problem,
        dateReported,
      ];

  static const empty = Report(
    id: '',
    uid: '',
    postID: '',
    problem: '',
    dateReported: '',
  );

  Report copyWith({
    String id,
    String uid,
    String postID,
    String problem,
    String dateReported,
  }) {
    return Report(
      id: id ?? this.id,
      uid: uid ?? this.uid,
      postID: postID ?? this.postID,
      problem: problem ?? this.problem,
      dateReported: dateReported ?? this.dateReported,
    );
  }
}
