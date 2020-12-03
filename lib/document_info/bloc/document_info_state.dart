part of 'document_info_bloc.dart';

enum DocumentInfoStatus {
  ownerLiked,
  ownerUnliked,
  ownerDisliked,
  ownerUndisliked,
  guestLiked,
  guestUnliked,
  guestDisliked,
  guestUndisliked,
  unknown,
  dataChanged,
}

class DocumentInfoState extends Equatable {
  const DocumentInfoState({
    this.post = Post.empty,
    this.userOfPost = User.empty,
    this.status = DocumentInfoStatus.unknown,
  });

  final Post post;
  final User userOfPost;
  final DocumentInfoStatus status;

  const DocumentInfoState.unknown() : this();

  const DocumentInfoState.postChanged({Post post, User user})
      : this(
          status: DocumentInfoStatus.dataChanged,
          post: post,
          userOfPost: user,
        );

  const DocumentInfoState.ownerLiked({Post post, User user})
      : this(
          status: DocumentInfoStatus.ownerLiked,
          post: post,
          userOfPost: user,
        );

  const DocumentInfoState.ownerUnliked({Post post, User user})
      : this(
          status: DocumentInfoStatus.ownerUnliked,
          post: post,
          userOfPost: user,
        );

  const DocumentInfoState.ownerDisliked({Post post, User user})
      : this(
          status: DocumentInfoStatus.ownerDisliked,
          post: post,
          userOfPost: user,
        );

  const DocumentInfoState.ownerUndisliked({Post post, User user})
      : this(
          status: DocumentInfoStatus.ownerUndisliked,
          post: post,
          userOfPost: user,
        );
  //
  const DocumentInfoState.guestLiked({Post post, User user})
      : this(
          status: DocumentInfoStatus.guestLiked,
          post: post,
          userOfPost: user,
        );

  const DocumentInfoState.guestUnliked({Post post, User user})
      : this(
          status: DocumentInfoStatus.guestUnliked,
          post: post,
          userOfPost: user,
        );

  const DocumentInfoState.guestDisliked({Post post, User user})
      : this(
          status: DocumentInfoStatus.guestDisliked,
          post: post,
          userOfPost: user,
        );

  const DocumentInfoState.guestUndisliked({Post post, User user})
      : this(
          status: DocumentInfoStatus.guestUndisliked,
          post: post,
          userOfPost: user,
        );

  @override
  List<Object> get props => [post, userOfPost, status];

  DocumentInfoState copyWith({
    Post post,
    User userOfPost,
    DocumentInfoStatus status,
  }) {
    return DocumentInfoState(
      post: post ?? this.post,
      userOfPost: userOfPost ?? this.post,
      status: status ?? this.status,
    );
  }
}
