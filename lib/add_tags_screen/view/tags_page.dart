import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_ute/add_tags_screen/add_tags_screen.dart';
import 'package:share_ute/add_tags_screen/bloc/tag_bloc.dart';

class TagsPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => TagsPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tag Document',
          style: TextStyle(color: CupertinoColors.systemGrey),
        ),
        backgroundColor: CupertinoColors.white,
        actions: [
          CupertinoButton(
            child: Text('DONE'),
          )
        ],
        leading: CupertinoButton(
          child: Icon(
            const IconData(0xf4fd,
                fontFamily: CupertinoIcons.iconFont,
                fontPackage: CupertinoIcons.iconFontPackage),
            color: CupertinoColors.systemGrey,
          ),
          onPressed: () {
            Navigator.pop(context, false);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: BlocProvider(
          create: (context){
            return TagBloc();
          },
          child: TagsView(),
        ),
      ),
    );
  }
}
