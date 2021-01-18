import 'package:flutter/material.dart';
import 'package:share_ute/react_comment/react_comment.dart';

class ReactCommentForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          EmotionButton(),
          Spacer(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              EmotionIcons(),
              const SizedBox(
                width: 3,
              ),
              EmotionTitle(),
            ],
          ),
        ],
      ),
    );
  }
}
