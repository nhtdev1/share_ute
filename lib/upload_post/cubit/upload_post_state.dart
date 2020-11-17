part of 'upload_post_cubit.dart';

enum UploadPostStatus {
  running,
  success,
  error,
  unknown,
  cleared,
  pickedOverFileSize,
  pickedAcceptableFileSize,
}

class UploadPostState extends Equatable {
  const UploadPostState({
    this.post = const Post(),
    this.postStatus = UploadPostStatus.unknown,
    this.optional = const Optional(),
    this.solutionFileStatus = UploadPostStatus.unknown,
  });

  final Post post;
  final UploadPostStatus postStatus;

  final Optional optional;
  final UploadPostStatus solutionFileStatus;

  @override
  // TODO: implement props
  List<Object> get props => [
        post,
        postStatus,
        optional,
        solutionFileStatus,
      ];

  UploadPostState copyWith({
    Post post,
    UploadPostStatus postStatus,
    Optional optional,
    UploadPostStatus solutionFileStatus,
  }) {
    return UploadPostState(
      post: post ?? this.post,
      postStatus: postStatus ?? this.postStatus,
      optional: optional ?? this.optional,
      solutionFileStatus: solutionFileStatus ?? this.solutionFileStatus,
    );
  }
}
