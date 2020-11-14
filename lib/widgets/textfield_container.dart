import 'package:flutter/material.dart';

class TextFieldContainer extends StatelessWidget {
  final Widget child;
  final borderRadius;
  final backColor;
  final width;
  const TextFieldContainer(
      {Key key,
      this.child,
      this.borderRadius = 29.0,
      this.backColor,
      this.width = 0.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: width > 0.0 ? width : size.width * 0.8,
      decoration: BoxDecoration(
        color: backColor != null ? backColor : Color(0xffDDEDF7),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: child,
    );
  }
}
