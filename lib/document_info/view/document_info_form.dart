import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_ute/document/document.dart';
import 'package:share_ute/document_info/widgets/widgets.dart';

class DocumentInfoForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final post = context.watch<DocumentCubit>().state.post;
    return Container(
      color: CupertinoColors.white,
      child: Stack(
        children: [
          DocumentThumbnail(post),
          _Holder(),
          DocumentDetails(post),
          EmotionIcons(),
          EmotionTitle(),
          EmotionButton(),
          UserAvatar(),
          Container(
            margin: EdgeInsets.only(
                top: (MediaQuery.of(context).size.width / 1.2) - 5.0),
            child: Divider(),
          ),
        ],
      ),
    );
  }
}

class _Holder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: (MediaQuery.of(context).size.width / 1.2) - 24.0,
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        decoration: BoxDecoration(
          color: CupertinoColors.white,
          boxShadow: [
            BoxShadow(
              color: CupertinoColors.systemGrey3,
              offset: const Offset(1.1, 1.1),
              blurRadius: 10.0,
            ),
          ],
        ),
      ),
    );
  }
}
