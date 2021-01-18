part of 'upload_comment_cubit.dart';

enum CommentStatus {
  unknown,
  unchanged,
  changedWithText,
  changedWithEmoji,
  changedWithGif,
}

enum KeyboardStatus {
  showEmoji,
  showDefault,
  showGif,
  hidden,
}

class UploadCommentState extends Equatable {
  const UploadCommentState({
    this.comment = Comment.empty,
    this.status = CommentStatus.unknown,
    this.keyboardStatus = KeyboardStatus.hidden,
  });

  final Comment comment;
  final CommentStatus status;
  final KeyboardStatus keyboardStatus;
  @override
  List<Object> get props => [comment, status, keyboardStatus];

  UploadCommentState copyWith({
    Comment comment,
    CommentStatus status,
    KeyboardStatus keyboardStatus,
  }) {
    return UploadCommentState(
      comment: comment ?? this.comment,
      status: status ?? this.status,
      keyboardStatus: keyboardStatus ?? this.keyboardStatus,
    );
  }
}
