import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_ute/emotion/emotion.dart';

class EmotionTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmotionBloc, EmotionState>(
      buildWhen: (previous, current) => previous.emotions != current.emotions,
      builder: (context, state) {
        final emotions = state.emotions;

        var map = Map();
        emotions.forEach((element) {
          if (!map.containsKey(element.id)) {
            map[element.id] = 1;
          } else {
            map[element.id] += 1;
          }
        });
        final length = map.length > 3 ? 3 : map.length;

        if (state.emotions.isEmpty) {
          return Container();
        } else {
          return Positioned(
            top: (MediaQuery.of(context).size.width / 1.2) - 19.0,
            left: length * 16.0 + length * 2.0 + 15.0 + 5.0,
            child: _buildTitle(state),
          );
        }
      },
    );
  }

  _buildTitle(EmotionState state) {
    final length = state.emotions.length;
    String result = '';
    if (length == 1) {
      if (state.userStatus != EmotionInteractionStatus.unknown) {
        result = 'Bạn';
      } else {
        result = '$length';
      }
    } else if (length > 1) {
      if (state.userStatus != EmotionInteractionStatus.unknown) {
        result = 'Bạn và ${state.emotions.length - 1} người khác';
      } else {
        result = '${state.emotions.length}';
      }
    }
    return Text(
      result,
      style: TextStyle(
        fontSize: 14.0,
        color: Colors.blueAccent,
      ),
    );
  }
}
