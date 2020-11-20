import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:storage_repository/storage_repository.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker_repository/file_picker_repository.dart';
import 'package:user_repository/user_repository.dart';

part 'update_avatar_state.dart';

class UpdateAvatarCubit extends Cubit<UpdateAvatarState> {
  UpdateAvatarCubit({
    FilePickerRepository filePickerRepository,
    StorageRepository storageRepository,
    FirestoreUserRepository firestoreUserRepository,
  })  : assert(filePickerRepository != null),
        _filePickerRepository = filePickerRepository,
        _storageRepository = storageRepository,
        _firestoreUserRepository = firestoreUserRepository,
        super(const UpdateAvatarState());

  @override
  Future<void> close() {
    _storageSubscription?.cancel();
    return super.close();
  }

  final FilePickerRepository _filePickerRepository;
  final StorageRepository _storageRepository;
  final FirestoreUserRepository _firestoreUserRepository;

  StreamSubscription<TaskSnapshot> _storageSubscription;

  Future<void> pickImageFromCamera() async {
    final file = await _filePickerRepository.pickImageFromCamera();
    if (file.isNotEmpty) {
      emit(state.copyWith(
        file: file,
        avatarStatus: AvatarStatus.pickedAcceptableSize,
      ));
    } else {
      emit(state.copyWith(
        avatarStatus: AvatarStatus.pickedError,
      ));
    }
  }

  Future<void> pickImageFromGallery() async {
    final file = await _filePickerRepository.pickImageFromGallery();
    if (file.isNotEmpty) {
      if (int.parse(file.fileSize) > 1e+7) {
        emit(state.copyWith(
          avatarStatus: AvatarStatus.pickedOverSize,
        ));
      } else {
        emit(state.copyWith(
          file: file,
          avatarStatus: AvatarStatus.pickedAcceptableSize,
        ));
      }
    } else {
      emit(state.copyWith(
        avatarStatus: AvatarStatus.pickedError,
      ));
    }
  }

  Future<void> cropImage() async {
    final file = await _filePickerRepository.cropImage(state.file.path);
    if (file.isNotEmpty) {
      emit(state.copyWith(
        file: file,
        avatarStatus: AvatarStatus.cropped,
      ));
    } else {
      emit(state.copyWith(
        avatarStatus: AvatarStatus.croppedError,
      ));
    }
  }

  void clearImage() {
    emit(state.copyWith(
      file: File.empty,
      avatarStatus: AvatarStatus.cleared,
    ));
  }

  void uploadImage() {
    _storageSubscription = _storageRepository
        .uploadImage(path: state.file.path)
        .listen((taskSnapshot) async {
      if (taskSnapshot != null) {
        if (taskSnapshot.state == TaskState.success) {
          final photoURL = await _storageRepository
              .getDownloadURL(taskSnapshot.metadata.fullPath);

          final result = await _firestoreUserRepository.updateUserAvatar(
              photoURL: photoURL);
          if (result) {
            emit(state.copyWith(
              updateAvatarProgress: UpdateAvatarProgress.submissionSuccess,
            ));
            emit(state.copyWith(
              avatarStatus: AvatarStatus.unknown,
              updateAvatarProgress: UpdateAvatarProgress.unknown,
            ));
          } else {
            emit(state.copyWith(
              updateAvatarProgress: UpdateAvatarProgress.submissionFailure,
            ));
          }
        } else if (taskSnapshot.state == TaskState.running) {
          emit(state.copyWith(
            updateAvatarProgress: UpdateAvatarProgress.submissionInProgress,
          ));
        } else if (taskSnapshot.state == TaskState.error) {
          emit(state.copyWith(
            updateAvatarProgress: UpdateAvatarProgress.submissionFailure,
          ));
        }
      } else {
        emit(state.copyWith(
          updateAvatarProgress: UpdateAvatarProgress.submissionFailure,
        ));
      }
    });
  }
}
