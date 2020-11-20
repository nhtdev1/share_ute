part of 'upload_post_cubit.dart';

enum PostStatus {
  unknown,
  unchanged,
  changed,
}

enum FileStatus {
  unknown,
  cleared,
  pickFileInProgress,
  pickedWithOverSize,
  pickedWithAcceptableSize,
  pickedError,
}

enum UploadPostProgress {
  unknown,
  submissionInProgress,
  submissionSuccess,
  submissionFailure,
}

class UploadPostState extends Equatable {
  const UploadPostState({
    this.post = Post.empty,
    this.postStatus = PostStatus.unknown,
    this.originalFileStatus = FileStatus.unknown,
    this.solutionFileStatus = FileStatus.unknown,
    this.uploadPostProgress = UploadPostProgress.unknown,
  });

  final Post post;
  final PostStatus postStatus;
  final FileStatus originalFileStatus;
  final FileStatus solutionFileStatus;
  final UploadPostProgress uploadPostProgress;

  @override
  // TODO: implement props
  List<Object> get props => [
        post,
        postStatus,
        originalFileStatus,
        solutionFileStatus,
        uploadPostProgress,
      ];

  UploadPostState copyWith({
    Post post,
    PostStatus postStatus,
    FileStatus originalFileStatus,
    FileStatus solutionFileStatus,
    UploadPostProgress uploadPostProgress,
  }) {
    return UploadPostState(
      post: post ?? this.post,
      postStatus: postStatus ?? this.postStatus,
      originalFileStatus: originalFileStatus ?? this.originalFileStatus,
      solutionFileStatus: solutionFileStatus ?? this.solutionFileStatus,
      uploadPostProgress: uploadPostProgress ?? this.uploadPostProgress,
    );
  }
}
