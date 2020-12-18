import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_ute/react_solution/bloc/react_solution_bloc.dart';

class EmotionTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReactSolutionBloc, ReactSolutionState>(
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

  _buildTitle(ReactSolutionState state) {
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
