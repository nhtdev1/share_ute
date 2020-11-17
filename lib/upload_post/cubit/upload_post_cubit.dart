import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker_repository/file_picker_repository.dart';
import 'package:post_repository/post_repository.dart';
import 'package:share_ute/upload_post/models/models.dart';
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
    final postAccessModifiers = value == 'Công khai'
        ? const AccessModifiers.public()
        : const AccessModifiers.private();
    emit(state.copyWith(
      post: state.post.copyWith(
        postAccessModifiers: postAccessModifiers,
      ),
    ));
  }

  void postTitleChanged(String value) {
    final postTitle = Title.dirty(value);
    emit(state.copyWith(
      post: state.post.copyWith(
        postTitle: postTitle,
      ),
    ));
  }

  void postTagsChanged(List<String> value) {
    final tags = Tags.dirty(value);
    emit(state.copyWith(
      post: state.post.copyWith(
        postTags: tags,
      ),
    ));
  }

  void optionalYearChanged(String value) {
    final year = Year.dirty(value);
    emit(state.copyWith(
      optional: state.optional.copyWith(
        year: year,
      ),
    ));
  }

  void optionalCreditsChanged(String value) {
    final credits = Credits.dirty(value);
    emit(state.copyWith(
      optional: state.optional.copyWith(
        credits: credits,
      ),
    ));
  }

  void optionalSemesterChanged(String value) {
    final semester = Semester.dirty(value);
    emit(state.copyWith(
      optional: state.optional.copyWith(
        semester: semester,
      ),
    ));
  }

  void optionalLecturersChanged(String value) {
    final lecturers = Lecturers.dirty(value);
    emit(state.copyWith(
      optional: state.optional.copyWith(
        lecturers: lecturers,
      ),
    ));
  }

  Future<void> pickFile() async {
    final result = await _filePickerRepository.pickFile();
    emit(state.copyWith(
      post: state.post.copyWith(
        file: state.post.file.copyWith(
          path: result.files.single.path,
          fileName: Name.dirty(result.files.first.name),
          fileExtension: Extension.dirty(result.files.first.extension),
          fileSize: Size.dirty(result.files.first.size.toString()),
        ),
      ),
      postStatus: UploadPostStatus.pickedAcceptableFileSize,
    ));
  }

  void clearFile() {
    emit(state.copyWith(
      post: state.post.copyWith(
        file: const File(),
      ),
      postStatus: UploadPostStatus.cleared,
    ));
  }

  Future<void> pickSolutionFile() async {
    final result = await _filePickerRepository.pickFile();
    emit(state.copyWith(
      optional: state.optional.copyWith(
        solutionFile: state.optional.solutionFile.copyWith(
          path: result.files.single.path,
          fileName: Name.dirty(result.files.first.name),
          fileExtension: Extension.dirty(result.files.first.extension),
          fileSize: Size.dirty(result.files.first.size.toString()),
        ),
      ),
      solutionFileStatus: UploadPostStatus.pickedAcceptableFileSize,
    ));
  }

  void clearSolutionFile() {
    emit(state.copyWith(
      optional: state.optional.copyWith(
        solutionFile: const File(),
      ),
      solutionFileStatus: UploadPostStatus.cleared,
    ));
  }

  void uploadPost() {
    _storageSubscription = _storageRepository
        .uploadDocument(
      path: state.post.file.path,
      name: state.post.file.fileName.value,
    )
        .listen((taskSnapshot) async {
      if (taskSnapshot != null) {
        if (taskSnapshot.state == TaskState.success) {
          final url = await _storageRepository
              .getDownloadURL(taskSnapshot.metadata.fullPath);

          await _postRepository.createPost(
            postAccessModifiers:
                state.post.postAccessModifiers.public.toString(),
            postTitle: state.post.postTitle.value,
            fileName: state.post.file.fileName.value,
            fileExtension: state.post.file.fileExtension.value,
            fileSize: state.post.file.fileSize.value,
            fileURL: url,
            postTags: state.post.postTags.value,
          );
          emit(state.copyWith(
            postStatus: UploadPostStatus.success,
          ));
        } else if (taskSnapshot.state == TaskState.running) {
          emit(state.copyWith(
            postStatus: UploadPostStatus.running,
          ));
        } else if (taskSnapshot.state == TaskState.error) {
          emit(state.copyWith(
            postStatus: UploadPostStatus.error,
          ));
        }
      } else {
        emit(state.copyWith(
          postStatus: UploadPostStatus.error,
        ));
      }
    });
  }
}
