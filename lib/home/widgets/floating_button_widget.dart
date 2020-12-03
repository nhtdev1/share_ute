import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_ute/create_folder_and_post/create_folder_and_post.dart';

class FloatingButtonWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: FloatingActionButton(
        backgroundColor: Colors.white,
        elevation: 2.0,
        child: RadiantGradientMask(
          child: Icon(
            const IconData(
              0xf489,
              fontFamily: CupertinoIcons.iconFont,
              fontPackage: CupertinoIcons.iconFontPackage,
            ),
            size: 30.0,
          ),
        ),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (_) => CreateFolderAndPostPage(),
          );
        },
      ),
    );
  }

}

class RadiantGradientMask extends StatelessWidget {
  RadiantGradientMask({this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment(0.8, 0.0),
        colors: [const Color(0xffee0000), const Color(0xffeeee00)],
        tileMode: TileMode.repeated,
      ).createShader(bounds),
      child: child,
    );
  }
}