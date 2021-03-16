import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_ute/react_comment/react_comment.dart';

class EmotionIcons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReactCommentBloc, ReactCommentState>(
      buildWhen: (previous, current) => previous.emotions != current.emotions,
      builder: (context, state) {
        if (state.emotions.isEmpty) {
          return Container();
        } else {
          return Stack(
            children: [
              ..._buildIcons(state),
            ],
          );
        }
      },
    );
  }

  _buildIcons(ReactCommentState state) {
    final emotions = state.emotions;

    var map = Map();
    emotions.forEach((element) {
      if (!map.containsKey(element.id)) {
        map[element.id] = 1;
      } else {
        map[element.id] += 1;
      }
    });

    List<_Emo> emoList =
        map.entries.map((e) => _Emo(id: e.key, count: e.value)).toList();
    emoList.sort((b, a) {
      if (a.count == b.count) {
        if (int.parse(a.id) <= int.parse(b.id)) {
          return 1;
        } else {
          return -1;
        }
      } else if (a.count < b.count) {
        return -1;
      }
      return 1;
    });

    List<Widget> temps = [];
    for (int i = 0; i < emoList.length; i++) {
      if (i == 3) break;
      temps.add(
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(left: i * 16.0),
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(
              color: Colors.white,
              width: 2.0,
            ),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Image.asset(_getImagePath(emoList[i].id), height: 16),
          ),
        ),
      );
    }
    return temps.reversed.toList();
  }

  _getImagePath(String id) {
    if (id == '1') {
      return 'assets/images/like.png';
    } else if (id == '2') {
      return 'assets/images/love.png';
    } else if (id == '3') {
      return 'assets/images/wow.png';
    } else if (id == '4') {
      return 'assets/images/angry.png';
    } else {
      return 'assets/images/like_disable.png';
    }
  }
}

class _Emo {
  _Emo({
    this.id,
    this.count,
  });

  final String id;
  final int count;
}
