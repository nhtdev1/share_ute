import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_ute/play_video/play_video.dart';
import 'package:video_player/video_player.dart';

class PlayVideoForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = context.watch<PlayVideoCubit>().controller;
    return BlocBuilder<PlayVideoCubit, PlayVideoState>(
      builder: (context, state) {
        if (state.status == VideoStatus.unknown) {
          return AspectRatio(
              aspectRatio: controller.value.aspectRatio,
              child: Center(
                child: CircularProgressIndicator(strokeWidth: 1),
              ));
        }
        return AspectRatio(
          aspectRatio: controller.value.aspectRatio,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              VideoPlayer(controller),
              _ControlsOverlap(controller),
              VideoProgressIndicator(controller, allowScrubbing: true),
            ],
          ),
        );
      },
    );
  }
}

class _ControlsOverlap extends StatelessWidget {
  const _ControlsOverlap(this.controller);

  final VideoPlayerController controller;
  static const _playbackRates = [
    0.25,
    0.5,
    0.75,
    1.0,
    1.25,
    1.5,
    1.75,
    2.0,
  ];
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayVideoCubit, PlayVideoState>(
        builder: (context, state) {
      return Stack(
        children: [
          AnimatedSwitcher(
            duration: Duration(milliseconds: 50),
            reverseDuration: Duration(milliseconds: 200),
            child: state.status == VideoStatus.played
                ? SizedBox.shrink()
                : Container(
                    color: Colors.black26,
                    child: Center(
                      child: Icon(
                        Icons.play_arrow,
                        color: Colors.white,
                        size: 60,
                      ),
                    ),
                  ),
          ),
          GestureDetector(
            onTap: () {
              context.read<PlayVideoCubit>().played();
            },
          ),
          Align(
            alignment: Alignment.topRight,
            child: PopupMenuButton<double>(
              initialValue: state.playbackSpeed,
              onSelected: (speed) {
                context.read<PlayVideoCubit>().playbackSpeedChanged(speed);
              },
              itemBuilder: (context) {
                return [
                  for (final speed in _playbackRates)
                    PopupMenuItem(
                      child: Text('${speed}x'),
                      value: speed,
                    )
                ];
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 16,
                ),
                child: Text('${state.playbackSpeed}x'),
              ),
            ),
          )
        ],
      );
    });
  }
}
