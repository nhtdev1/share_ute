part of 'upload_post_cubit.dart';

enum FileStatus {
  unknown,
  error,
  cleared,
  pickedWithOverSize,
  pickedWithAcceptableSize,
}

enum PostStatus {
  running,
  success,
  error,
  unknown,
}

class UploadPostState extends Equatable {
  const UploadPostState({
    this.post = Post.empty,
    this.postStatus = PostStatus.unknown,
    this.originalFileStatus = FileStatus.unknown,
    this.solutionFileStatus = FileStatus.unknown,
  });

  final Post post;
  final PostStatus postStatus;
  final FileStatus originalFileStatus;
  final FileStatus solutionFileStatus;

  @override
  // TODO: implement props
  List<Object> get props => [
        post,
        postStatus,
        originalFileStatus,
        solutionFileStatus,
      ];

  UploadPostState copyWith({
    Post post,
    PostStatus postStatus,
    FileStatus originalFileStatus,
    FileStatus solutionFileStatus,
  }) {
    return UploadPostState(
      post: post ?? this.post,
      postStatus: postStatus ?? this.postStatus,
      originalFileStatus: originalFileStatus ?? this.originalFileStatus,
      solutionFileStatus: solutionFileStatus ?? this.solutionFileStatus,
    );
  }
}
