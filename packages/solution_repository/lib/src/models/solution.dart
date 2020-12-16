import 'package:equatable/equatable.dart';
import 'package:file_picker_repository/file_picker_repository.dart';

class Solution extends Equatable {
  const Solution({
    this.uid,
    this.photoURL,
    this.solutionID,
    this.postID,
    this.title,
    this.solutionFile,
    this.dateCreated,
  });

  final String uid;
  final String photoURL;
  final String solutionID;
  final String postID;
  final String title;
  final File solutionFile;
  final String dateCreated;

  @override
  List<Object> get props => [
        uid,
        photoURL,
        solutionID,
        postID,
        title,
        solutionFile,
        dateCreated,
      ];

  static const empty = Solution(
    uid: '',
    photoURL: '',
    solutionID: '',
    postID: '',
    title: '',
    solutionFile: File.empty,
    dateCreated: '',
  );

  Solution copyWith({
    String uid,
    String photoURL,
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
      photoURL: photoURL ?? this.photoURL,
      solutionID: solutionID ?? this.solutionID,
      postID: postID ?? this.postID,
      title: title ?? this.title,
      solutionFile: solutionFile ?? this.solutionFile,
      dateCreated: dateCreated ?? this.dateCreated,
    );
  }

  bool get isNotEmpty => title.isNotEmpty && solutionFile.isNotEmpty;
}
