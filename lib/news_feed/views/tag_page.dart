import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_newsfeed/news_feed/news_feed.dart';
import 'package:flutter_tags/flutter_tags.dart';

class TagPage extends StatefulWidget {
  TagPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _TagPageState createState() => _TagPageState();
}

class _TagPageState extends State<TagPage>
    with SingleTickerProviderStateMixin {
  bool _symmetry = false;
  bool _startDirection = false;
  bool _horizontalScroll = false;
  bool _withSuggesttions = false;
  int _column = 0;
  double _fontSize = 14;
  String _itemCombine = 'withTextBefore';
  String _onPressed = '';
  List _icon = [Icons.home, Icons.language, Icons.headset];

  @override
  void initState() {
    super.initState();
    _items = RawData.list.toList();
  }

  List _items;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        color: Colors.grey[300], width: 0.5))),
            child: ExpansionTile(
              title: Text("Tags"),
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      child: Row(
                        children: <Widget>[
                          Checkbox(
                              value: _withSuggesttions,
                              onChanged: (a) {
                                setState(() {
                                  _withSuggesttions =
                                  !_withSuggesttions;
                                });
                              }),
                          Text('Suggestions')
                        ],
                      ),
                      onTap: () {
                        setState(() {
                          _withSuggesttions = !_withSuggesttions;
                        });
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.all(20),
                    ),
                    DropdownButton(
                      hint: Text(_itemCombine),
                      items: _buildItems2(),
                      onChanged: (val) {
                        setState(() {
                          _itemCombine = val;
                        });
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      child: Row(
                        children: <Widget>[
                          Checkbox(
                              value: _horizontalScroll,
                              onChanged: (a) {
                                setState(() {
                                  _horizontalScroll =
                                  !_horizontalScroll;
                                });
                              }),
                          Text('Horizontal scroll')
                        ],
                      ),
                      onTap: () {
                        setState(() {
                          _horizontalScroll = !_horizontalScroll;
                        });
                      },
                    ),
                    GestureDetector(
                      child: Row(
                        children: <Widget>[
                          Checkbox(
                              value: _startDirection,
                              onChanged: (a) {
                                setState(() {
                                  _startDirection = !_startDirection;
                                });
                              }),
                          Text('Start Direction')
                        ],
                      ),
                      onTap: () {
                        setState(() {
                          _startDirection = !_startDirection;
                        });
                      },
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Text('Font Size'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Slider(
                          value: _fontSize,
                          min: 6,
                          max: 30,
                          onChanged: (a) {
                            setState(() {
                              _fontSize = (a.round()).toDouble();
                            });
                          },
                        ),
                        Text(_fontSize.toString()),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20),
          ),
          _tags2,
        ],
      ),
    );
  }

  // Position for popup menu
  Offset _tapPosition;

  Widget get _tags2 {
    //popup Menu
    final RenderBox overlay = Overlay.of(context).context?.findRenderObject();

    ItemTagsCombine combine = ItemTagsCombine.onlyText;

    switch (_itemCombine) {
      case 'onlyText':
        combine = ItemTagsCombine.onlyText;
        break;
      case 'onlyIcon':
        combine = ItemTagsCombine.onlyIcon;
        break;
      case 'onlyIcon':
        combine = ItemTagsCombine.onlyIcon;
        break;
      case 'onlyImage':
        combine = ItemTagsCombine.onlyImage;
        break;
      case 'imageOrIconOrText':
        combine = ItemTagsCombine.imageOrIconOrText;
        break;
      case 'withTextAfter':
        combine = ItemTagsCombine.withTextAfter;
        break;
      case 'withTextBefore':
        combine = ItemTagsCombine.withTextBefore;
        break;
    }

    return Tags(
      key: Key("2"),
      symmetry: _symmetry,
      columns: _column,
      horizontalScroll: _horizontalScroll,
      verticalDirection:
      _startDirection ? VerticalDirection.up : VerticalDirection.down,
      textDirection: _startDirection ? TextDirection.rtl : TextDirection.ltr,
      heightHorizontalScroll: 60 * (_fontSize / 14),
      textField: _textField,
      itemCount: _items.length,
      itemBuilder: (index) {
        final item = _items[index];

        return GestureDetector(
          child: ItemTags(
            key: Key(index.toString()),
            index: index,
            title: item,
            pressEnabled: false,
            activeColor: Colors.green[400],
            combine: combine,
            image: index > 0 && index < 5
                ? ItemTagsImage(image: AssetImage("img/p$index.jpg"))
                : (1 == 1
                ? ItemTagsImage(
                image: NetworkImage(
                    "https://image.flaticon.com/icons/png/512/44/44948.png"))
                : null),
            icon: (item == '0' || item == '1' || item == '2')
                ? ItemTagsIcon(
              icon: _icon[int.parse(item)],
            )
                : null,
            removeButton: ItemTagsRemoveButton(
              backgroundColor: Colors.green[900],
              onRemoved: () {
                setState(() {
                  _items.removeAt(index);
                });
                return true;
              },
            ),
            textScaleFactor:
            utf8.encode(item.substring(0, 1)).length > 2 ? 0.8 : 1,
            textStyle: TextStyle(
              fontSize: _fontSize,
            ),
          ),
          onTapDown: (details) => _tapPosition = details.globalPosition,
          onLongPress: () {
            showMenu(
              //semanticLabel: item,
                items: <PopupMenuEntry>[
                  PopupMenuItem(
                    child: Text(item, style: TextStyle(color: Colors.blueGrey)),
                    enabled: false,
                  ),
                  PopupMenuDivider(),
                  PopupMenuItem(
                    value: 1,
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.content_copy),
                        Text("Copy text"),
                      ],
                    ),
                  ),
                ],
                context: context,
                position: RelativeRect.fromRect(
                    _tapPosition & Size(40, 40),
                    Offset.zero &
                    overlay
                        .size) // & RelativeRect.fromLTRB(65.0, 40.0, 0.0, 0.0),
            )
                .then((value) {
              if (value == 1) Clipboard.setData(ClipboardData(text: item));
            });
          },
        );
      },
    );
  }

  TagsTextField get _textField {
    return TagsTextField(
      autofocus: false,
      //width: double.infinity,
      //padding: EdgeInsets.symmetric(horizontal: 10),
      textStyle: TextStyle(
        fontSize: _fontSize,
        //height: 1
      ),
      enabled: true,
      constraintSuggestion: true,
      suggestions: _withSuggesttions
          ? [
        "One",
        "two",
        "android",
        "Dart",
        "flutter",
        "test",
        "tests",
        "androids",
        "androidsaaa",
        "Test",
        "suggest",
        "suggestions",
        "互联网",
        "last",
        "lest",
        "炫舞时代"
      ]
          : null,
      onSubmitted: (String str) {
        setState(() {
          _items.add(str);
        });
      },
    );
  }

  List<DropdownMenuItem> _buildItems2() {
    List<DropdownMenuItem> list = [];

    list.add(DropdownMenuItem(
      child: Text("onlyText"),
      value: 'onlyText',
    ));

    list.add(DropdownMenuItem(
      child: Text("onlyIcon"),
      value: 'onlyIcon',
    ));
    list.add(DropdownMenuItem(
      child: Text("onlyImage"),
      value: 'onlyImage',
    ));
    list.add(DropdownMenuItem(
      child: Text("imageOrIconOrText"),
      value: 'imageOrIconOrText',
    ));
    list.add(DropdownMenuItem(
      child: Text("withTextBefore"),
      value: 'withTextBefore',
    ));
    list.add(DropdownMenuItem(
      child: Text("withTextAfter"),
      value: 'withTextAfter',
    ));

    return list;
  }
}