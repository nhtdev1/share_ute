import 'package:equatable/equatable.dart';
import 'package:file_picker_repository/file_picker_repository.dart';

class Solution extends Equatable {
  const Solution({
    this.uid,
    this.solutionID,
    this.postID,
    this.title,
    this.like,
    this.dislike,
    this.solutionFile,
    this.dateCreated,
  });

  final String uid;
  final String solutionID;
  final String postID;
  final String title;
  final List<String> like;
  final List<String> dislike;
  final File solutionFile;
  final String dateCreated;

  @override
  List<Object> get props => [
        uid,
        solutionID,
        postID,
        title,
        like,
        dislike,
        solutionFile,
        dateCreated,
      ];

  static const empty = Solution(
    uid: '',
    solutionID: '',
    postID: '',
    title: '',
    like: [],
    dislike: [],
    solutionFile: File.empty,
    dateCreated: '',
  );

  Solution copyWith({
    String uid,
    String solutionID,
    String postID,
    String title,
    List<String> like,
    List<String> dislike,
    File solutionFile,
    String dateCreated,
  }) {
    return Solution(
      uid: uid ?? this.uid,
      solutionID: solutionID ?? this.solutionID,
      postID: postID ?? this.postID,
      title: title ?? this.title,
      like: like ?? this.like,
      dislike: dislike ?? this.dislike,
      solutionFile: solutionFile ?? this.solutionFile,
      dateCreated: dateCreated ?? this.dateCreated,
    );
  }

  bool get isNotEmpty => title.isNotEmpty && solutionFile.isNotEmpty;
}
