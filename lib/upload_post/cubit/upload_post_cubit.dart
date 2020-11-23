import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker_repository/file_picker_repository.dart';
import 'package:post_repository/post_repository.dart';
import 'package:share_ute/notification/notification.dart';
import 'package:storage_repository/storage_repository.dart';
import 'package:firebase_storage/firebase_storage.dart';

part 'upload_post_state.dart';

class UploadPostCubit extends Cubit<UploadPostState> {
  UploadPostCubit({
    FilePickerRepository filePickerRepository,
    StorageRepository storageRepository,
    PostRepository postRepository,
    NotificationCubit notificationCubit,
  })  : assert(filePickerRepository != null),
        _storageRepository = storageRepository,
        _filePickerRepository = filePickerRepository,
        _postRepository = postRepository,
        _notificationCubit = notificationCubit,
        super(const UploadPostState());

  final FilePickerRepository _filePickerRepository;
  final StorageRepository _storageRepository;
  final PostRepository _postRepository;

  //
  final NotificationCubit _notificationCubit;
  StreamSubscription<TaskSnapshot> _storageSubscription;

  @override
  Future<void> close() {
    _storageSubscription?.cancel();
    return super.close();
  }

  void accessModifiersChanged(String value) {
    emit(
      state.copyWith(
        post: state.post.copyWith(
          public: value == 'Công khai' ? 'true' : 'false',
        ),
        postStatus: PostStatus.changed,
      ),
    );
  }

  void postTitleChanged(String value) {
    emit(
      state.copyWith(
        post: state.post.copyWith(
          postTitle: value,
        ),
        postStatus: PostStatus.changed,
      ),
    );
  }

  void postTagsChanged(List<String> value) {
    emit(
      state.copyWith(
        post: state.post.copyWith(
          postTags: value,
        ),
        postStatus: PostStatus.changed,
      ),
    );
  }

  void yearChanged(String value) {
    emit(state.copyWith(
      post: state.post.copyWith(
        postYear: value,
      ),
      postStatus: PostStatus.changed,
    ));
  }

  void creditChanged(String value) {
    emit(state.copyWith(
      post: state.post.copyWith(
        credit: value,
      ),
      postStatus: PostStatus.changed,
    ));
  }

  void semesterChanged(String value) {
    emit(state.copyWith(
      post: state.post.copyWith(
        semester: value,
      ),
      postStatus: PostStatus.changed,
    ));
  }

  void majorChanged(String value) {
    emit(state.copyWith(
      post: state.post.copyWith(
        major: value,
      ),
      postStatus: PostStatus.changed,
    ));
  }

  void lecturerChanged(String value) {
    emit(state.copyWith(
      post: state.post.copyWith(
        lecturer: value,
      ),
      postStatus: PostStatus.changed,
    ));
  }

  Future<void> pickOriginalFile() async {
    emit(state.copyWith(
      originalFileStatus: FileStatus.pickFileInProgress,
    ));
    final file = await _filePickerRepository.pickFile();
    if (file.isNotEmpty) {
      if (int.parse(file.fileSize) > 25000) {
        emit(state.copyWith(
          originalFileStatus: FileStatus.pickedWithOverSize,
        ));
      } else {
        emit(state.copyWith(
          post: state.post.copyWith(
            originalFile: file,
          ),
          originalFileStatus: FileStatus.pickedWithAcceptableSize,
          postStatus: PostStatus.changed,
        ));
      }
      emit(state.copyWith(
        originalFileStatus: FileStatus.unknown,
      ));
    } else {
      emit(state.copyWith(
        originalFileStatus: FileStatus.pickedError,
      ));
    }
  }

  void clearOriginalFile() {
    emit(state.copyWith(
      post: state.post.copyWith(
        originalFile: File.empty,
      ),
      originalFileStatus: FileStatus.cleared,
      postStatus: PostStatus.changed,
    ));
  }

  Future<void> pickSolutionFile() async {
    emit(state.copyWith(
      solutionFileStatus: FileStatus.pickFileInProgress,
    ));
    final file = await _filePickerRepository.pickFile();
    if (file.isNotEmpty) {
      if (int.parse(file.fileSize) > 25000) {
        emit(state.copyWith(
          solutionFileStatus: FileStatus.pickedWithOverSize,
        ));
      } else {
        emit(state.copyWith(
          post: state.post.copyWith(
            solutionFile: file,
          ),
          solutionFileStatus: FileStatus.pickedWithAcceptableSize,
          postStatus: PostStatus.changed,
        ));
      }
      emit(state.copyWith(
        solutionFileStatus: FileStatus.unknown,
      ));
    } else {
      emit(state.copyWith(
        solutionFileStatus: FileStatus.pickedError,
      ));
    }
  }

  void clearSolutionFile() {
    emit(state.copyWith(
      post: state.post.copyWith(
        solutionFile: File.empty,
      ),
      solutionFileStatus: FileStatus.cleared,
      postStatus: PostStatus.changed,
    ));
  }

  void uploadPost() {
    _storageSubscription = _storageRepository
        .uploadDocument(
      post: state.post,
    )
        .listen((taskSnapshot) async {
      if (taskSnapshot != null) {
        if (taskSnapshot.state == TaskState.success) {
          // Get file's url in post stored in fire storage
          final originalFileURL = await _storageRepository
              .getDownloadURL(taskSnapshot.metadata.fullPath);

          final postID = await _postRepository.createPost(
            post: state.post.copyWith(
              dateCreated: taskSnapshot
                  .metadata.timeCreated.millisecondsSinceEpoch
                  .toString(),
            ),
            originalFileURL: originalFileURL,
          );

          // Create post successfully!
          if (postID.isNotEmpty) {
            if(state.post.solutionFile.isNotEmpty) {
              uploadSolutionFile(state.post.copyWith(
                postID: postID,
              ));
            }

            _notificationCubit.postCreated(state.post.copyWith(
              postID: postID,
            ));
            emit(state.copyWith(
              uploadPostProgress: UploadPostProgress.submissionSuccess,
            ));
          } else {
            emit(state.copyWith(
              uploadPostProgress: UploadPostProgress.submissionFailure,
            ));
          }
        } else if (taskSnapshot.state == TaskState.running) {
          emit(state.copyWith(
            uploadPostProgress: UploadPostProgress.submissionInProgress,
          ));
        } else if (taskSnapshot.state == TaskState.error) {
          emit(state.copyWith(
            uploadPostProgress: UploadPostProgress.submissionFailure,
          ));
        }
      } else {
        emit(state.copyWith(
          uploadPostProgress: UploadPostProgress.submissionFailure,
        ));
      }
    });
  }

  Future<void> uploadSolutionFile(Post post) async {
    final fullPath = await _storageRepository.uploadFile(post: post);
    if (fullPath.isNotEmpty) {
      final solutionFileURL = await _storageRepository.getDownloadURL(fullPath);
      await _postRepository.createSolutionFile(
        post: post,
        solutionFileURL: solutionFileURL,
      );
    }
  }
}
