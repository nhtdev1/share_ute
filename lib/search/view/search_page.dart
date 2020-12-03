import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_ute/main_screen/main_screen.dart';

class SearchPage extends SearchDelegate<String> {
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
        onPressed: () {
          query = '';
        },
      ),
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
    final results = Suggestion.stringSuggestions
        .where((element) => element.toLowerCase().contains(query));
    final suggestions = Suggestion.suggestions;
    return query.trim() == ''
        ? NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    return AttachedTags();
                  }, childCount: 1),
                )
              ];
            },
            body: ListView(
              children: suggestions
                  .map<ListTile>((a) => a.enable == false
                      ? ListTile(
                          title: Text(
                            a.title,
                          ),
                          onTap: () {},
                        )
                      : ListTile(
                          title: Text(
                            a.title,
                          ),
                          leading: a.icon,
                          onTap: () {},
                        ))
                  .toList(),
            ),
          )
        : ListView(
            children: results
                .map<ListTile>((a) => ListTile(
                      title: Text(
                        a.toString(),
                        style: TextStyle(color: CupertinoColors.systemBlue),
                      ),
                      onTap: () {
                        query = a;
                      },
                    ))
                .toList(),
          );
  }
}
