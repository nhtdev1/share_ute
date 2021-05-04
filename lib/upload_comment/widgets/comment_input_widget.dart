import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_ute/upload_comment/upload_comment.dart';

class CommentInputWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(width: 0.2)),
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // For preview gif on top of keyboard if it exists.
          _GifHolder(),
          //
          Row(
            children: <Widget>[
              _KeyboardSelectButton(),
              _CommentTextField(),
              _GifSelectButton(),
              _SendButton(),
            ],
          )
        ],
      ),
    );
  }
}

class _GifHolder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UploadCommentCubit, UploadCommentState>(
      buildWhen: (previous, current) =>
          previous.comment.gifURL != current.comment.gifURL,
      builder: (context, state) {
        if (state.comment.gifURL.isEmpty) return Container();
        return Padding(
          padding: const EdgeInsets.only(left: 15.0, top: 5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Stack(
                alignment: AlignmentDirectional.topEnd,
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 15.0, right: 15.0),
                    height: 105,
                    width: 105,
                    child: Image.network(state.comment.gifURL),
                  ),
                  Positioned(
                    top: -13.5,
                    right: -13.5,
                    child: IconButton(
                      icon: Icon(Icons.highlight_off_outlined),
                      onPressed: () {
                        context.read<UploadCommentCubit>().clearGif();
                      },
                    ),
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }
}

class _KeyboardSelectButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UploadCommentCubit, UploadCommentState>(
      buildWhen: (previous, current) =>
          previous.keyboardStatus != current.keyboardStatus,
      builder: (context, state) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 4),
          child: IconButton(
            icon: Icon(
              Icons.emoji_emotions_outlined,
              color: state.keyboardStatus == KeyboardStatus.showEmoji
                  ? Colors.blueAccent
                  : null,
            ),
            onPressed: () {
              context.read<UploadCommentCubit>().switchEmojiKeyboard();
            },
          ),
        );
      },
    );
  }
}

class _CommentTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UploadCommentCubit, UploadCommentState>(
      buildWhen: (previous, current) =>
          previous.comment.title != current.comment.title,
      builder: (context, state) {
        return Flexible(
          child: TextField(
            controller: state.status == CommentStatus.changedWithEmoji
                ? ((TextEditingController()..text = state.comment.title)
                  ..selection = TextSelection.fromPosition(
                      TextPosition(offset: state.comment.title.length)))
                : null,
            onChanged: (value) =>
                context.read<UploadCommentCubit>().titleChanged(value),
            style: TextStyle(fontSize: 16),
            decoration: InputDecoration.collapsed(
              hintText: 'Type your message...',
              hintStyle: TextStyle(color: Colors.grey),
            ),
          ),
        );
      },
    );
  }
}

class _GifSelectButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UploadCommentCubit, UploadCommentState>(
      buildWhen: (previous, current) =>
          previous.keyboardStatus != current.keyboardStatus,
      builder: (context, state) {
        return IconButton(
          icon: Icon(
            Icons.gif_outlined,
            color: state.keyboardStatus == KeyboardStatus.showGif
                ? Colors.blueAccent
                : null,
          ),
          onPressed: () {
            context.read<UploadCommentCubit>().switchGifKeyboard();
          },
        );
      },
    );
  }
}

class _SendButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UploadCommentCubit, UploadCommentState>(
      buildWhen: (previous, current) => previous.comment != current.comment,
      builder: (context, state) {
        return IconButton(
          icon: Icon(
            Icons.send,
            color: state.comment.isNotEmpty ? Colors.blueAccent : Colors.grey,
          ),
          onPressed: () {
            if (state.comment.isNotEmpty) {
              context.read<UploadCommentCubit>().uploadComment();
              context.read<UploadCommentCubit>().clearGif();
              context.read<UploadCommentCubit>().clearComment();
            }
          },
        );
      },
    );
  }
}
