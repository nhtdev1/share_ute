import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker_repository/file_picker_repository.dart';
import 'package:post_repository/post_repository.dart';
import 'package:video_player/video_player.dart';

part 'play_video_state.dart';

class PlayVideoCubit extends Cubit<PlayVideoState> {
  PlayVideoCubit() : super(const PlayVideoState());

  VideoPlayerController controller;

  void initialized(Post post) {
    controller = VideoPlayerController.network(post.originalFile.path)
      ..setLooping(true)
      ..initialize().then(
        (value) => {
          emit(state.copyWith(
            file: post.originalFile,
            status: VideoStatus.initialized,
          ))
        },
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

  @override
  Future<void> close() {
    controller.dispose();
    return super.close();
  }
}
