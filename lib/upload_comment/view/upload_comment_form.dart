import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:share_ute/upload_comment/upload_comment.dart';

class UploadCommentForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        CommentInputWidget(),
        _EmojiKeyboard(),
        _GifKeyboard(),
      ],
    );
  }
}

class _EmojiKeyboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UploadCommentCubit, UploadCommentState>(
      buildWhen: (previous, current) =>
          previous.keyboardStatus != current.keyboardStatus,
      builder: (context, state) {
        return Offstage(
          child: _buidEmoji(context),
          offstage: !(state.keyboardStatus == KeyboardStatus.showEmoji),
        );
      },
    );
  }

  _buidEmoji(BuildContext context) {
    final List<TableRow> tableRowList = [];
    final row = <String>[];
    for (int i = 1; i <= Emoji.smileys.length; i++) {
      row.add(Emoji.smileys[i - 1]);
      if (i % 7 == 0) {
        final copyRow = <GestureDetector>[];
        row.forEach((e) {
          copyRow.add(
            GestureDetector(
              child: Container(
                padding: EdgeInsets.all(5.0),
                child: Center(
                  child: Text(
                    e,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              onTap: () => context.read<UploadCommentCubit>().addEmoji(e),
            ),
          );
        });
        tableRowList.add(TableRow(children: copyRow));
        row.clear();
      }
    }

    return Container(
      height: MediaQuery.of(context).size.height / 4,
      child: Table(
        defaultColumnWidth:
            FixedColumnWidth(MediaQuery.of(context).size.width / 7),
        children: tableRowList,
      ),
    );
  }
}

class _GifKeyboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UploadCommentCubit, UploadCommentState>(
      buildWhen: (previous, current) =>
          previous.keyboardStatus != current.keyboardStatus,
      builder: (context, state) {
        return Offstage(
          child: _buildGif(context),
          offstage: !(state.keyboardStatus == KeyboardStatus.showGif),
        );
      },
    );
  }

  _buildGif(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 4,
      child: StaggeredGridView.countBuilder(
        crossAxisCount: 4,
        itemCount: Gif.sources.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            child: Container(
              padding: const EdgeInsets.all(3.0),
              child: Center(
                child: Image.network(Gif.sources[index]),
              ),
            ),
            onTap: () {
              context.read<UploadCommentCubit>().gifChanged(Gif.sources[index]);
            },
          );
        },
        staggeredTileBuilder: (int index) => StaggeredTile.fit(2),
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
      ),
    );
  }
}
