import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker_repository/file_picker_repository.dart';
import 'package:post_repository/post_repository.dart';
import 'package:storage_repository/storage_repository.dart';
import 'package:firebase_storage/firebase_storage.dart';

part 'upload_post_state.dart';

class UploadPostCubit extends Cubit<UploadPostState> {
  UploadPostCubit({
    FilePickerRepository filePickerRepository,
    StorageRepository storageRepository,
    PostRepository postRepository,
  })  : assert(filePickerRepository != null),
        _storageRepository = storageRepository,
        _filePickerRepository = filePickerRepository,
        _postRepository = postRepository,
        super(const UploadPostState());

  final FilePickerRepository _filePickerRepository;
  final StorageRepository _storageRepository;
  final PostRepository _postRepository;
  StreamSubscription<TaskSnapshot> _storageSubscription;

  @override
  Future<void> close() {
    _storageSubscription?.cancel();
    return super.close();
  }

  void accessModifiersChanged(String value) {
    emit(state.copyWith(
      post: state.post.copyWith(
        public: value == 'Công khai' ? 'true' : 'false',
      ),
    ));
  }

  void postTitleChanged(String value) {
    emit(state.copyWith(
      post: state.post.copyWith(
        postTitle: value,
      ),
    ));
  }

  void postTagsChanged(List<String> value) {
    emit(state.copyWith(
      post: state.post.copyWith(
        postTags: value,
      ),
    ));
  }

  void yearChanged(String value) {
    emit(state.copyWith(
      post: state.post.copyWith(
        postYear: value,
      ),
    ));
  }

  void creditChanged(String value) {
    emit(state.copyWith(
      post: state.post.copyWith(
        credit: value,
      ),
    ));
  }

  void semesterChanged(String value) {
    emit(state.copyWith(
      post: state.post.copyWith(
        semester: value,
      ),
    ));
  }

  void majorChanged(String value) {
    emit(state.copyWith(
      post: state.post.copyWith(
        major: value,
      ),
    ));
  }

  void lecturerChanged(String value) {
    emit(state.copyWith(
      post: state.post.copyWith(
        lecturer: value,
      ),
    ));
  }

  Future<void> pickOriginalFile() async {
    final file = await _filePickerRepository.pickFile();
    file != File.empty
        ? emit(state.copyWith(
            post: state.post.copyWith(
              originalFile: file,
            ),
            originalFileStatus: FileStatus.pickedWithAcceptableSize,
          ))
        : emit(state.copyWith(
            originalFileStatus: FileStatus.error,
          ));
  }

  void clearOriginalFile() {
    emit(state.copyWith(
      post: state.post.copyWith(
        originalFile: File.empty,
      ),
      originalFileStatus: FileStatus.cleared,
    ));
  }

  Future<void> pickSolutionFile() async {
    final file = await _filePickerRepository.pickFile();
    emit(state.copyWith(
      post: state.post.copyWith(
        solutionFile: file,
      ),
      solutionFileStatus: FileStatus.pickedWithAcceptableSize,
    ));
  }

  void clearSolutionFile() {
    emit(state.copyWith(
      post: state.post.copyWith(
        solutionFile: File.empty,
      ),
      solutionFileStatus: FileStatus.cleared,
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
          final originalFileURL = await _storageRepository
              .getDownloadURL(taskSnapshot.metadata.fullPath);

          final result = await _postRepository.createPost(
            post: state.post,
            originalFileURL: originalFileURL,
          );
          if (result == true) {
            emit(state.copyWith(
              postStatus: PostStatus.success,
            ));
          } else {
            emit(state.copyWith(
              postStatus: PostStatus.error,
            ));
          }
        } else if (taskSnapshot.state == TaskState.running) {
          emit(state.copyWith(
            postStatus: PostStatus.running,
          ));
        } else if (taskSnapshot.state == TaskState.error) {
          emit(state.copyWith(
            postStatus: PostStatus.error,
          ));
        }
      } else {
        emit(state.copyWith(
          postStatus: PostStatus.error,
        ));
      }
    });
  }
}
