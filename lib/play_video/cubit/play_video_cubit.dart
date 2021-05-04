import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker_repository/file_picker_repository.dart';
import 'package:meta/meta.dart';
import 'package:share_ute/notification/notification.dart';
import 'package:video_player/video_player.dart';

part 'play_video_state.dart';

class PlayVideoCubit extends Cubit<PlayVideoState> {
  PlayVideoCubit({@required NotificationCubit notificationCubit})
      : super(PlayVideoState(
            file: notificationCubit.state.currentPost.originalFile));

  VideoPlayerController controller;

  @override
  Future<void> close() {
    controller.dispose();
    return super.close();
  }

  void initialized() {
    controller = VideoPlayerController.network(state.file.path)
      ..setLooping(true)
      ..initialize().then(
        (value) => {emit(state.copyWith(status: VideoStatus.initialized))},
      );
  }

  void played() {
    if (controller.value.isPlaying) {
      controller.pause();
      emit(state.copyWith(status: VideoStatus.paused));
    } else {
      controller.play();
      emit(state.copyWith(status: VideoStatus.played));
    }
  }

  void playbackSpeedChanged(double speed) {
    controller.setPlaybackSpeed(speed);
    emit(state.copyWith(playbackSpeed: speed));
  }
}
