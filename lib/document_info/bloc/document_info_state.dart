part of 'document_info_bloc.dart';

enum DocumentInfoStatus { like, unlike, dislike, unDislike, unknown }

class DocumentInfoState extends Equatable {
  const DocumentInfoState._({
    this.post = Post.empty,
    this.status = DocumentInfoStatus.unknown,
  });

  final Post post;

  final DocumentInfoStatus status;

  const DocumentInfoState.unknown():this._();

  const DocumentInfoState.postChanged(Post post):this._(
    post: post,
  );

  const DocumentInfoState.like(Post post):this._(
    status: DocumentInfoStatus.like,
    post: post,
  );

  const DocumentInfoState.unlike(Post post):this._(
    status: DocumentInfoStatus.unlike,
    post: post,
  );

  const DocumentInfoState.dislike(Post post):this._(
    status: DocumentInfoStatus.dislike,
    post: post,
  );

  const DocumentInfoState.unDislike(Post post):this._(
    status: DocumentInfoStatus.unDislike,
    post: post,
  );

  @override
  // TODO: implement props
  List<Object> get props => [post, status];
}
