import 'package:equatable/equatable.dart';

class Comment extends Equatable {
  const Comment({
    this.uid,
    this.photoURL,
    this.username,
    this.commentId,
    this.postId,
    this.title,
    this.gifURL,
    this.dateCreated,
  });

  final String uid;
  final String photoURL;
  final String username;
  final String commentId;
  final String postId;
  final String title;
  final String gifURL;
  final String dateCreated;

  @override
  List<Object> get props => [
        uid,
        photoURL,
        username,
        commentId,
        postId,
        title,
        gifURL,
        dateCreated,
      ];

  static const empty = Comment(
    uid: '',
    photoURL: '',
    username: '',
    commentId: '',
    postId: '',
    title: '',
    gifURL: '',
    dateCreated: '',
  );

  Comment copyWith({
    String uid,
    String photoURL,
    String username,
    String commentId,
    String postId,
    String title,
    String gifURL,
    String dateCreated,
  }) {
    return Comment(
      uid: uid ?? this.uid,
      photoURL: photoURL ?? this.photoURL,
      username: username ?? this.username,
      commentId: commentId ?? this.commentId,
      postId: postId ?? this.postId,
      title: title ?? this.title,
      gifURL: gifURL ?? this.gifURL,
      dateCreated: dateCreated ?? this.dateCreated,
    );
  }

  bool get isNotEmpty => title.isNotEmpty || gifURL.isNotEmpty;
}
