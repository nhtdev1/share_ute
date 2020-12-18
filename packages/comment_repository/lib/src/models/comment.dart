import 'package:equatable/equatable.dart';

class Comment extends Equatable {
  const Comment({
    this.uid,
    this.photoURL,
    this.commentId,
    this.postId,
    this.title,
    this.dateCreated,
  });

  final String uid;
  final String photoURL;
  final String commentId;
  final String postId;
  final String title;
  final String dateCreated;

  @override
  List<Object> get props => [
        uid,
        photoURL,
        commentId,
        postId,
        title,
        dateCreated,
      ];

  static const empty = Comment(
    uid: '',
    photoURL: '',
    commentId: '',
    postId: '',
    title: '',
    dateCreated: '',
  );

  Comment copyWith({
    String uid,
    String photoURL,
    String commentId,
    String postId,
    String title,
    String dateCreated,
  }) {
    return Comment(
      uid: uid ?? this.uid,
      photoURL: photoURL ?? this.photoURL,
      commentId: commentId ?? this.commentId,
      postId: postId ?? this.postId,
      title: title ?? this.title,
      dateCreated: dateCreated ?? this.dateCreated,
    );
  }

  bool get isNotEmpty => title.isNotEmpty;
}
