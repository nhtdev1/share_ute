import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker_repository/file_picker_repository.dart';
import 'package:share_ute/firestore_user/firestore_user.dart';
import 'package:share_ute/notification/notification.dart';
import 'package:solution_repository/solution_repository.dart';
import 'package:storage_repository/storage_repository.dart';
import 'package:firebase_storage/firebase_storage.dart';

part 'upload_solution_state.dart';

class UploadSolutionCubit extends Cubit<UploadSolutionState> {
  UploadSolutionCubit({
    FilePickerRepository filePickerRepository,
    StorageRepository storageRepository,
    SolutionRepository solutionRepository,
    FirestoreUserBloc firestoreUserBloc,
    NotificationCubit notificationCubit,
  })  : _storageRepository = storageRepository,
        _filePickerRepository = filePickerRepository,
        _solutionRepository = solutionRepository,
        _firestoreUserBloc = firestoreUserBloc,
        _notificationCubit = notificationCubit,
        super(const UploadSolutionState());

  final FilePickerRepository _filePickerRepository;
  final StorageRepository _storageRepository;
  final SolutionRepository _solutionRepository;
  final FirestoreUserBloc _firestoreUserBloc;
  final NotificationCubit _notificationCubit;

  StreamSubscription<TaskSnapshot> _storageSubscription;

  @override
  Future<void> close() {
    _storageSubscription?.cancel();
    return super.close();
  }

  void solutionTitleChanged(String value) {
    emit(
      state.copyWith(
        solution: state.solution.copyWith(
          title: value,
        ),
        solutionStatus: SolutionStatus.changed,
      ),
    );
  }

  Future<void> pickFile() async {
    emit(state.copyWith(
      fileStatus: FileStatus.pickFileInProgress,
    ));
    final file = await _filePickerRepository.pickFile();
    if (file.isNotEmpty) {
      if (int.parse(file.fileSize) > 25000) {
        emit(state.copyWith(
          fileStatus: FileStatus.pickedWithOverSize,
        ));
      } else {
        emit(state.copyWith(
          solution: state.solution.copyWith(
            solutionFile: file,
          ),
          fileStatus: FileStatus.pickedWithAcceptableSize,
          solutionStatus: SolutionStatus.changed,
        ));
      }
      emit(state.copyWith(
        fileStatus: FileStatus.unknown,
      ));
    } else {
      emit(state.copyWith(
        fileStatus: FileStatus.pickedError,
      ));
    }
  }

  void clearFile() {
    emit(state.copyWith(
      solution: state.solution.copyWith(
        solutionFile: File.empty,
      ),
      fileStatus: FileStatus.cleared,
      solutionStatus: SolutionStatus.changed,
    ));
  }

  void uploadSolution() {
    final dateCreated = DateTime.now().millisecondsSinceEpoch.toString();
    final copySolution = state.solution.copyWith(
      postID: _notificationCubit.state.currentPost.postID,
      photoURL: _firestoreUserBloc.state.user.photo,
      dateCreated: dateCreated,
    );
    _storageSubscription = _storageRepository
        .uploadSolution(solution: copySolution)
        .listen((taskSnapshot) async {
      if (taskSnapshot != null) {
        if (taskSnapshot.state == TaskState.success) {
          // Get file's url of a post which stored in firestorage
          final fileURL = await _storageRepository
              .getDownloadURL(taskSnapshot.metadata.fullPath);

          final result = await _solutionRepository.createSolutionFile(
            solution: copySolution.copyWith(
              solutionFile: state.solution.solutionFile.copyWith(
                path: fileURL,
              ),
            ),
          );

          if (result.isNotEmpty) {
            emit(state.copyWith(
              uploadSolutionProgress: UploadSolutionProgress.submissionSuccess,
            ));
          } else {
            emit(state.copyWith(
              uploadSolutionProgress: UploadSolutionProgress.submissionFailure,
            ));
          }
        } else if (taskSnapshot.state == TaskState.running) {
          emit(state.copyWith(
            uploadSolutionProgress: UploadSolutionProgress.submissionInProgress,
          ));
        } else if (taskSnapshot.state == TaskState.error) {
          emit(state.copyWith(
            uploadSolutionProgress: UploadSolutionProgress.submissionFailure,
          ));
        }
      } else {
        emit(state.copyWith(
          uploadSolutionProgress: UploadSolutionProgress.submissionFailure,
        ));
      }
    });
  }
}
