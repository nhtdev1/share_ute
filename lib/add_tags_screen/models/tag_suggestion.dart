import 'package:flutter/cupertino.dart';

class TagSuggestion {
  TagSuggestion({this.icon, this.title, this.code, this.type});

  Icon icon;
  String title;
  String code;
  TagSuggestionType type;
  static final suggestions = [
    TagSuggestion(type: TagSuggestionType.DIVIDER, title: 'Năm'),
    TagSuggestion(
        type: TagSuggestionType.YEAR,
        icon: Icon(const IconData(
          0xf8b6,
          fontFamily: CupertinoIcons.iconFont,
          fontPackage: CupertinoIcons.iconFontPackage,
        )),
        title: 'Năm 2020 - 2021'),
    TagSuggestion(type: TagSuggestionType.DIVIDER, title: 'Số tín chỉ'),
    TagSuggestion(
        type: TagSuggestionType.CREDIT,
        icon: Icon(const IconData(
          0xf616,
          fontFamily: CupertinoIcons.iconFont,
          fontPackage: CupertinoIcons.iconFontPackage,
        )),
        title: '3TC'),
    TagSuggestion(type: TagSuggestionType.DIVIDER, title: 'Ngành'),
    TagSuggestion(
        type: TagSuggestionType.MAJOR,
        icon: Icon(const IconData(
          0xf59f,
          fontFamily: CupertinoIcons.iconFont,
          fontPackage: CupertinoIcons.iconFontPackage,
        )),
        title: 'Ngành CNTT'),
    TagSuggestion(
        type: TagSuggestionType.MAJOR,
        icon: Icon(const IconData(
          0xf59f,
          fontFamily: CupertinoIcons.iconFont,
          fontPackage: CupertinoIcons.iconFontPackage,
        )),
        title: 'Kỹ thuật dữ liệu'),
    TagSuggestion(
        type: TagSuggestionType.DIVIDER, title: 'Giảng viên vụ trách'),
  ];
}

enum TagSuggestionType { DIVIDER, MAJOR, YEAR, LECTURER, CREDIT }
