part of 'play_video_cubit.dart';

enum VideoStatus {
  unknown,
  initialized,
  played,
  paused,
}

class PlayVideoState extends Equatable {
  const PlayVideoState({
    this.file = File.empty,
    this.status = VideoStatus.unknown,
  });

  final File file;
  final VideoStatus status;

  @override
  List<Object> get props => [
        file,
        status,
      ];

  PlayVideoState copyWith({
    File file,
    VideoStatus status,
  }) {
    return PlayVideoState(
      file: file ?? this.file,
      status: status ?? this.status,
    );
  }
}
