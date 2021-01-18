import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:comment_repository/comment_repository.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:share_ute/firestore_user/firestore_user.dart';
import 'package:share_ute/notification/notification.dart';
import 'package:share_ute/system_notification/system_notification.dart';

part 'upload_comment_state.dart';

class UploadCommentCubit extends Cubit<UploadCommentState> {
  UploadCommentCubit({
    CommentRepository commentRepository,
    FirestoreUserBloc firestoreUserBloc,
    NotificationCubit notificationCubit,
    SystemNotificationCubit systemNotificationCubit,
  })  : _commentRepository = commentRepository,
        _firestoreUserBloc = firestoreUserBloc,
        _notificationCubit = notificationCubit,
        _systemNotificationCubit = systemNotificationCubit,
        super(const UploadCommentState()) {
    keyboardVisibilityController.onChange.listen((visbile) {
      if (visbile) {
        emit(state.copyWith(keyboardStatus: KeyboardStatus.showDefault));
      }
    });
    _systemSubscription =
        _systemNotificationCubit.listen((systemNotificationState) {
      if (systemNotificationState.systemStatus ==
          SystemStatus.backButtonPressed) {
        _enableDefaultKeyboard();
      }
    });
  }

  final CommentRepository _commentRepository;
  final FirestoreUserBloc _firestoreUserBloc;
  final NotificationCubit _notificationCubit;
  final SystemNotificationCubit _systemNotificationCubit;

  var keyboardVisibilityController = KeyboardVisibilityController();
  StreamSubscription<SystemNotificationState> _systemSubscription;

  @override
  Future<void> close() {
    _systemSubscription?.cancel();
    return super.close();
  }

  void titleChanged(String value) {
    emit(state.copyWith(
      comment: state.comment.copyWith(
        title: value,
      ),
      status: CommentStatus.changedWithText,
    ));
  }

  void gifChanged(String value) {
    emit(state.copyWith(
      comment: state.comment.copyWith(
        gifURL: value,
      ),
      status: CommentStatus.changedWithGif,
    ));
  }

  void addEmoji(String value) {
    emit(state.copyWith(
      comment: state.comment.copyWith(
        title: state.comment.title + value,
      ),
      status: CommentStatus.changedWithEmoji,
    ));
  }

  void clearComment() {
    emit(state.copyWith(
      comment: Comment.empty,
      status: CommentStatus.changedWithEmoji,
    ));
  }

  void clearGif() {
    emit(state.copyWith(
      comment: state.comment.copyWith(
        gifURL: '',
      ),
      status: CommentStatus.changedWithGif,
    ));
  }

  void switchEmojiKeyboard() {
    state.keyboardStatus == KeyboardStatus.showEmoji
        ? _enableDefaultKeyboard()
        : _enableEmojiKeyboard();
  }

  void switchGifKeyboard() async {
    state.keyboardStatus == KeyboardStatus.showGif
        ? _enableDefaultKeyboard()
        : _enableGifKeyboard();
  }

  void _enableEmojiKeyboard() async {
    await SystemChannels.textInput.invokeMethod('TextInput.hide');
    emit(state.copyWith(keyboardStatus: KeyboardStatus.showEmoji));
  }

  void _enableGifKeyboard() async {
    await SystemChannels.textInput.invokeMethod('TextInput.hide');
    emit(state.copyWith(keyboardStatus: KeyboardStatus.showGif));
  }

  void _enableDefaultKeyboard() async {
    await SystemChannels.textInput.invokeMethod('TextInput.show');
    emit(state.copyWith(keyboardStatus: KeyboardStatus.showDefault));
  }

  void uploadComment() {
    final dateCreated = DateTime.now().millisecondsSinceEpoch.toString();
    final copyComment = state.comment.copyWith(
      postId: _notificationCubit.state.currentPost.postID,
      username: _firestoreUserBloc.state.user.name,
      photoURL: _firestoreUserBloc.state.user.photo,
      dateCreated: dateCreated,
    );
    _commentRepository.createComment(comment: copyComment);
  }
}
