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
    this.playbackSpeed = 1.0,
    this.status = VideoStatus.unknown,
  });

  final File file;
  final double playbackSpeed;
  final VideoStatus status;

  @override
  List<Object> get props => [
        file,
        playbackSpeed,
        status,
      ];

  PlayVideoState copyWith({
    File file,
    double playbackSpeed,
    VideoStatus status,
  }) {
    return PlayVideoState(
      file: file ?? this.file,
      playbackSpeed: playbackSpeed ?? this.playbackSpeed,
      status: status ?? this.status,
    );
  }
}
