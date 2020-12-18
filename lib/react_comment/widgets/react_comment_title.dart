import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_ute/react_comment/react_comment.dart';

class EmotionTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReactCommentBloc, ReactCommentState>(
      buildWhen: (previous, current) => previous.emotions != current.emotions,
      builder: (context, state) {
        if (state.emotions.isEmpty) {
          return Container();
        } else {
          return _buildTitle(state);
        }
      },
    );
  }

  _buildTitle(ReactCommentState state) {
    String result = '${state.emotions.length}';
    return Text(
      result,
      style: TextStyle(
        fontSize: 14.0,
        color: Colors.blueAccent,
      ),
    );
  }
}
