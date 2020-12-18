part of 'document_comment_bloc.dart';

enum DocumentCommentStatus { initial, success, failure }

class DocumentCommentState extends Equatable {
  const DocumentCommentState({
    this.status = DocumentCommentStatus.initial,
    this.comments = const <Comment>[],
    this.hasReachedMax = false,
  });

  final DocumentCommentStatus status;
  final List<Comment> comments;
  final bool hasReachedMax;

  DocumentCommentState copyWith({
    DocumentCommentStatus status,
    List<Comment> comments,
    bool hasReachedMax,
  }) {
    return DocumentCommentState(
      status: status ?? this.status,
      comments: comments ?? this.comments,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [status, comments, hasReachedMax];
}
