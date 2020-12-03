import 'package:flutter/material.dart';
import 'package:share_ute/data/posts.dart';
import 'package:share_ute/widgets/post.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ignore: todo
    // TODO: implement build
    throw UnimplementedError();
  }
}

class HomeScreenPage extends StatefulWidget {
  final String title;

  HomeScreenPage({Key key, this.title}) : super(key: key);
  @override
  _HomeScreenPage createState() => _HomeScreenPage();
}

class _HomeScreenPage extends State<HomeScreenPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          itemCount: tempPosts.length,
          itemBuilder: (_, index) {
            return Container(
              child: PostWidget(
                post: tempPosts[index],
              ),
            );
          }),
    );
  }
}
