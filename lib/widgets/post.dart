import 'package:flutter/material.dart';
import 'package:share_ute/models/post.dart';

class PostWidget extends StatelessWidget {
  final Post post;

  PostWidget({Key key, this.post}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return null;
  }
}

class PostWidgetPage extends StatefulWidget {
  final String title;
  final Post post;

  PostWidgetPage({Key key, this.title, this.post}) : super(key: key);

  @override
  _PostWidgetPageState createState() => _PostWidgetPageState();
}

class _PostWidgetPageState extends State<PostWidgetPage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
