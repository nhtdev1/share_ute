import 'package:flutter/material.dart';
import 'package:share_ute/react_post/widgets/widgets.dart';

class ReactPostForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        EmotionIcons(),
        EmotionTitle(),
        EmotionButton(),
      ],
    );
  }
}
