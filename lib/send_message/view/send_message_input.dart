import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_ute/select_emoij_type/select_emoij_type.dart';
import 'package:share_ute/send_message/cubit/send_message_cubit.dart';
import 'package:share_ute/send_message/widgets/widgets.dart';
import 'package:share_ute/upload_comment/models/emoji.dart';

class SendMessageInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        //Visible by default
        CurrentKeyboardWidget(),

        //Invisible by default
        EmoijKeyboardWidget(
          keyboardOptionsWidget: KeyboardOptionsWidget(),
          emoijListWidget: EmoijListWidget(),
          emoijTypeOptionsWidget: SelectEmoijTypePage(),
        ),

        ////Invisible by default
        _GifKeyBoard(),
      ],
    );
  }
}

// ignore: unused_element
class _EmoijKeyBoard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SendMessageCubit, SendMessageState>(
      builder: (context, state) {
        return Offstage(
          child: Container(
            height: 300,
            color: Colors.grey.withOpacity(0.1),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: TextButton(
                          child: Text(
                            'EFFECTS',
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () {},
                        ),
                      ),
                      Container(
                        child: TextButton(
                          child: Text(
                            'STICKERS',
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () {},
                        ),
                      ),
                      Container(
                        child: TextButton(
                          child: Text(
                            'GIFS',
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () {},
                        ),
                      ),
                      Container(
                        child: TextButton(
                          child: Text(
                            'EMOJI',
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: SingleChildScrollView(
                    child: _buidEmoji(context),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(
                              color: Colors.grey.withOpacity(0.1), width: 3))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Container(
                          child: TextButton(
                            child: Text('😀'),
                            onPressed: () {},
                          ),
                        ),
                      ),
                      Expanded(
                          child: Container(
                        child: TextButton(
                          child: Text('🐻'),
                          onPressed: () {},
                        ),
                      )),
                      Expanded(
                          child: Container(
                        child: TextButton(
                          child: Text('🍔'),
                          onPressed: () {},
                        ),
                      )),
                      Expanded(
                          child: Container(
                        child: TextButton(
                          child: Text('⚽'),
                          onPressed: () {},
                        ),
                      )),
                      Expanded(
                          child: Container(
                        child: TextButton(
                          child: Text('🚖'),
                          onPressed: () {},
                        ),
                      )),
                      Expanded(
                        child: Container(
                          child: TextButton(
                            child: Text('💡'),
                            onPressed: () {},
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: TextButton(
                            child: Text('❤️'),
                            onPressed: () {},
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: TextButton(
                            child: Text('🇻🇳'),
                            onPressed: () {},
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: TextButton(
                            child: Text('🇻🇳'),
                            onPressed: () {},
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          offstage: !(state.keyboardStatus == KeyboardStatus.showOptions),
        );
      },
    );
  }

  _buidEmoji(BuildContext context) {
    final List<TableRow> tableRowList = [];
    final List<String> row = [];
    final List<String> smileysAndPeople = Emoji.smileysAndPeople.split(" ");

    for (int i = 1; i <= smileysAndPeople.length; i++) {
      row.add(smileysAndPeople[i - 1]);
      if (i % 7 == 0) {
        final copyRow = <Container>[];
        row.forEach((e) {
          copyRow.add(
            Container(
              padding: EdgeInsets.all(10.0),
              child: Center(
                child: Text(
                  e,
                  style: TextStyle(fontSize: 25),
                ),
              ),
            ),
          );
        });
        tableRowList.add(TableRow(children: copyRow));
        row.clear();
      }
    }

    return Container(
      child: Table(
        defaultColumnWidth:
            FixedColumnWidth(MediaQuery.of(context).size.width / 7),
        children: tableRowList,
      ),
    );
  }
}

class _GifKeyBoard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SendMessageCubit, SendMessageState>(
      builder: (context, state) {
        return Offstage(
          child: Container(
            height: 100,
            color: Colors.blue,
          ),
          offstage: true,
        );
      },
    );
  }
}

class CurrentKeyboardWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // // For gif preview on top of keyboard if it exists.
        _GifPreviewWidget(),

        _NonameWidget(),
      ],
    );
  }
}

class _GifPreviewWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class _NonameWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textEditingController =
        context.watch<SendMessageCubit>().textEditingController;
    final focusNode = context.watch<SendMessageCubit>().focusNode;

    return BlocBuilder<SendMessageCubit, SendMessageState>(
        builder: (context, state) {
      return Container(
        decoration: BoxDecoration(color: Colors.white),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            //Button send image
            if (state.textKeyboardStatus == TextKeyboardStatus.unCursor)
              Material(
                child: Container(
                  child: IconButton(
                    icon: Icon(Icons.camera_alt),
                    onPressed: () {},
                  ),
                ),
                color: Colors.white,
              ),
            if (state.textKeyboardStatus == TextKeyboardStatus.unCursor)
              Material(
                child: Container(
                  child: IconButton(
                    icon: Icon(Icons.image),
                    onPressed: () {},
                  ),
                ),
                color: Colors.white,
              ),
            if (state.textKeyboardStatus == TextKeyboardStatus.unCursor)
              Material(
                child: Container(
                  child: IconButton(
                    icon: Icon(Icons.mic),
                    onPressed: () {},
                  ),
                ),
                color: Colors.white,
              ),
            if (state.textKeyboardStatus == TextKeyboardStatus.hasCursor)
              Material(
                child: Container(
                  child: IconButton(
                    icon: Icon(
                      Icons.keyboard_arrow_right,
                      color: Colors.blue,
                    ),
                    onPressed: () {
                      context.read<SendMessageCubit>().textKeyboardUnfocused();
                    },
                  ),
                ),
                color: Colors.white,
              ),

            Flexible(
              child: AnimatedContainer(
                duration: Duration(milliseconds: 700),
                curve: Curves.linearToEaseOut,
                width: state.textKeyboardStatus == TextKeyboardStatus.unCursor
                    ? MediaQuery.of(context).size.width * 1 / 2
                    : MediaQuery.of(context).size.width * 3 / 4,
                child: Stack(
                  alignment: Alignment.centerRight,
                  children: [
                    TextFormField(
                      focusNode: focusNode,
                      controller: textEditingController,
                      keyboardType: TextInputType.text,
                      onTap: () {
                        context.read<SendMessageCubit>().textKeyboardFocused();
                      },
                      onChanged: (value) {
                        context.read<SendMessageCubit>().messageChanged(value);
                      },
                      decoration: InputDecoration(
                        hintText: state.textKeyboardStatus ==
                                TextKeyboardStatus.unCursor
                            ? 'Aa'
                            : 'Typing message...',
                        isDense: true, // important line
                        contentPadding: EdgeInsets.fromLTRB(
                            10, 15, 10, 0), // control your hints text size
                        hintStyle:
                            TextStyle(letterSpacing: 1, color: Colors.black54),
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(60),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    if (state.messsage.isEmpty)
                      IconButton(
                          icon: Icon(
                            Icons.face,
                            color: Colors.blue,
                          ),
                          onPressed: () {
                            context.read<SendMessageCubit>().keyBoardChanged();
                          }),
                  ],
                ),
              ),
            ),

            //Send button
            Material(
              child: state.messsage.isEmpty
                  ? Container(
                      child: IconButton(
                        icon: Icon(Icons.favorite),
                        color: Colors.pinkAccent,
                        onPressed: () {},
                      ),
                    )
                  : Container(
                      child: IconButton(
                        icon: Icon(Icons.send),
                        color: Colors.blue,
                        onPressed: () {},
                      ),
                    ),
              color: Colors.white,
            ),
          ],
        ),
      );
    });
  }
}
