import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:share_ute/add_tags_screen/add_tags_screen.dart';

class AddTagsPage extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      CupertinoButton(
        child: Icon(
          const IconData(0xf71e,
              fontFamily: CupertinoIcons.iconFont,
              fontPackage: CupertinoIcons.iconFontPackage),
          color: CupertinoColors.systemGrey,
        ),
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return CupertinoButton(
      child: Icon(
        const IconData(0xf4fd,
            fontFamily: CupertinoIcons.iconFont,
            fontPackage: CupertinoIcons.iconFontPackage),
        color: CupertinoColors.systemGrey,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container(
        child:  ListView(
          children: TagSuggestion.suggestions
              .map<ListTile>((e) => e.type == TagSuggestionType.DIVIDER
              ? ListTile(
            title: Text(e.title),
          )
              : e.type == TagSuggestionType.YEAR
              ? ListTile(
            title: Text(e.title),
            leading: e.icon,
            onTap: () {
              showYearsPicker(context, e);
            },
          )
              : e.type == TagSuggestionType.LECTURER
              ? Column(
            children: [
              Text(e.title),
              TextFormField(
                maxLines: 10,
                minLines: 10,
                decoration:
                InputDecoration(hintText: 'Nguyễn Văn A'),
              )
            ],
          )
              : ListTile(
            title: Text(e.title),
            onTap: () {},
          ))
              .toList(),
        ));
  }

  showYearsPicker(BuildContext context, TagSuggestion tagSuggestion) {
    Picker(
        adapter: PickerDataAdapter<String>(pickerdata: years),
        hideHeader: true,
        title: Text('Chọn năm của tài liệu'),
        onConfirm: (picker, value) {
          // print(value.toString());
          // tagSuggestion.title = picker.adapter.text.toString();
          // tagSuggestion.title =
          //     tagSuggestion.title.substring(1, tagSuggestion.title.length - 1);
        }).showDialog(context);
  }

  List<String> years = [
    "Năm 2013 - 2014",
    "Năm 2014 - 2015",
    "Năm 2015 - 2016",
    "Năm 2016 - 2017",
    "Năm 2017 - 2018",
    "Năm 2018 - 2019",
    "Năm 2019 - 2020",
    "Năm 2020 - 2021"
  ];
}
