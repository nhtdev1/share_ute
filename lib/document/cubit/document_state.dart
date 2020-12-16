part of 'document_cubit.dart';

class DocumentState extends Equatable {
  const DocumentState({
    this.post = Post.empty,
  });

  final Post post;

  @override
  List<Object> get props => [post];

  DocumentState copyWith({
    Post post,
    User userOfPost,
  }) {
    return DocumentState(
      post: post ?? this.post,
    );
  }
}
