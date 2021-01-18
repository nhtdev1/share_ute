import 'package:flutter/material.dart';
import 'package:share_ute/search_options/search_options.dart';
import 'package:share_ute/search_owner_tags/search_owner_tags.dart';
import 'package:share_ute/search_popular_tags/search_popular_tags.dart';

class SearchPremiumForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 0.1))),
      child: ExpansionTile(
        title: Text('Tìm kiếm theo tag'),
        children: [
          SearchPopularTagsPage(),
          Divider(),
          SearchOptionsPage(),
          Divider(),
          SearchOwnerTagsPage(),
        ],
      ),
    );
  }
}
