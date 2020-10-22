import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tags/flutter_tags.dart';

class AttachedTags extends StatefulWidget {
  @override
  _AttachedTagsState createState() => _AttachedTagsState();
}

class _AttachedTagsState extends State<AttachedTags> {
  bool _horizontalScroll = false;
  bool _symmetry = false;
  int _column = 0;
  double _fontSize = 14.0;

  final List<String> _attachedTags = [
    'CNTT',
    '3',
    '2020',
    'Toan A1',
    'HK2',
    'CDT',
    'CLC',
    'TLCN',
  ];

  final List<String> _suggestionTags = [
    'Điện, điện tử',
    'Điện tử viễn thông',
    'CNTT',
    'IoT',
    '3TC',
    '2TC',
    '1TC',
    'Chế tạo máy',
    'Cơ điện tử',
    'Cơ khí',
    'Xây dựng',
    'Ô tô',
    'Nhiệt',
    'QLCN',
    'Kế toán',
    'TMĐT',
    'Công nghệ may',
    'Kiến trúc',
    'CNTP',
    'CNHH'
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
            bottom: BorderSide(color: CupertinoColors.systemGrey, width: 0.3)),
      ),
      child: ExpansionTile(
        title: Text('Search with tags'),
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Tags Size'),
                const SizedBox(
                  width: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CupertinoSlider(
                      value: _fontSize,
                      min: 13,
                      max: 21,
                      onChanged: (value) {
                        setState(() {
                          _fontSize = (value.round()).toDouble();
                        });
                      },
                    ),
                    const SizedBox(
                      width: 2,
                    ),
                    Text(_fontSize.toString()),
                  ],
                ),
                const SizedBox(
                  width: 15,
                ),
                CupertinoButton(
                  child: _horizontalScroll
                      ? Icon(
                          const IconData(0xf6eb,
                              fontFamily: CupertinoIcons.iconFont,
                              fontPackage: CupertinoIcons.iconFontPackage),
                          color: CupertinoColors.systemGrey,
                        )
                      : Icon(
                          const IconData(0xf7ac,
                              fontFamily: CupertinoIcons.iconFont,
                              fontPackage: CupertinoIcons.iconFontPackage),
                          color: CupertinoColors.systemGrey,
                        ),
                  onPressed: () {
                    setState(() {
                      _horizontalScroll = !_horizontalScroll;
                    });
                  },
                )
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          _tags,
        ],
      ),
    );
  }

  // Tập hợp các tags
  Widget get _tags {
    return Tags(
      key: Key('_tags'),
      symmetry: _symmetry,
      horizontalScroll: _horizontalScroll,
      columns: _column,
      textField: _addTag,
      itemCount: _attachedTags.length,
      itemBuilder: (index) {
        final item = _attachedTags[index];
        return GestureDetector(
          child: ItemTags(
            key: Key('_tags' + index.toString()),
            index: index,
            title: item,
            pressEnabled: true,
            activeColor: CupertinoColors.systemGrey2,
            combine: ItemTagsCombine.withTextBefore,
            removeButton: ItemTagsRemoveButton(
                backgroundColor: CupertinoColors.white.withOpacity(0.5),
                onRemoved: () {
                  setState(() {
                    _attachedTags.removeAt(index);
                  });
                  return true;
                }),
            textScaleFactor:
                utf8.encode(item.substring(0, 1)).length > 2 ? 0.8 : 1,
            textStyle: TextStyle(fontSize: _fontSize),
          ),
        );
      },
    );
  }

  // Thêm một tag
  TagsTextField get _addTag {
    return TagsTextField(
        autofocus: false,
        textStyle: TextStyle(fontSize: _fontSize),
        enabled: true,
        maxLength: 20,
        onSubmitted: (value) {
          setState(() {
            _attachedTags.add(value);
          });
        },
        constraintSuggestion: false,
        suggestionTextColor: CupertinoColors.systemBlue,
        suggestions: _suggestionTags);
  }
}
