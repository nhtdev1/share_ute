part of 'document_cubit.dart';

class DocumentState extends Equatable {
  const DocumentState({
    this.post = Post.empty,
    this.userOfPost = User.empty,
  });

  final Post post;
  final User userOfPost;

  @override
  List<Object> get props => [post, userOfPost];

  DocumentState copyWith({
    Post post,
    User userOfPost,
  }) {
    return DocumentState(
      post: post ?? this.post,
      userOfPost: userOfPost ?? this.userOfPost,
    );
  }
}
