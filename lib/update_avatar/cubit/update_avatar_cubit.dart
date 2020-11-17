import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:share_ute/update_avatar/models/models.dart';
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
    final result = await _filePickerRepository.pickImageFromCamera();

    emit(state.copyWith(
      avatar: Avatar.from(result.path),
      status: UpdateAvatarStatus.pickedAcceptableSize,
    ));
  }

  Future<void> pickImageFromGallery() async {
    final result = await _filePickerRepository.pickImageFromGallery();
    final size = await result.readAsBytes();
    if (size.length > 1e+7) {
      emit(state.copyWith(
        avatar: Avatar.none(),
        status: UpdateAvatarStatus.pickedOverSize,
      ));
    } else {
      emit(state.copyWith(
        avatar: Avatar.from(result.path),
        status: UpdateAvatarStatus.pickedAcceptableSize,
      ));
    }
  }

  Future<void> cropImage() async {
    final result = await _filePickerRepository.cropImage(state.avatar.path);
    emit(state.copyWith(
      avatar: Avatar.from(result.path),
      status: UpdateAvatarStatus.cropped,
    ));
  }

  void clearImage() {
    emit(state.copyWith(
      avatar: Avatar.none(),
      status: UpdateAvatarStatus.cleared,
    ));
  }

  void uploadImage() {
    _storageSubscription = _storageRepository
        .uploadImage(path: state.avatar.path)
        .listen((taskSnapshot) async {
      if (taskSnapshot != null) {
        if (taskSnapshot.state == TaskState.success) {
          final url = await _storageRepository
              .getDownloadURL(taskSnapshot.metadata.fullPath);
          await _firestoreUserRepository.updateAvatarUrl(url: url);
          emit(state.copyWith(
            status: UpdateAvatarStatus.success,
          ));
        } else if (taskSnapshot.state == TaskState.running) {
          emit(state.copyWith(
            status: UpdateAvatarStatus.running,
          ));
        } else if (taskSnapshot.state == TaskState.error) {
          emit(state.copyWith(
            status: UpdateAvatarStatus.error,
          ));
        }
      } else {
        emit(state.copyWith(
          status: UpdateAvatarStatus.error,
        ));
      }
    });
  }
}
